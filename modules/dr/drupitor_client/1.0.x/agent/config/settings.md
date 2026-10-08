<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — settings form & config object

## Install & enable

`composer require drupal/drupitor_client` then `drush en drupitor_client -y`. Requires a
Composer-based install with the Composer binary reachable and PHP `proc_open()` available.
`hook_install()` (`drupitor_client.install`) sets `enabled: FALSE`, `composer_path: 'composer'`,
`command_timeout: 60` — the endpoint stays inert until an admin enables it and sets the secrets.

## Route & access

- Form route `drupitor_client.config` → `/admin/config/development/drupitor-client`, requirement
  `_permission: 'administer drupitor client'`.
- Permission `administer drupitor client` (`drupitor_client.permissions.yml`, `restrict access: TRUE`).
- Menu link `drupitor_client.config` under `system.admin_config_development` (Configuration → Development).

## Form (`src/Form/DrupitorClientConfigForm.php`)

`ConfigFormBase` (CSRF-protected), form id `drupitor_client_config_form`, editing config
`drupitor_client.settings`. Fields → config keys:

| Field | Key | Notes |
|-------|-----|-------|
| Enable Drupitor client (checkbox) | `enabled` | Master switch; default FALSE. |
| API token (textfield, maxlength 255) | `api_token` | Provided by the Drupitor host; `autocomplete=off`. |
| Encryption key (textfield) | `encryption_key` | Provided by the Drupitor host; used to AES-encrypt the payload. |
| Encryption method (select) | `encryption_method` | `AES-256-CBC` or `AES-256-GCM` (default/recommended). |
| Composer path (textfield) | `composer_path` | Path to the `composer` executable; empty → `composer`. |
| Command timeout (number, 10–300) | `command_timeout` | Seconds a Composer command may run; default 60. |

`validateForm()` rejects a `composer_path` not matching `^[a-zA-Z0-9\/_.-]+$`, and (when non-empty) an
`api_token` shorter than 32 chars or not matching `^[a-zA-Z0-9._-]+$`. `submitForm()` saves all six keys.

## Config object `drupitor_client.settings`

Install defaults (`config/install/drupitor_client.settings.yml`):

```yaml
enabled: false
api_token: ''
encryption_key: ''
encryption_method: AES-256-GCM
composer_path: composer
command_timeout: 60
```

Values are stored in Drupal config (no Key/env integration in code). Per README/help they may be
overridden in `settings.php`, e.g. `$config['drupitor_client.settings']['api_token'] = '…';`. There is
**no `config/schema/`** in the module, so `provides_config_schema` is false.

## Status report (`hook_requirements`)

At runtime `drupitor_client_requirements()` reports: Composer availability (runs `composer --version`),
enabled status, whether `api_token` is configured (ERROR if not), and whether a Composer project root was
found. Use it to confirm the module can operate.
