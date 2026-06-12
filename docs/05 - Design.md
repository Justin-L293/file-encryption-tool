# Week 5 – Tool Design

## Objective
Design the user interface, workflow, and technical specifications for the encryption tool.

## UI/UX Design
- Simple command‑line interface (CLI)
- Clear prompts and error messages
- Help menu with usage examples
- Minimal required inputs

## Workflow Outline
1. User provides file path.
2. User selects encrypt or decrypt.
3. User provides or generates key.
4. Tool processes file.
5. Tool outputs encrypted/decrypted file.

## Technical Specifications
- OS: Ubuntu 24.04
- Shell: Bash
- Encryption: AES‑256‑CBC (OpenSSL)
- Supports text and binary files
- Error handling for:
  - Invalid paths
  - Missing permissions
  - Incorrect keys

## Summary
Week 5 produced a clear blueprint for how the tool should function and how users will interact with it.

