# File Encryption Tool – Final Project Report
**Author:** Justin Ly  
**date** 12/13/24
---

# 1. Executive Summary
This project focuses on designing and implementing a secure **file encryption and decryption tool** using Bash and OpenSSL. Over the course of 12 weeks, the project progressed through research, design, implementation, testing, and documentation phases. The final tool allows users to encrypt and decrypt files using AES‑256‑CBC, manage encryption keys, verify file integrity, and interact through a user‑friendly command‑line interface.

The project demonstrates an understanding of encryption algorithms, key management, secure design principles, and practical scripting. The final deliverable is a functional, secure, and well‑documented encryption tool suitable for real‑world use.

---

# 2. Introduction
Data security is a critical concern in modern computing. Encryption protects sensitive information from unauthorized access, ensuring confidentiality and integrity. This project aims to create a simple yet secure file encryption tool that users can run on Linux systems.

### Project Goals
- Implement AES‑256‑CBC encryption and decryption  
- Provide secure key generation and management  
- Ensure strong error handling and input validation  
- Create a user‑friendly CLI  
- Document the entire development process  

---

# 3. Background Research

## 3.1 Encryption Algorithms
Research in Week 2 covered symmetric and asymmetric encryption, including AES, DES, RSA, ECC, and Diffie‑Hellman. AES‑256‑CBC was selected due to its:
- High security  
- Efficiency  
- Suitability for large files  
- Strong industry adoption  

## 3.2 Key Management
Week 3 research covered:
- PRNG vs TRNG  
- RSA and ECC key generation  
- Key derivation functions  
- Secure storage methods (KMS, HSM, encrypted key files)  
- Best practices such as key rotation and least privilege  

## 3.3 Vulnerabilities
Week 4 research identified common weaknesses:
- Outdated algorithms (DES, MD5, SHA‑1)  
- Hardcoded keys  
- Weak key generation  
- Insecure cipher modes (ECB)  
- Metadata leakage  
- Side‑channel attacks  

Case studies (Adobe, Equifax, Yahoo) reinforced the importance of:
- Strong key management  
- Modern algorithms  
- Proper hashing  
- Avoiding single points of failure  

---

# 4. Design Phase

## 4.1 UI/UX Design
The tool uses a simple CLI with:
- Clear prompts  
- Error messages  
- Success confirmations  
- Help menu (`-h`)  
- Minimal required inputs  

## 4.2 Flowcharts
Two flowcharts were created:

- **Week 5:** Initial encryption process outline  
- **Week 11:** Full encryption/decryption workflow  

These diagrams guided the structure of the script and ensured logical consistency.

## 4.3 Technical Design
The tool uses:
- Bash for scripting  
- OpenSSL for AES‑256‑CBC  
- SHA‑256 for integrity verification  
- Secure key generation via `openssl rand -base64 32`  

---

# 5. Implementation

## 5.1 Development Environment
- Ubuntu 24.04  
- Bash shell  
- OpenSSL installed via package manager  

## 5.2 Script Architecture
The script includes:
- CLI argument parsing  
- File validation  
- Key generation and storage  
- Encryption and decryption logic  
- Integrity verification  
- Error handling  
- Help menu  

## 5.3 Encryption Logic
```
openssl enc -aes-256-cbc -salt -in "$input_file" -out "$output_file" -k "$key"
```

## 5.4 Decryption Logic
```
openssl enc -d -aes-256-cbc -in "$input_file" -out "$output_file" -k "$key"
```


## 5.5 Key Management
- Auto‑generate key if none provided  
- Store key in `encryption_key.txt`  
- Restrict permissions with `chmod 600`  

## 5.6 Integrity Verification
- Generate SHA‑256 hash during encryption  
- Compare hash during decryption  
- Warn user if mismatch detected  

---

# 6. Testing

## 6.1 Test Plan
Week 10 involved:
- Functional tests  
- Error handling tests  
- Permission tests  
- Key validation tests  
- Integrity verification tests  

