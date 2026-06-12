# Week 4 – File Encryption Vulnerabilities

## Objective
Identify common vulnerabilities in encryption tools and learn from real‑world breaches.

## Vulnerabilities Studied
- Weak/outdated algorithms (MD5, SHA‑1, RC4)
- Hardcoded keys
- Weak key generation
- Key reuse
- Insecure modes (ECB, improper CBC)
- Metadata leakage
- Side‑channel attacks (timing, power analysis)

## Case Studies
### Adobe Breach (2013)
- Used symmetric encryption for passwords.
- Same key used for all users.

### Equifax Breach (2017)
- Keys stored alongside encrypted data.

### Yahoo Breach (2013–2014)
- Used MD5 hashing, easily cracked.

## Secure Design Considerations
- Use strong algorithms (AES‑256, RSA, ECC).
- Avoid deprecated ciphers.
- Implement RBAC.
- Use authenticated encryption (AES‑GCM).
- Encrypt data at rest and in transit.

## Summary
This week highlighted how improper implementation—not just weak algorithms—can compromise encryption systems.

