# UI/UX Design – File Encryption Tool

## Overview
This document describes the User Interface (UI) and User Experience (UX) design of the File Encryption Tool.  
The tool is a Bash-based command-line application that allows users to encrypt and decrypt files using AES‑256‑CBC.  
The UI focuses on clarity and simplicity, while the UX emphasizes ease of use, error prevention, and helpful feedback.

---

## 1. User Interface (UI)

The tool uses a **text-based command-line interface (CLI)**.  
All interactions occur through terminal prompts, flags, and output messages.

### 1.1 Inputs & Prompts
The script prompts the user for:

- **File path**  
  Example:
```
  -f <input_file>
```
- **Operation mode**
```
-e   Encrypt
-d   Decrypt
```

- **Output file path**
```
-o <output_file>
```

- **Key (optional for encryption, required for decryption)**  
```
-k <key>
```

### 1.2 Output Messages
The UI provides clear, readable feedback:

#### Progress Messages
```
Encrypting file… Please wait…
File encrypted successfully.
```

#### Success Messages
```
File decrypted successfully to 'decrypted.txt'.
Decryption verified.
```

#### Error Messages
```
Error: The file 'missing.txt' does not exist or cannot be read.
Error: Missing arguments. Ensure mode (-e or -d), input file, and output file are specified.
```

### 1.3 Help Menu
The `-h` flag displays usage instructions:

Usage: encryption_tool.sh -e|-d -f <input_file> -o <output_file> [-k <key>]

Options:
-e        Encrypt the file
-d        Decrypt the file
-f <file> Input file to be encrypted or decrypted
-o <file> Output file for encrypted or decrypted content
-k <key>  Encryption key (optional, generates a new key if not provided)
-h        Shows this help message


This ensures users always know how to operate the tool.

---

## 2. User Experience (UX)

The UX design focuses on **simplicity**, **clarity**, and **error prevention**.

### 2.1 Simple, Guided Workflow
The tool guides the user through a predictable sequence:
- 1. Provide input file  
- 2. Choose encrypt or decrypt  
- 3. Provide or generate key  
- 4. Receive feedback  
- 5. View output  

This reduces confusion and prevents mistakes.

### 2.2 Minimal Required Inputs
Users only need to provide:

- Mode (`-e` or `-d`)
- Input file (`-f`)
- Output file (`-o`)

The tool handles everything else automatically, including:

- Key generation  
- Hash creation  
- Integrity verification  

### 2.3 Helpful Error Handling
The script detects and explains common mistakes:

- Missing arguments  
- Invalid file paths  
- No write permissions  
- Incorrect decryption key  
- Empty decrypted file  

Each error includes guidance on how to fix the issue.

### 2.4 Automation for Better UX
To reduce user burden:

- A secure key is automatically generated if none is provided  
- Keys are stored with restricted permissions  
- Hash files are created automatically  
- Decryption verifies integrity without user input  

### 2.5 Clear, Consistent Messaging
All messages follow a consistent style:

- Short  
- Direct  
- Informative  
- Actionable  

Example:
```
Warning: Decryption complete, but the file is empty. Verify your encryption key.
```


---

## 3. Design Decisions

### 3.1 Why a CLI?
- Works on all Linux systems  
- Lightweight and fast  
- Ideal for scripting and automation  
- No GUI dependencies  
- Matches course requirements  

### 3.2 Why AES‑256‑CBC?
- Strong industry-standard encryption  
- Supported by OpenSSL  
- Efficient for large files  
- Easy to implement in Bash  

### 3.3 Why Automatic Key Generation?
- Prevents weak or reused keys  
- Improves security  
- Simplifies user workflow  

---

## 4. Future UI/UX Improvements

- Add a **menu-based interface** (ncurses)  
- Add a **GUI version** using Python or Electron  
- Add **color-coded output** for warnings and errors  
- Add **progress bars** for large files  
- Add **interactive prompts** instead of flags  

---

## Summary
The UI/UX design of the File Encryption Tool focuses on clarity, simplicity, and security.  
By using a clean CLI, helpful prompts, and automated features, the tool provides a smooth and intuitive experience for users while maintaining strong encryption practices.
