<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# sshkey — field API & validation

## Field type `sshkey_default`
Properties (`SshKeyItem::propertyDefinitions`):
- `value` (string, required) — raw `"<algorithm> <base64key> <comment>"`.
- `fingerprint` (string, required, **internal**) — `SHA256:<base64>`, set automatically.
- `name` (string) — nickname; auto-derived from the key comment when left blank.

## Per-field settings
- `algorithm` — checkboxes allowlist among `ssh-rsa`, `ssh-dss`, `ssh-ed25519`.
- `min_rsa_bits` — integer floor for the RSA modulus (default 2048; 0 disables; only affects `ssh-rsa`).

## Validation (`SshKeyConstraintValidator`)
1. Algorithm must be in the field allowlist.
2. Key must base64-decode.
3. Decoded bytes must begin with `pack('N', strlen($alg)) . $alg`.
4. `phpseclib3\Crypt\PublicKeyLoader::load()` must parse the full wire format.
5. For `ssh-rsa`, modulus bit length must be >= `min_rsa_bits`.

## Utils helper (`Drupal\sshkey\Utils`)
- `Utils::initialize($value)` → splits into algorithm/key/comment.
- `getFingerprintSha256()` → OpenSSH-style SHA-256 fingerprint.
- `getRsaModulusBitLength()` → RSA bit length, or 0 if not RSA/unparseable.

## Normalization (`SshKeyItem::onChange`)
Value: `trim(preg_replace('/[\x00-\x1F\x7F]/', ' ', $value))`.
Name: control/whitespace runs collapsed to single spaces via `normalizeName()`.
