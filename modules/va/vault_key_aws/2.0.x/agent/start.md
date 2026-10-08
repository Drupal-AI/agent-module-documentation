<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vault Secret Engine - AWS (vault_key_aws) — agent index

**Adds a `vault_aws` Key provider that fetches dynamic, lease-cached AWS credentials from a HashiCorp Vault AWS secret engine.**

- **Version:** 2.0.x — core `^10 || ^11`, PHP 8.1; depends on `key:key` and `vault:vault`.
- **Plugin:** `\Drupal\vault_key_aws\Plugin\KeyProvider\VaultAWSKeyProvider` (id `vault_aws`), read-only (`setKeyValue()` → FALSE).
- **Fetch path:** `/<secret_engine_mount>/creds/<secret_path>` via the Vault client `read()`; leases stored under `key:<key_id>` and revoked on key delete.
- **Config:** per-Key form — secret engine mount (auto-listed) + role path (validated to `[a-z0-9._-/]`). No standalone admin route/permission.
- **Security:** holds no credentials of its own; all TLS/token/verify handling is delegated to `drupal/vault` (`vault.settings`). Stores only Vault lease metadata. No disabled-TLS or hardcoded secrets in this module. See [configure/key-provider.md](configure/key-provider.md).
