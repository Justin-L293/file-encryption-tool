# Test Cases – File Encryption Tool

This document outlines the test cases used to verify the functionality, reliability, and security of the file encryption tool. Each test includes the command used, expected output, and actual result.

---

## Test Case 1 – Encrypt a Valid File
**Command:**
```bash
./encryption_tool.sh -e -f test_input.txt -o test_output.enc
```

**Expected Output:**
- Key generated (if not provided)
- Encryption success message
- Hash file created

**Actual Output:**
- Matches expected output

**Result:** PASS

---

## Test Case 2 – Decrypt with Correct Key
**Command:**
```bash
./encryption_tool.sh -d -f test_output.enc -o decrypted.txt -k <key>
```

**Expected Output:**
- File decrypted successfully
- Integrity verified (if hash exists)

**Actual Output:**
- Matches expected output

**Result:** PASS

---

## Test Case 3 – Decrypt with Incorrect Key
**Command:**
```bash
./encryption_tool.sh -d -f test_output.enc -o decrypted.txt -k WRONGKEY
```

**Expected Output:**
- Decryption failure message
- Warning about incorrect key

**Actual Output:**
- Matches expected output

**Result:** PASS

---

## Test Case 4 – Missing Arguments
**Command:**
```bash
./encryption_tool.sh
```

**Expected Output:**
- Error message about missing arguments
- Help menu displayed

**Actual Output:**
- Matches expected output

**Result:** PASS

---

## Test Case 5 – Invalid File Path
**Command:**
```bash
./encryption_tool.sh -e -f missing.txt -o output.enc
```

**Expected Output:**
- Error: file does not exist or cannot be read

**Actual Output:**
- Matches expected output

**Result:** PASS

---

## Test Case 6 – No Write Permission
**Setup:**
Output directory set to a location without write access.

**Command:**
```bash
./encryption_tool.sh -e -f test_input.txt -o /root/output.enc
```

**Expected Output:**
- Error: No write permissions for output directory

**Actual Output:**
- Matches expected output

**Result:** PASS

---

## Test Case 7 – Integrity Verification (Hash Mismatch)
**Setup:**
Modify encrypted file or hash file manually.

**Command:**
```bash
./encryption_tool.sh -d -f test_output.enc -o decrypted.txt -k <key>
```

**Expected Output:**
- Warning: integrity check failed

**Actual Output:**
- Matches expected output

**Result:** PASS

---

## Test Case 8 – Help Menu
**Command:**
```bash
./encryption_tool.sh -h
```

**Expected Output:**
- Help menu with usage instructions and examples

**Actual Output:**
- Matches expected output

**Result:** PASS

---

# Summary
All major functions of the encryption tool were tested, including encryption, decryption, key handling, error handling, and integrity verification. All tests passed successfully, confirming that the tool behaves as expected under normal and error conditions.
