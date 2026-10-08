<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hashids — agent index

Generates **short, unique, reversible IDs from integers** (YouTube-like — obscure sequential IDs in URLs).
`hashids_hash_field` submodule; provides permissions. Version **2.0.0**. Core `^8||^9||^10||^11`.

**Security:** Hashids is **obfuscation, NOT encryption** — the mapping is **reversible** (decodable; the salt
is not a secret key). **Do not rely on it for access control / anti-IDOR / anti-enumeration** — enforce
access via proper permission/entity checks. Tidier IDs only, not a security boundary. No access role.
