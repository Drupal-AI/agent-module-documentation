<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — form, config object, schema, route

## Install / enable

`composer require drupal/azure_key_vault` then `drush en azure_key_vault`. Requires the **`key`** module
(`drupal:key` dependency). Optionally enable `azure_key_vault_key_provider` for the Key UI integration.

## Route + menu

- Route `azvault.admin` (`azure_key_vault.routing.yml`): path
  `/admin/config/system/az_key_vault_config`, `_form: Form\AzVaultConfigForm`, title *Azure Key Vault API
  Settings*, requirement `_permission: 'administer site configuration'`, `_admin_route: TRUE`.
- Menu link `azvault.admin` (`azure_key_vault.links.menu.yml`) under `system.admin_config_system`.
- `info.yml` `configure: azvault.admin`. No other routes exist.

## The form (`Form\AzVaultConfigForm`, extends `ConfigFormBase`)

`getFormId()` = `api_config_form`; editable config = `azure_key_vault.settings`. Fields:

| Field | `#type` | Notes |
|---|---|---|
| `azure_url` | textfield | Key Vault base URL, required, maxlength 256. |
| `token_url` | textfield | AAD OAuth token URL, required. |
| `vault_id` | password | AAD client id (form masks it; stored in config). |
| `vault_secret` | key_select | Selects a **Key entity** id that holds the client secret; a "Manage / Add key" link is shown as `#suffix`. |
| `api_version_date` | textfield | Azure API version (date). |
| `api_version_number` | textfield | Azure API version (number), used in the `?api-version=` query. |

`submitForm()` writes all six values to `azure_key_vault.settings` with `->save(TRUE)`.

## Config object + schema

`config/schema/azure_key_vault.schema.yml` → `azure_key_vault.settings` (`config_object`) mapping:
`azure_url` (string), `token_url` (string), `vault_id` (**type `password`**), `vault_secret` (**type
`key`**), `api_version_date` (string), `api_version_number` (string).

Install defaults `config/install/azure_key_vault.settings.yml`:
```
azure_url: 'https://{HOSTNAME_SEGMENT}.vault.azure.net/'
token_url: 'https://login.microsoftonline.com/{TENANT_ID}/oauth2/v2.0/token'
vault_id: ''
vault_secret: 'vault_secret'
api_version_date: '2022-02-22'
api_version_number: '7.4'
```

## The client secret is a Key entity, not raw config

`AzureKeyVaultConfigurationService::getClientSecret()` (`src/AzureKeyVaultConfigurationService.php`) reads
config `vault_secret` (a Key id) and returns `keyService->getKey($id)->getKeyValue()`. If the id is null it
sets a messenger error linking to the Key add form and the settings route, then falls back to a key id of
`vault_secret`. So the actual client secret lives wherever that Key entity's provider stores it (file, env,
config-override, etc.) — choose a provider that keeps it out of exported config.

`config/install/key.key.vault_secret.yml` ships a **placeholder** Key entity `vault_secret` using the
**file** provider pointing at `modules/contrib/azure_key_vault/client_secret_example.key` (whose contents
are the literal `bogus_value`). Replace this with a real Key backed by a secure provider before use;
prefer the Key module's *Configuration Overrides* / env provider so the secret stays only on the host.

The other five settings — including `vault_id` (client id) and the vault/token URLs — are stored directly
in `azure_key_vault.settings` and therefore travel through config export / the database.
