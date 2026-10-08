<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Vault integrates Drupal with a HashiCorp **Vault** or OpenBao secrets server, so credentials, API keys and other secrets can be fetched from a dedicated secrets manager at runtime instead of living in settings.php or in exported configuration.

---

This is the base/infrastructure module of a suite — its own description is "provides core dependencies of vault module suite" — and the consumer modules (a Key provider, encryption/Transit integration, the Token and AppRole authentication strategies) are separate drupal.org projects that build on it. What it ships is the client and the extension points: `VaultClient` / `VaultClientFactory` wrap the `csharpru/vault-php ^4.2` library and authenticate on construction, `VaultConfig` reads the `vault.settings` config object, `VaultCacheManager` manages a Symfony Cache pool, and two plugin types define the pluggable parts — **VaultAuth** for authentication strategies (`VaultAuthBase`, `VaultAuthManager`, annotation `@VaultAuth`, none shipped in the base module) and **VaultLeaseStorage** for where time-bound Vault leases are persisted and renewed (`state`, `static` and `encrypted_state` plugins ship). A settings form at `/admin/config/system/vault` sits behind the `administer vault` permission, a `hook_cron` renews stored leases, and `hook_requirements` checks the SDK, the configured auth plugin and a live auth ping. Requirements are PHP 8.1+, `symfony/cache ^6`, and core `^10 || ^11`; upstream keeps a full `mkdocs.yml` documentation site.

---

- Fetch API credentials from HashiCorp Vault or OpenBao at runtime.
- Keep secrets out of settings.php and config exports.
- Rotate credentials without redeploying Drupal.
- Use short-lived dynamic database credentials.
- Centralise secrets across an estate of sites.
- Renew Vault leases automatically before they expire.
- Choose an authentication strategy by plugin.
- Store leases in a backend that suits the environment.
- Meet a policy requiring a dedicated secrets manager.
- Supply a Key entity from Vault (via the separate Key-provider project).
- Read a KV secret from custom code through `vault.vault_client`.
- Write a secret to Vault from Drupal.
- List secret-engine mounts of a given type.
- Cache validated auth tokens and key reads to reduce round trips.
- Add a custom authentication strategy as a `VaultAuth` plugin.
- Add a custom lease-storage backend as a `VaultLeaseStorage` plugin.
- Encrypt stored leases at rest with the Encrypt module.
- Support per-environment secret scoping via the base URL.
- Integrate encryption keys held in Vault.
- Give CI a path to inject secrets safely.
- Separate secret custody from application code.
- Audit secret access centrally in Vault.
- Set a Vault namespace for the client.