## 6.2 Test Cases
Examples:
- Encrypt valid file  
- Decrypt with correct key  
- Decrypt with incorrect key  
- Missing arguments  
- Invalid file path  
- No write permissions  

## 6.3 Results
- All core features worked as expected  
- Incorrect keys produced appropriate errors  
- Integrity verification correctly detected mismatches  
- Help menu displayed correctly  
- No major bugs remained after fixes  

---

# 7. Results

### What Works
- AES‑256‑CBC encryption/decryption  
- Automatic key generation  
- Secure key storage  
- SHA‑256 integrity verification  
- User‑friendly CLI  
- Strong error handling  

### What Could Be Improved
- No authenticated encryption (AES‑GCM)  
- No GUI  
- No key rotation system  
- No cloud integration  

---

# 8. Conclusion
This project successfully produced a secure, functional file encryption tool. Through 12 weeks of research, design, coding, and testing, the project demonstrates strong understanding of encryption, key management, secure design, and Bash scripting.

The final tool is reliable, easy to use, and well‑documented. The project also highlights areas for future improvement, such as adding AES‑GCM, GUI support, and advanced key management.

---

# 9. Future Improvements
- Switch to AES‑256‑GCM for authenticated encryption  
- Add GUI interface  
- Implement key rotation  
- Add cloud storage support  
- Add digital signatures  
- Improve metadata protection  

---

# 10. Appendices

## Appendix A – Full Script
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

## Appendix B – Flowcharts
- Week 5 flowchart
<img width="3120" height="2254" alt="Blank diagram (2)" src="https://github.com/user-attachments/assets/c2c738e4-6bef-47c8-b115-8c8c4c2bbaa7" />

- Week 11 flowchart  
<img width="975" height="895" alt="image" src="https://github.com/user-attachments/assets/68390ef2-1158-46f5-8a8c-15d72ff0494f" />

## Appendix C – Sample Output

This appendix provides real examples of the tool’s output during encryption, decryption, and error handling. These samples demonstrate correct functionality, user feedback, and error messaging.

---

### 1. Encryption Success Message
```
Generated encryption key: HfidJ2cpGSxJDOQjHK2Wm4nS1sgBnMjMsk2nhUbAY=
Keep this key secure! You’ll need it to decrypt the file.
*** WARNING: deprecated key derivation used.
Using -iter or -pbkdf2 would be better.
File encrypted successfully to 'test_output.txt'.
Hash stored in 'test_output.txt.hash' for integrity verification.
```

---

### 2. Decryption Success Message
```
File decrypted successfully to 'decrypted.txt'.
Decryption verified.
```


---

### 3. Decryption Warning (Empty File)
```
Warning: Decryption complete, but the file is empty. Verify your encryption key.
```

---

### 4. Decryption Failure Example
```
Error: Decryption failed. Possible reasons:
- Incorrect encryption key.
- Corrupted or modified encrypted file.
= Inconsistent encryption/decryption modes.
```

---

### 5. Invalid File Path Error
```
Error: The file 'missing.txt' does not exist or cannot be read.
```

---

### 6. Missing Arguments Error
```
Error: Missing arguments. Ensure both (-e or -d), input file, and output file are specified.
Usage: encryption_tool.sh -e|-d -f <input_file> -o <output_file> [-k <key>]
```

---

### 7. Encrypted File Preview (Binary Output Example)
```
Salted__+<z1i8&0_oY y2$#9q7~o(+WgBW|(@e@@@w
```

---

## Appendix D – Project Notes Document
The full weekly project notes, research summaries, and development logs used throughout the 12‑week project are available in the following document:

**Project Notes:**  
[Justin Ly CIS 140 Project Notes.docx](https://github.com/user-attachments/files/28902775/Justin.Ly.CIS.140.Project.Notes.docx)

This document contains:
- Weekly objectives and tasks  
- Research on encryption algorithms  
- Key management notes  
- Vulnerability analysis  
- UI/UX planning  
- Script development progress  
- Testing notes  
- Documentation planning  

It serves as the complete development log for the project and provides additional detail beyond what is summarized in this report.

