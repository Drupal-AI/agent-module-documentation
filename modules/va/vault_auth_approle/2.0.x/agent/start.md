<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vault Auth - AppRole (vault_auth_approle) — agent index

A `vault` (HashiCorp Vault for Drupal) **authentication plugin** that logs Drupal into Vault with the
**AppRole** method: a `role_id` (identifier) plus a `secret_id` (credential) are exchanged for a Vault
token. It contributes one plugin — no routes, services, permissions, drush or UI of its own; you
configure it from the Vault module's own settings form.

- **Version:** 2.0.x (2.0.0). Core `^9.3 || ^10 || ^11`, PHP `^8.1`.
- **Depends on:** `vault:vault` (base module, `^2 || ^3`) and `key:key` (`^1`).
- **Configure via** → [configure/approle.md](configure/approle.md) — the plugin, its two config keys,
  where they are stored, how to set them with drush/PHP, and the runtime login flow.

Key facts (all verified against source):
- Plugin: `@VaultAuth` id **`approle`**, class `Drupal\vault_auth_approle\Plugin\VaultAuth\AppRole`
  (`src/Plugin/VaultAuth/AppRole.php`), `final`, extends `Drupal\vault\Plugin\VaultAuthBase`,
  implements `ConfigurableInterface` + `VaultPluginFormInterface`.
- `getAuthenticationStrategy()` returns a `Vault\AuthenticationStrategies\AppRoleAuthenticationStrategy`
  built from `role_id` and the resolved `secret_id` (that class ships with the `csharpru/vault-php`
  library pulled in by the base `vault` module).
- Config schema: **`vault.auth_plugin.approle`** with keys **`role_id`** (string) and
  **`secret_key_id`** (Key entity machine name). Persisted inside the base module's `vault.settings`
  config under `auth_plugin_config` (selected when `plugin_auth: approle`).
- Form widgets: `role_id` is a `textfield`; `secret_key_id` is a `key_select` filtered to
  `type: authentication` Key entities. The secret itself is read at runtime through the
  `key.repository` service — only the Key's machine name lives in config.
- Discovered/registered by the base module's `plugin.manager.vault_auth` manager
  (`Drupal\vault\Plugin\VaultAuthManager`); instantiated by `Drupal\vault\VaultClientFactory`.
