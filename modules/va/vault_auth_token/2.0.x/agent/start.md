<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vault Auth - Token (vault_auth_token) — agent index

**A Vault module authentication plugin that authenticates Drupal to HashiCorp Vault with a static token sourced from a Key entity.**

- **Version:** 2.0.x (2.0.0)
- **Core:** ^9.3 || ^10 || ^11 — PHP 8.1 — depends on `key`, `vault`.
- **Package:** Security.
- **Plugin:** `@VaultAuth` id `token` (`src/Plugin/VaultAuth/Token.php`); builds `Vault\AuthenticationStrategies\TokenAuthenticationStrategy`.
- **Config:** only `token_key_id` (a Key machine name) is stored — schema `vault.auth_plugin.token`. Form uses `#type: key_select` filtered to `authentication` keys.
- **No routes, services or permissions of its own** — configured within the Vault module admin UI.

**Security:** SOUND. The Vault credential is NOT stored in this module's config — only the machine name of a Key entity is persisted; the real secret lives wherever the chosen Key provider stores it (env/file/etc.), keeping it out of exported config and out of plaintext DB config. The token value is only read at runtime via `key.repository` to construct the auth strategy; a missing Key throws `PluginException`. TLS to the Vault API is handled by the parent Vault module/PHP client — this plugin does not set HTTP options and does NOT disable certificate verification (`verify => false`). The token reference is only editable through Vault's admin UI, so it is not exposed to non-admins. No secret is logged. No security findings.
