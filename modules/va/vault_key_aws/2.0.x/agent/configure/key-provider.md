<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Vault AWS key provider

## Prerequisites
1. Enable and configure `drupal/vault` — set `vault.settings` (base_url, auth token/method, TLS verify). This module reuses that connection entirely.
2. In Vault: mount the AWS secret engine (e.g. `aws/`), configure the root/STS config, and define a role that issues the AWS credentials you need.

## Create the Key
1. Go to the Key module UI (`/admin/config/system/keys`) → **Add key**.
2. Choose a key type (e.g. an authentication multivalue type for access-key/secret pairs).
3. **Key provider:** select **Vault AWS**.
4. **Secret Engine Mount:** pick the AWS mount (the form auto-lists `aws`-type mounts from Vault; if Vault is unreachable it falls back to a textfield — enter e.g. `aws/`). The mount is locked after creation.
5. **Role Path:** enter the Vault role name/path (only `a-z 0-9 . - _ /` are accepted).
6. Save.

## Behaviour
- On read, the provider returns a valid cached lease if present, else reads `/<mount>/creds/<role_path>` from Vault and caches the returned credentials for the lease duration.
- Deleting the Key revokes the associated Vault lease.
- The provider is read-only; it cannot set or overwrite the secret in Vault.

## Notes
- Credentials are dynamic/short-lived — consumers should read through the Key entity each time rather than caching the raw value.
- Nothing is persisted by this module except lease bookkeeping handled by the Vault client.
