<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Vault Secret Engine - AWS registers a `drupal/key` key provider (`vault_aws`) that reads dynamic AWS credentials from a HashiCorp Vault AWS secret engine role, caching them via Vault leases.
---
The module bridges the Key module and the Vault module: it adds a `KeyProvider` plugin whose `getKeyValue()` first looks for a still-valid Vault lease (`retrieveLease("key:<id>")`) and, if none exists, calls the Vault client `read()` against a path built as `/<secret_engine_mount>/creds/<secret_path>`. The JSON-encoded credential set (access key / secret key) is returned and, when Vault supplies a lease id and duration, stored via `storeLease()` so subsequent reads reuse it until expiry. Deleting the Key entity calls `revokeLease()`; writing is unsupported (`setKeyValue()` returns FALSE — read-only).

Configuration is per-Key: the provider form lets you pick the AWS secret engine mount (auto-listed from Vault when reachable, else a textfield) and a role path; the role path is validated to URL-safe characters (`[a-z0-9._\-/]`). All transport, authentication and TLS to Vault are delegated to the `drupal/vault` client and its `vault.settings` (base_url, token, verify), so this module holds no secrets itself and stores only lease metadata. `obscureKeyValue()` masks multivalue credential JSON in the UI.

Typical setup: configure the Vault module connection, mount and configure an AWS secret engine + role in Vault, then create a Key of the appropriate type using the "Vault AWS" provider and point it at the mount and role. Consuming code reads credentials through the Key entity as usual, getting fresh leased AWS keys.

---

- Fetch dynamic AWS access-key/secret credentials from HashiCorp Vault
- Register a 'Vault AWS' provider for a drupal/key Key entity
- Use short-lived, leased AWS credentials instead of static keys in config
- Point a Key at a Vault AWS secret engine mount and role path
- Auto-list available AWS secret engine mounts in the provider form
- Cache credentials for the Vault lease duration to avoid re-reads
- Automatically revoke the Vault lease when the Key entity is deleted
- Supply AWS credentials to other modules through the Key API
- Rotate AWS credentials by relying on Vault lease expiry
- Keep AWS secrets out of Drupal's config/database entirely
- Mask multivalue credential JSON in the Key UI via obscureKeyValue()
- Validate the role path to URL-safe characters before saving
- Reuse an existing drupal/vault connection (base_url, token, TLS verify)
- Provide read-only credential access (writing is intentionally unsupported)
- Delegate all TLS/transport to the Vault client rather than this module
- Set the default secret engine mount to `aws/` and override per Key
