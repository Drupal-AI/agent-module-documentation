<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, routes, permission & uninstall

## Config object `author_field.settings`

Install defaults — `config/install/author_field.settings.yml`. **No `config/schema/`** ships, so the
object is unschema'd (`provides_config_schema: false`).

| Key | Default | Meaning |
|-----|---------|---------|
| `author_api` | `1` | ORCID endpoint to use: `0` = sandbox, `1` = production |
| `author_items_depth` | `5` | Max autocomplete results returned (settings form allows 1–20) |
| `sandbox_orcid_url` | `https://pub.sandbox.orcid.org/v3.0/expanded-search/` | Sandbox public API base |
| `orcid_url` | `https://pub.orcid.org/v3.0/expanded-search/` | Production public API base |

## Settings form `AuthorFieldSettingsForm` (`src/Form/AuthorFieldSettingsForm.php`)

- Route `author_field.admin_settings`, path `/admin/config/content/author_field`, permission
  `administer author_field`. Menu link `author_field.admin_settings` under
  *Configuration → Content* (`system.admin_config_content`). `configure:` key in the `.info.yml`.
- Fields: `sandbox_orcid_url`, `orcid_url` (textfields), `author_items_depth` (select 1–20),
  `select_api` (radios sandbox/production).
- `validateForm()` requires `select_api` ∈ {0,1}, `author_items_depth` ∈ [1,20], and both URLs to
  pass `UrlHelper::isValid(..., TRUE)`.
- Two extra submit buttons — `checkSandboxApiStatus()` / `checkProductionApiStatus()` — GET the
  entered endpoint (`?q=obama&start=0&rows=3`, `Accept: application/vnd.orcid+json`) and report the
  status code + response body via the messenger (body rendered through an escaped `@json_string`
  placeholder), then save the config. `submitForm()` saves all four keys, invalidates the menu
  cache and rebuilds menu links.

## Routes

| Route | Path | Access | Handler |
|-------|------|--------|---------|
| `author_field.admin_settings` | `/admin/config/content/author_field` | `administer author_field` | `AuthorFieldSettingsForm` |
| `author_field.autocomplete` | `/autocomplete/author_field` | `_user_is_logged_in: TRUE` (`_format: json`) | `RestApiController::handleOrcidAutocomplete` |
| `author_field.uninstall_settings` | `/admin/modules/uninstall/entity/author_field` | `administer author_field` | `AuthorFieldUninstallValidatorForm` |

## Autocomplete controller (`src/Controller/RestApiController.php`)

- `handleOrcidAutocomplete(Request)`: reads `q`, applies `Xss::filter()`, builds
  `?q=<input>&fl=orcid,given-names,family-name,email,current-institution-affiliation-name&start=0&rows=<author_items_depth>`,
  picks sandbox/prod URL by `author_api`, GETs the fixed ORCID host, and returns a JSON array of
  `{value: <orcid-id>, label: "<given> <family> | <id> [| <orgs>]"}` (orgs = top 3
  `institution-name`, capped by `author_items_depth`). Any logged-in user can call it; it only
  surfaces ORCID's already-public search data from the config-set host.

## Permission (`author_field.permissions.yml`)

- `administer author_field` — "Administer the author field", `restrict access: true`. Gates the
  settings form and the uninstall helper form.

## Uninstall helper

- Service `author_field.uninstall_validator` → `src/AuthorFieldUninstallValidator.php`
  (`ModuleUninstallValidatorInterface`, tag `module_install.uninstall_validator`, args
  `entity_type.manager`, `entity_field.manager`, lazy). `validate('author_field')` scans **node**
  bundles for `author_field`-type field instances and, if any exist, blocks uninstall with a link to
  the removal form.
- `src/Form/AuthorFieldUninstallValidatorForm.php` (route above, form id
  `author_field_uninstall_settings`; `hook_form_alter` relabels its submit to "Delete all author
  fields"): lists node-bundle `author_field` (and `entity_reference_revisions` fields whose name
  contains `author`) instances, and on submit `FieldConfig::loadByName(...)->delete()`s them and runs
  `cron->run()`. Admin-gated, standard Drupal form (CSRF token automatic). The listed field/bundle
  machine names are the only interpolation into its Markup body.
