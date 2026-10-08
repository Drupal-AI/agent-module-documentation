<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — azure_storage.settings

Install/enable, the settings form, and how Azure credentials are stored. Source:
`src/Form/SettingsForm.php`, `config/install/azure_storage.settings.yml`, `azure_storage.routing.yml`,
`azure_storage.permissions.yml`, `src/AzureStorage.php`.

## Install / enable

- `composer require drupal/azure_storage` (pulls `microsoft/azure-storage-queue ^1.3` and
  `microsoft/azure-storage-common ^1.5`), then `drush en azure_storage -y`.
- Hard dependency on the **Key** module (`dependencies: [key:key]` in the info.yml). Enabling
  azure_storage enables `key`.
- `hook_requirements` (`azure_storage.install`, runtime phase): errors if PHP `allow_url_fopen` is
  **off** (the Azure SDK needs it); warns if PHP is 32-bit (files > 2 GB unsupported).

## Route & permission

- Route **`azure_storage.settings_form`** → path `/admin/config/services/azure-storage`,
  `_form: '\Drupal\azure_storage\Form\SettingsForm'`, `options._admin_route: TRUE`.
- Access requirement: `_permission: 'administer azure storage'`. This is the module's only
  permission (`azure_storage.permissions.yml`, title *"Administer Azure Storage configuration"*).
- Discoverable via a menu link (`azure_storage.links.menu.yml`, parent
  `system.admin_config_services`, *Configuration → Services*) and a "Settings" local task
  (`azure_storage.links.task.yml`).

## Config object: `azure_storage.settings`

Editable config (form `getEditableConfigNames()` returns `azure_storage.settings`). Install defaults
in `config/install/azure_storage.settings.yml`. There is **no `config/schema/` directory** in this
version, so the keys are untyped for config-inspector/translation purposes.

| Key | Form widget | Default | Meaning |
|---|---|---|---|
| `protocol` | select `http`/`https`, required | `https` | `DefaultEndpointsProtocol` for the connection string. |
| `account_name` | textfield, required | `''` | Azure Storage account name. |
| `test_account_key` | `key_select`, required | `''` | **Key entity id** holding the test account key. |
| `live_account_key` | `key_select`, required | `''` | **Key entity id** holding the live account key. |
| `mode` | radios `test`/`live` | `test` | Selects which `*_account_key` is used at runtime. |
| `endpoint_suffix` | textfield | `''` | `EndpointSuffix` (e.g. `core.windows.net`). |

`SettingsForm::submitForm()` writes exactly these six keys back to `azure_storage.settings`.

## Credential storage (Key module)

- The account keys are **not** stored in config as plaintext — the form fields are `key_select`
  elements, so config stores only the **id of a Key entity**. Create those Key entities first
  (`/admin/config/system/keys`), backed by whatever provider you use (env variable, file, secrets
  manager, etc.), then pick them in this form.
- At runtime `AzureStorage::getAccountKey()` (`src/AzureStorage.php`) reads
  `azure_storage.settings`, picks `test_account_key` or `live_account_key` by `mode`, loads that Key
  via `\Drupal::service('key.repository')->getKey($key_id)`, and returns `getKeyValue()`. Passing an
  explicit `$key_id` overrides the config lookup. Returns `NULL` when unset or the key is missing.

## Operating notes

- `protocol` can be set to `http`; keep it `https` (the default) for TLS in transit.
- Changing `mode` between `test` and `live` swaps the active account key with no other change.
- After editing, code that already cached a client should be rebuilt/reconstructed — the service
  reads config in its constructor (see [../api/queue-client.md](../api/queue-client.md)).
