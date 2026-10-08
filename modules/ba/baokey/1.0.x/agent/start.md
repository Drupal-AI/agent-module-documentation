<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BaoKey - agent index

**BaoKey** is a Key-module key provider that reads secrets from OpenBAO/Vault (KV v2). Version **1.0.1** (`1.0.x`). Core `^9 || ^10`. Depends on `key`.

## Key files
- `src/BaoKeyApiService.php` - `readSecret()`: `GET {vault_url}/v1/{path}` with `X-Vault-Token`.
- `src/Plugin/KeyProvider/BaoKeyProvider.php` - the `baokey` provider + config form.

## Config
- `vault_url` and `vault_token` come from `settings.php` (`Settings::get`).
- Per-Key secret path configured on the Key entity.

Security: no disabled TLS; token sourced from settings, not the DB. Note `info.yml` declares `configure: baokey.settings` but the module ships no routing.yml for it.