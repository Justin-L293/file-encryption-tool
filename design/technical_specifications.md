# Technical Specifications

## Overview
This document defines the technical architecture, algorithms, workflow, and security model of the **File Encryption Tool**, implemented as a Bash script using OpenSSL’s AES‑256‑CBC encryption.

This specification supports:
- **Flowchart Outline**
- **UI/UX Design**
- **Security Features**

---

## 1. System Environment

| Component | Specification |
|----------|---------------|
| **Operating System** | Linux (Ubuntu 24.04) |
| **Shell** | Bash |
| **Encryption Engine** | OpenSSL (`aes-256-cbc`) |
| **Hashing** | SHA‑256 (for integrity verification) |
| **Supported File Types** | Text and binary files |
| **Script Location** | `scripts/encryption_tool.sh` |

---

## 2. Dependencies

### Required
- **Bash** (default on Linux)
- **OpenSSL**  
  Used for:
  - AES‑256‑CBC encryption/decryption  
  - Secure random key generation (`openssl rand -base64 32`)

### Optional
- `sha256sum` (for integrity verification)

---

## 3. Command‑Line Interface (CLI)

### Usage
```bash
./encryption_tool.sh -e|-d -f <input_file> -o <output_file> [-k <key>] [-h]
```

---


### Arguments

| Flag | Required | Description |
|------|----------|-------------|
| `-e` | Yes* | Encrypt mode |
| `-d` | Yes* | Decrypt mode |
| `-f <file>` | Yes | Input file path |
| `-o <file>` | Yes | Output file path |
| `-k <key>` | No | Encryption/decryption key |
| `-h` | No | Show help menu |

\*Exactly one of `-e` or `-d` must be provided.

---

## 4. Internal Architecture

### Module Breakdown

| Module | Responsibilities |
|--------|------------------|
| **CLI Parser** | Reads flags, validates arguments, displays help |
| **Validation Engine** | Checks file existence, readability, write permissions |
| **Key Manager** | Generates or accepts user‑provided keys; stores securely |
| **Encryption Engine** | AES‑256‑CBC encryption using OpenSSL |
| **Decryption Engine** | AES‑256‑CBC decryption + empty‑file detection |
| **Integrity Checker** | SHA‑256 hash comparison (Week 9 feature) |
| **Error Handler** | Standardized error messages and exit codes |

---

## 5. Workflow (Based on Week 5 + Week 11 Flowcharts)

### 5.1 Encryption Workflow
1. Prompt user for file path  
2. Validate file exists and is readable  
3. Ask user to generate or provide a key  
4. If no key → generate 32‑byte Base64 key  
5. Encrypt using:  
```
openssl enc -aes-256-cbc -salt -in <input> -out <output> -k <key>
```
6. Save encrypted file with `.enc` extension  
7. Generate SHA‑256 hash for integrity  
8. Output success message  
9. Offer to encrypt another file  

### 5.2 Decryption Workflow
1. Prompt user for file path  
2. Validate file exists and is readable  
3. Require user to provide key  
4. Decrypt using:  
```
openssl enc -d -aes-256-cbc -in <input> -out <output> -k <key>
```
5. Check if decrypted file is non‑empty  
6. If hash exists → verify integrity  
7. Output success or warning  
8. Offer to decrypt another file  

---

## 6. Cryptography Details

### 6.1 Encryption Algorithm
- **AES‑256‑CBC**
- 256‑bit key
- Random salt added automatically by OpenSSL
- Suitable for large files

### 6.2 Key Generation
```
openssl rand -base64 32
```
- Produces a 256‑bit Base64 key  
- Displayed once to the user  
- Stored securely with `chmod 600` when saved to a file  

### 6.3 Integrity Verification (Week 9)
- SHA‑256 hash generated during encryption  
- Stored in a `.hash` file  
- During decryption:  
  - Compute new hash  
  - Compare to stored hash  
  - Output “verified” or “warning: mismatch”

---

## 7. Error Handling

| Error Type | Trigger | Script Behavior |
|------------|---------|-----------------|
| Invalid file path | File missing or unreadable | Display error + exit |
| No write permission | Output directory unwritable | Display error + exit |
| Missing arguments | Flags not provided | Show help menu |
| Invalid key | Wrong or missing key | Display error |
| Encryption failure | OpenSSL error | Display error |
| Decryption failure | Wrong key or corrupted file | Display detailed reasons |
| Integrity mismatch | Hash mismatch | Show warning |

---

## 8. Security Considerations

### Implemented
- AES‑256‑CBC (strong symmetric encryption)
- Secure random key generation
- SHA‑256 integrity verification
- Key stored with `chmod 600`
- No plaintext key logging
- Salt added automatically by OpenSSL
- Validates file permissions before processing

### Recommended Future Enhancements
- Switch to AES‑256‑GCM (authenticated encryption)
- Store keys in a dedicated key vault
- Add passphrase‑protected key files
- Add digital signatures for authenticity

---

## 9. Performance Characteristics

| Metric | Expected |
|--------|----------|
| Encryption speed | Fast (OpenSSL optimized) |
| Decryption speed | Fast |
| Memory usage | Minimal (stream‑based) |
| Max file size | Limited only by disk space |

---

## 10. File Output Rules

| Operation | Output Format |
|-----------|----------------|
| Encryption | `<filename>.enc` |
| Decryption | `<filename>.dec` or original name |
| Hash file | `<filename>.hash` |
| Key file | `encryption_key.txt` (600 permissions) |

---

## Summary
This specification defines the complete technical behavior of the File Encryption Tool, including architecture, cryptography, CLI design, workflow, and security features.  
It reflects the implementation described in Weeks 5–11 and should be updated as new features are added.


