<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — `activetickets_client.settings`

## Route, form, menu

- Route `activetickets_client.settings` (`activetickets_client.routing.yml`) → path
  `/admin/config/system/activetickets_client`, `_form: \Drupal\activetickets_client\Form\ActiveTicketsSettingsForm`,
  `_permission: administer site configuration`.
- Menu link `activetickets_client` (`activetickets_client.links.menu.yml`) under
  `system.admin_config_system`, weight `-20`, title "ActiveTickets: Client".
- `info.yml` `configure:` points at the same path.

## Form (`Form\ActiveTicketsSettingsForm`, extends `ConfigFormBase`)

- `getFormId()` = `activetickets_client`; `getEditableConfigNames()` = `['activetickets_client.settings']`.
- `buildForm()` renders six text fields in two fieldsets:
  - `wsdl_settings`: `wsdl_url`, `wsdl_member_url`.
  - `client_settings`: `client_name`, `langcode`, `ticket_url`, `token`.
- `submitForm()` writes all six keys back to `activetickets_client.settings` and saves. No `validateForm()`
  — values are stored as entered (no URL validation, no trimming).

## Config object + schema (`config/schema/activetickets_client.settings.schema.yml`)

`activetickets_client.settings` keys (all `type: string`):

| key | used by | meaning |
|---|---|---|
| `wsdl_url` | `ActiveTicketsClient::initSoapClient()` (public) | public SOAP WSDL endpoint |
| `wsdl_member_url` | `initSoapClient($memberClient=TRUE)` | member SOAP WSDL endpoint |
| `client_name` | `getRequestParams()` / `getMemberRequestParams()` | ActiveTickets client name sent on every call |
| `langcode` | `getRequestParams()` | language code (e.g. `EN`) sent on every call |
| `ticket_url` | (stored only) | ticket base URL; not read by the client class |
| `token` | `initSoapClient()` | API token sent as the `x-api-key` request header |

Notes:

- There is **no `config/install/`** directory, so every key is unset until the form is saved; an empty
  `wsdl_url` makes `\SoapClient(null)` throw at service construction.
- The config schema is declared `type: config_entity` in the schema file, but this is an ordinary simple
  config object (not an actual config entity — there is no entity type or `config_export`).
- Operationally: point `wsdl_url`/`wsdl_member_url` at ActiveTickets' HTTPS WSDL endpoints, set
  `client_name` and `langcode` to the values ActiveTickets issued you, and paste the API token. The token
  travels as an HTTP header (`x-api-key`), not in the URL query string.
- After saving, inject `@activetickets_client.client` (or `@activetickets_client.member_client`) and call
  the methods documented in [../api/client.md](../api/client.md).
