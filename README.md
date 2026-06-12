# File Encryption Tool

## Overview
This project implements a secure file encryption tool written in Bash, using OpenSSL to perform AES‑256‑CBC encryption and decryption.
The tool includes:
- Secure key generation
- Optional user‑provided keys
- SHA‑256 integrity verification
- Error handling for invalid inputs
- A help menu for ease of use

The repository also contains all weekly documentation, design notes, testing results, and the final project report.

---

## Features
- **AES‑256‑CBC encryption & decryption**
- **Automatic or user‑provided key support**
- **Secure key storage (chmod 600)**
- **SHA‑256 integrity verification**
- **User‑friendly CLI with -h help menu**
- **Error handling for:**
  - Missing files
  - Incorrect keys
  - Permission issues
  - Invalid arguments
 
---

## System Requirements
- Ubuntu 24.04+
- Bash
- OpenSSL
Install OpenSSL if needed:
```bash
sudo apt update
sudo apt install openssl
```

---

## Installation
Clone the repository:
```bash
git clone https://github.com/Justin-L293/file-encryption-tool.git
cd file-encryption-tool
```

Make the script executable:
```bash
chmod +x scripts/encryption_tool.sh
```

---

## Usage
**Encrypt a file**
```bash
./scripts/encryption_tool.sh -e -f input.txt -o encrypted.enc
```

**Decrypt a file**
```bash
./scripts/encryption_tool.sh -d -f encrypted.enc -o decrypted.txt -k <key>
```

**Show help menu**
```bash
./scripts/encryption_tool.sh -h
```

---

## Project Structure
```
file-encryption-tool/
│
├── README.md
│
├── scripts/
│   └── encryption_tool.sh
│
├── docs/
│   ├── week1_planning.md
│   ├── week2_encryption_algorithms.md
│   ├── week3_key_management.md
│   ├── week4_vulnerabilities.md
│   ├── week5_design.md
│   ├── week6_basic_script.md
│   ├── week7_encryption_features.md
│   ├── week8_usability.md
│   ├── week9_security_features.md
│   ├── week10_testing.md
│   ├── week11_documentation.md
│   └── week12_final_review.md
│
├── design/
│   ├── ui_ux.md
│   ├── flowchart_outline.md
│   └── technical_specifications.md
│
├── testing/
│   └── test_cases.md
│
└── report/
    └── project_report.md
```

---

## Development Timeline
The full 12‑week breakdown is documented in ```/docs/.```

Summary:
- Week 1: Planning
- Week 2: Encryption algorithm research
- Week 3: Key management
- Week 4: Vulnerability research
- Week 5: Tool design
- Week 6: Basic script structure
- Week 7: Encryption functionality
- Week 8: Usability improvements
- Week 9: Security enhancements
- Week 10: Testing & debugging
- Week 11: Documentation
- Week 12: Final review & submission

---

## Security Considerations
- Uses **AES‑256‑CBC**, a strong industry‑standard cipher
- Keys generated with openssl rand -base64 32
- Keys stored with **600 permissions**
- SHA‑256 integrity verification
- Avoids insecure modes like ECB
- Validates file permissions and paths

---

## Testing
Testing documentation is located in:
```
/testing/test_cases.md
```
Includes:
- Valid/invalid key tests
- File corruption tests
- Permission handling
- Large file performance
- Integrity verification

---

## Documentation
All project documentation is located in:
```
/docs
/design
/report
```
---

## License
MIT License
