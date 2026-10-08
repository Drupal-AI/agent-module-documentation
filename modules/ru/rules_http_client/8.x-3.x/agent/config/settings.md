<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config: Rules HTTP Client settings

Form `Drupal\rules_http_client\Form\SettingsForm` (extends `ConfigFormBase`), id
`rules_http_client_settings`. File `src/Form/SettingsForm.php`.

## Route & access
- Route `rules_http_client.settings` (`rules_http_client.routing.yml`):
  path `/admin/config/workflow/rules/http-client-settings`, `_form` the SettingsForm,
  requirement `_permission: 'administer rules'` (Rules' own admin permission — the module defines
  none of its own).
- Surfaced as a menu link (`links.menu.yml`, parent `rules.reactions`) and a local task
  (`links.task.yml`, base route `entity.rules_reaction_rule.collection`).
- `configure: rules_http_client.settings` in the `.info.yml`.

## Config object `rules_http_client.settings`
Editable name from `getEditableConfigNames()`. Defaults in
`config/install/rules_http_client.settings.yml`; schema in
`config/schema/rules_http_client.schema.yml` (type `config_object`).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `show_responses` | boolean | `false` | When true, debug request/response details are also shown in the UI (only to users with the `access rules debug` permission). Form field labelled "Show debug messages". |
| `max_response_size` | integer | `10000` | Max response-body size (bytes) used by the action's `BodySummarizer` when summarizing error-path bodies for logs. Form field "Maximum response body size" (`#min` 0). |

## Behavior
`buildForm()` renders both keys inside a "Logging" fieldset; `submitForm()` writes them back to
`rules_http_client.settings` and calls `parent::submitForm()`. These settings only affect the
optional debug logging/UI output of the "Request HTTP data" action; they do not change how requests
are made. `provides_config_schema` is true; no config entities are defined.
