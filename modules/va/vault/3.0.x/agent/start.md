<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vault (vault) — agent index

Integrates Drupal with a HashiCorp **Vault** / OpenBao secrets server. This is the
base/infrastructure module of a suite: it ships a Vault HTTP client service, a
`VaultConfig` settings wrapper, a lease-renewal cron job, and two plugin types
(authentication strategies and lease storage). It ships **no** auth strategy of its own
and nothing that consumes secrets — the Key provider, the encryption/Transit integration,
and the Token/AppRole auth strategies are SEPARATE drupal.org projects that depend on this
module. Enabling `vault` alone gives you a configured, authenticating client and the
plugin extension points, nothing that uses them.

- Dependencies: PHP `^8.1`, `csharpru/vault-php ^4.2`, `symfony/cache ^6`, core `^10.0 || ^11.0`. No Drupal module dependencies.
- Configure route: `vault.admin` → `/admin/config/system/vault` (permission `administer vault`).
- Defines 1 permission, 2 plugin types, config schema. No Drush commands. No submodules ship in the package.

Solution docs:
- **Point Drupal at a Vault server; set auth strategy and lease options** → [configure/settings.md](configure/settings.md)
- **Read/write secrets and manage leases from code** → [api/client.md](api/client.md)
- **Add a new authentication strategy (token, AppRole, …)** → [plugins/auth.md](plugins/auth.md)
- **Choose or add a lease-storage backend** → [plugins/lease-storage.md](plugins/lease-storage.md)
- **The admin permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config object `vault.settings`; keys `base_url`, `plugin_auth`, `auth_plugin_config`,
  `lease_ttl_increment`, `lease_renew_cron`, `plugin_lease_storage`,
  `lease_storage_plugin_config`, `read_cache_ttl`.
- Services: `vault.vault_client` (authenticating client, with lease storage),
  `vault.vault_client_no_lease_storage`, `vault.config` (`VaultConfigInterface`),
  `vault.cache.manager`, `plugin.manager.vault_auth`, `plugin.manager.vault_lease_storage`,
  `logger.channel.vault`. The client is built by `vault.vault_client_factory`
  (`VaultClientFactory::createInstance`), which authenticates on instantiation.
- Client class `Drupal\vault\VaultClient` (extends `Vault\CachedClient`), interface
  `VaultClientInterface`; API version constant `v1`, `buildPath()` prefixes `/v1`.
- Plugin types: `VaultAuth` (dir `Plugin/VaultAuth`, base `VaultAuthBase`, interface
  `VaultAuthInterface`, annotation `@VaultAuth`, manager `plugin.manager.vault_auth`,
  alter `hook_vault_vault_auth_info_alter`) and `VaultLeaseStorage` (dir
  `Plugin/VaultLeaseStorage`, base `VaultLeaseStorageBase`, annotation `@VaultLeaseStorage`,
  manager `plugin.manager.vault_lease_storage`, alter `hook_vault_vault_lease_storage_info_alter`).
  Shipped lease-storage plugins: `state`, `static`, `encrypted_state`. No auth plugins ship here.
- Hooks implemented: `hook_cron` (renew leases + prune cache), `hook_cache_flush`
  (clear client cache), `hook_theme`, `hook_requirements` (checks the vault-php SDK,
  a configured auth plugin, and an auth ping to `/v1/auth/token/lookup-self`).
