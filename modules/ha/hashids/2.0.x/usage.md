<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Hashids generates short unique ids from integers, useful for obfuscating sequential IDs in URLs.

---

Hashids generates short, unique, YouTube-like IDs from integers using the Hashids algorithm — turning a
numeric ID (e.g. a node ID) into a short string like `Xk9aQ`, commonly used to make URLs/identifiers look
tidier and to avoid exposing raw sequential IDs. It ships a `hashids_hash_field` submodule and provides its
own permissions.

Use it to produce short obfuscated IDs from integers. **Important security note: Hashids is obfuscation, NOT
encryption or a security control.** The mapping is reversible (anyone can decode a hashid back to the integer,
and the salt is not a secret key), so it only *obscures* sequential IDs — it does **not** protect them. Do
**not** rely on hashids to control access or to prevent enumeration/IDOR: an object addressed by a hashid is
still just an integer ID, so access must be enforced by proper permission/entity-access checks, not by the
"unguessability" of the hashid. Use it purely for tidier IDs, not as a security boundary. It has no
access-control role. Configure the salt/alphabet and use the hashid field.

---

- Generate short IDs from integers.
- Produce YouTube-like identifiers.
- Obscure sequential IDs in URLs.
- Provide a hashid field submodule.
- Provide its own permissions.
- KNOW hashids is obfuscation, NOT encryption.
- Understand hashids are reversible (decodable).
- Not rely on hashids for access control.
- Not use hashids to prevent IDOR/enumeration.
- Enforce access via proper permission/entity checks.
- Use hashids only for tidier IDs.
- Have no access-control role.
- Configure the salt/alphabet.
- Use the hashid field.
- Shorten numeric IDs.
- Tidy up identifiers.
- Encode integers.
- Not treat the salt as secret.
- Obscure IDs (not protect).
- Generate short ids.
