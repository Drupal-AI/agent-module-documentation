<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SSH Key provides an `sshkey_default` field type for storing OpenSSH **public** keys on any fieldable Drupal entity (users, nodes, custom entities), configured through the Field UI like any core field.

---

The problem it solves is capturing and validating SSH public keys as first-class field data instead of free-form text. Each field can allowlist accepted algorithms (`ssh-rsa`, `ssh-dss`, `ssh-ed25519`) and enforce a minimum RSA modulus length (default 2048 bits). Validation is layered: the value is base64-decoded, checked for the correct algorithm wire-format prefix, and finally parsed by phpseclib3 (`PublicKeyLoader::load`) so truncated, curve-invalid, or malformed payloads are rejected (`src/Plugin/Validation/Constraint/SshKeyConstraintValidator.php`). On save the item derives and stores an OpenSSH-style SHA-256 fingerprint (`SHA256:<base64>`, matching `ssh-keygen -lf`) and an editable `name` taken from the key comment.

Security posture is favourable: the module stores only public keys (no private-key material), ships **no** permissions or routes of its own, and access to a stored key follows the host entity's field access. Notably, `onChange()` normalizes the raw value and name — control characters (C0 range, DEL) are collapsed to spaces to block newline-injection, NUL-truncation, and ANSI-escape tricks against downstream consumers and admin log views. The value column is capped at 16384 bytes. There is no uniqueness constraint on the fingerprint, so duplicate keys are allowed unless you add your own validator. Typical setup: add an SSH Key field to an entity bundle, choose allowed algorithms and the minimum RSA bit length, then use the fingerprint/name formatters for display.
---
- Add an SSH Key field to a user bundle to collect deploy keys.
- Add an SSH Key field to a custom entity for server-access records.
- Restrict a field to `ssh-ed25519` only via the algorithm allowlist.
- Allow `ssh-rsa` and `ssh-ed25519` but forbid the weaker `ssh-dss`.
- Enforce a 4096-bit minimum RSA modulus on a high-security field.
- Set `min_rsa_bits` to 0 to disable the RSA size floor.
- Reject malformed or truncated keys automatically via phpseclib parsing.
- Display the stored SHA-256 fingerprint with the fingerprint formatter.
- Display the human name (key comment) with the name formatter.
- Expose `value`, `fingerprint`, and `name` as separate Views fields.
- Derive an auto-generated name from the key's embedded comment.
- Normalize pasted keys that contain stray control characters.
- Cap oversized key blobs at 16 KB to protect storage.
- Store multiple keys per entity using field cardinality.
- Build a Twig template that prints only the fingerprint of a key.
- Generate sample SSH-key field values for test content.
- Validate imported keys in a migration by reusing the field constraint.
- Compute a key's RSA bit length programmatically via `Utils::getRsaModulusBitLength()`.
- Parse an arbitrary key string into algorithm/key/comment with `Utils::initialize()`.
- Index entities by fingerprint using the built-in fingerprint DB index.
