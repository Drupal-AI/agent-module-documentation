<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Coffre Fort ("safe") is a config entity that stores encrypted private data (secrets) which an operator unlocks with a password or an external secret provider.

---
Each `coffre_fort` entity holds an encrypted per-safe secret key; private-data plugins (SimpleString, Text, Number) are encrypted with that key via `CoffreFortEncryption` (OpenSSL AES-256-CTR). Secret providers pluggably supply the unlock key: `password` (user password, never stored — after unlock a 24h cookie `DRUPAL:CFTOKEN:<uuid>` holds the re-encrypted key, protected by a random state key `coffre_fort.password_encryption_key`), plus Vault and Keycloak/OpenID providers. Routes under `/admin/structure/coffre-fort/...` manage entries and unlock/relock, gated by `administer coffre fort`, `unlock coffre fort` and entity `update` access.

Setup: create a safe, choose a secret provider, add private data, then unlock with the password to read values.
---
- Create a "safe" (coffre_fort) config entity.
- Choose a secret provider (password, Vault, Keycloak).
- Add a secret string, text or number to a safe.
- Unlock a safe with the user password.
- Relock a safe to hide its secrets.
- Store an API token as encrypted private data.
- Expose secrets to other modules via plugins.
- Use tokens for stored private data.
- Grant `administer coffre fort` to secret managers.
- Grant `unlock coffre fort` to operators.
- Keep the unlock password out of storage.
- Set a 24h unlock session via cookie.
- Rotate the per-safe secret by updating the password.
- Integrate with HashiCorp Vault as key source.
- Integrate with Keycloak/OpenID for unlocking.
- Delete private data entries from a safe.
