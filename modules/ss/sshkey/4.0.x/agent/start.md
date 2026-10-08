<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SSH Key (sshkey) — agent index

**Provides an `sshkey_default` field type for storing and validating OpenSSH public keys on fieldable entities.**

- **Version:** 4.0.x (4.0.0-alpha7)
- **Core:** ^10.3 || ^11 || ^12
- **Dependencies:** drupal:field; composer requires `phpseclib/phpseclib:^3.0`
- **Field type:** `sshkey_default` (properties: `value`, `fingerprint` internal, `name`)
- **Widget:** `sshkey_textarea` · **Formatters:** `sshkey_fingerprint`, `sshkey_name`
- **Per-field settings:** `algorithm` allowlist (ssh-rsa/ssh-dss/ssh-ed25519), `min_rsa_bits` (default 2048)
- **Key classes:** `Utils` (parse/fingerprint/RSA bits), `SshKeyConstraintValidator` (algorithm + phpseclib structural validation)

**Security:** No routes and no permissions; access follows host-entity field access. Stores public keys only (no private material). Values/names are control-character-normalized on save to block newline/NUL/ANSI injection into downstream consumers. Value length capped at 16 KB; no fingerprint uniqueness constraint.

See [api/field.md](api/field.md).
