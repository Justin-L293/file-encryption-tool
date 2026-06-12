```bash
#!/bin/bash

# ==========================================
# File Encryption Tool - AES-256-CBC
# ==========================================

# Help Menu
show_help() {
    echo "Usage: $0 -e | -d -f <input_file> -o <output_file> [-k <key>]"
    echo
    echo "Options:"
    echo "  -e            Encrypt the file"
    echo "  -d            Decrypt the file"
    echo "  -f <file>     Input file to be encrypted or decrypted"
    echo "  -o <file>     Output file for encrypted or decrypted content"
    echo "  -k <key>      Encryption key (optional; generates a new key if not provided)"
    echo "  -h            Show this help message"
    echo
    echo "Examples:"
    echo "  Encrypt: $0 -e -f input.txt -o encrypted.enc"
    echo "  Decrypt: $0 -d -f encrypted.enc -o decrypted.txt -k <key>"
    echo
    echo "Note: If no key is provided during encryption, a random key will be generated."
}

# Check OpenSSL installation
if ! command -v openssl &> /dev/null; then
    echo "Error: OpenSSL is not installed. Please install it and try again."
    exit 1
fi

# Variables
mode=""
key=""
input_file=""
output_file=""
key_file="encryption_key.txt"

# Parse arguments
while getopts ":edf:o:k:h" opt; do
    case "$opt" in
        e) mode="encrypt" ;;
        d) mode="decrypt" ;;
        f) input_file="$OPTARG" ;;
        o) output_file="$OPTARG" ;;
        k) key="$OPTARG" ;;
        h) show_help; exit 0 ;;
        *) echo "Invalid option: -$OPTARG"; show_help; exit 1 ;;
    esac
done

# Validate required arguments
if [[ -z "$mode" || -z "$input_file" || -z "$output_file" ]]; then
    echo "Error: Missing required arguments."
    show_help
    exit 1
fi

# Validate input file
if [[ ! -f "$input_file" || ! -r "$input_file" ]]; then
    echo "Error: The file '$input_file' does not exist or cannot be read."
    exit 1
fi

# Validate output directory
if [[ ! -w "$(dirname "$output_file")" ]]; then
    echo "Error: No write permissions for the output file directory."
    exit 1
fi

# Key generation function
generate_key() {
    openssl rand -base64 32
}

# Generate key if not provided
if [[ -z "$key" ]]; then
    key=$(generate_key)
    echo "Generated encryption key: $key"
    echo "Keep this key secure! You'll need it to decrypt the file."
fi

# Store key securely
echo "$key" > "$key_file"
chmod 600 "$key_file"

# Integrity verification function
verify_integrity() {
    local decrypted_file="$1"
    local hash_file="$2"

    stored_hash=$(cat "$hash_file")
    decrypted_hash=$(sha256sum "$decrypted_file" | awk '{print $1}')

    if [[ "$stored_hash" != "$decrypted_hash" ]]; then
        echo "Warning: File integrity check failed. The decrypted file may have been modified."
        return 1
    else
        echo "File integrity verified. The decrypted file matches the original."
        return 0
    fi
}

# Encryption
if [[ "$mode" == "encrypt" ]]; then
    openssl enc -aes-256-cbc -salt -in "$input_file" -out "$output_file" -k "$key"

    if [[ $? -eq 0 ]]; then
        sha256sum "$input_file" | awk '{print $1}' > "${output_file}.hash"
        echo "File encrypted successfully to '$output_file'."
    else
        echo "Error: Encryption failed."
        exit 1
    fi

# Decryption
elif [[ "$mode" == "decrypt" ]]; then
    openssl enc -d -aes-256-cbc -in "$input_file" -out "$output_file" -k "$key"

    if [[ $? -eq 0 ]]; then
        echo "File decrypted successfully to '$output_file'."

        if [[ -f "${input_file}.hash" ]]; then
            verify_integrity "$output_file" "${input_file}.hash"
        fi
    else
        echo "Error: Decryption failed. Possible reasons:"
        echo "1. Incorrect encryption key."
        echo "2. Corrupted or modified encrypted file."
        echo "3. Inconsistent encryption/decryption modes."
        exit 1
    fi
fi
```
