<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & State storage

## Install / enable
`drush en algolia_search_interface`. No module dependencies, no composer.json, no `config/install`. After
enabling, an Algolia account is required to obtain an Application ID and an API key, and an Algolia index must
already exist (populate it separately, e.g. via `search_api_algolia`).

## Route & access
`algolia_search_interface.routing.yml`:
- Route id `algolia.settings_form`, path `/admin/algolia/configurations`, `_form:
  Drupal\algolia_search_interface\Form\AlgoliaSettingsForm`.
- Requirement `_permission: 'administer configurations'`.
- Admin menu link `algolia_search_interface.config` (`links.menu.yml`) under `system.admin_config_search`
  (Configuration › Search), weight 5.

## Form: `AlgoliaSettingsForm`
`src/Form/AlgoliaSettingsForm.php`, extends `FormBase`, `getFormId()` → `algoliasettings_form`. Fields
(defaults loaded from `\Drupal::state()->get('algolia_settings')`):

| Key | #type | Required | Meaning |
|-----|-------|----------|---------|
| `indexname` | textfield | yes | Algolia index name to query |
| `appId` | textfield | yes | Algolia Application ID |
| `apiKey` | textfield | yes | Algolia API key — use the **Search-only (public)** key (runs client-side) |
| `template` | textarea | yes | Per-hit Mustache/Hogan template; use `{{attribute}}` placeholders |
| `pagination` | radios (0/1) | no | Off/On toggle for the pagination widget |

`validateForm()` is empty (no validation). `submitForm()` collects the five values into an array and calls
`\Drupal::state()->set('algolia_settings', $values)`, then shows a "Algolia configurations saved" status
message. The `template` textarea `#placeholder` shows an example hit template using `{{image}}`, `{{name}}`,
`{{#helpers.highlight}}`, `{{price}}`.

## Storage
Values are stored in **Drupal State** under key `algolia_settings` (a single array). Consequences:
- Not exported by `drush cex`; not part of configuration or config schema (`provides_config_schema: false`).
- Not translatable; environment-specific by nature. Read/set programmatically via
  `\Drupal::state()->get('algolia_settings')` / `->set(...)`.

## Injection into the page (`AlgoliaSearchInterfaceHooks::preprocessHtml`)
`src/Hook/AlgoliaSearchInterfaceHooks.php` implements `hook_preprocess_html` (OOP `#[Hook('preprocess_html')]`,
bridged by the `#[LegacyHook]` shim in `algolia_search_interface.module`). When `algolia_settings` exists it
attaches to `$variables['#attached']['drupalSettings']['algolia']['config']`: `indexname`, `appId`, `apiKey`,
`template`, `pagination`. This runs for **every HTML response**, so the settings are available site-wide (the
search block itself can live in any region). `hook_theme` in the same class registers the `instantsearchblock`
theme hook.

The hook class is registered as an autowired service in `algolia_search_interface.services.yml`.
