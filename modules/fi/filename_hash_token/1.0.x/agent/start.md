<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filename Hash Token (filename_hash_token) — agent index

**Adds file tokens for an md5 hash of the filename and configurable substrings of it.**

- **Version:** 1.0.x (1.0.1)
- **Core:** ^8.8 || ^9 || ^10 || ^11
- **Dependency:** file (>= 8.8.0)
- **Tokens (type `file`):** `[file:name-hash]` (full md5 of basename); `[file:name-hash-substring:LEN]` and `[file:name-hash-substring:LEN,OFFSET]` (dynamic; LEN must be numeric ≤ 32, bad OFFSET → 0).
- **Impl:** `filename_hash_token.tokens.inc` (`hook_token_info` / `hook_tokens`); no config, no routes, no permissions.
- **Typical pairing:** File (Field) Paths, to bucket uploads into hashed subdirectories.

**Security:** no routes/permissions/state; the hash is a plain md5 of the filename for path distribution, not a security/integrity primitive (unsalted, filename-based).

See [api/tokens.md](api/tokens.md).
