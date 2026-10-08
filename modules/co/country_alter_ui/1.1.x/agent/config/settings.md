<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Country Alter UI — settings form, config & alter hook

## Install & enable

```bash
composer require drupal/country_alter_ui
drush en country_alter_ui -y
```

No composer requirements beyond core, no sub-modules, no permissions of its own, no Drush commands.
On install, `config/install/country_alter_ui.settings.yml` seeds the config object with empty
`countries` / `filter_countries` and `sort_alphabetically: false`.

## The settings form

- Class `CountryAlterSettingsForm` (`src/Form/CountryAlterSettingsForm.php`), a `ConfigFormBase`.
- `getFormId()` = `country_alter_ui_settings_form`; `getEditableConfigNames()` =
  `['country_alter_ui.settings']`.
- Constructed with core's **`country_manager`** service (`CountryManagerInterface`), injected in
  `create()`.

### Route, menu & access

- Route `country_alter_ui.settings_form` → **`/admin/config/regional/countries`**,
  `_title: 'Country Alter Settings'`, requirement **`_permission: 'administer site configuration'`**.
  The module defines **no permission of its own**; access is core's standard site-configuration
  permission. Because it is a `ConfigFormBase` (a POST form with core's form token), submission is
  CSRF-protected; there is no state-changing GET route.
- Menu link `country_alter_ui.settingsform` under `system.admin_config_regional`
  (Configuration → Regional and language), weight 201.

### Form fields (`buildForm()`)

| Field | `#type` | Backed config key | Notes |
|---|---|---|---|
| Sort Countries Alphabetically | checkbox | `sort_alphabetically` | Default from config, else FALSE. |
| Countries | textarea | `countries` | One `code|name` per line; default is the stored array joined by `PHP_EOL`. Description: *"Enter one country per line in the format: code\|name."* |
| Filter Countries | select (`#multiple`) | `filter_countries` | `#options` = `CountryManagerInterface::getStandardList()` (core's full ISO country list); select the codes to remove. |

Note the filter options come from `$this->countryManager::getStandardList()` — the **static** core
list, so it is the unaltered core list (this module's own additions are not offered as filter
options).

### Validation (`validateForm()`)

Splits the textarea on `PHP_EOL`, trims and drops empty lines, then for each remaining line
requires exactly one `|` (`explode('|', $country, 2)` must yield 2 parts); otherwise sets a form
error *"Invalid format. Enter one country per line in the format: code|name."* and stops. No
validation of the code/name values themselves.

### Submit (`submitForm()`)

Re-parses the textarea the same way and writes three keys to `country_alter_ui.settings`:
`countries` (the array of raw `code|name` lines), `filter_countries` (the selected codes),
`sort_alphabetically` (the checkbox), then `save()`.

## Config object & schema

Config object **`country_alter_ui.settings`** (schema `config/schema/country_alter_ui.schema.yml`,
type `config_object`):

| Key | Schema type | Meaning |
|---|---|---|
| `countries` | sequence of string | Raw `code|name` entries as typed in the textarea. |
| `filter_countries` | sequence of string | ISO country codes to remove from the list. |
| `sort_alphabetically` | boolean | Sort the final list by (possibly overridden) name. |

Example export:

```yaml
# country_alter_ui.settings
countries:
  - 'US|USA'
  - 'GB|United Kingdom'
  - 'XK|Kosovo'
filter_countries:
  - 'AQ'
  - 'BV'
sort_alphabetically: true
```

## How the alter is applied (runtime)

`CountryAlterUiHooks::countriesAlter(array &$countries)` (`src/Hook/CountryAlterUiHooks.php`,
`#[Hook('countries_alter')]`) runs whenever core assembles the country list
(`\Drupal::service('country_manager')->getList()`), and:

1. Reads `countries` from config. For each entry it does
   `[$code, $name] = array_pad(explode('|', $entry, 2), 2, '')`, trims both, and **skips** the
   entry if either is empty. Otherwise it sets `$countries[$code] = $this->t($name)` — so a code
   that already exists is **overridden**, and a new code is **added**.
2. Reads `filter_countries`; if non-empty, removes those keys with
   `array_diff_key($countries, array_flip($filter_countries))`.
3. If `sort_alphabetically` is true, sorts by value with
   `uasort(..., strnatcasecmp((string) $a, (string) $b))` (natural, case-insensitive).

The class uses `StringTranslationTrait` and is wired as an autowired service in
`country_alter_ui.services.yml`; the procedural `country_alter_ui_countries_alter()` in the
`.module` file is a `#[LegacyHook]` shim that forwards to this service.

### Order & interaction notes

- Override happens **before** filtering: you can override a country and then filter it out.
- The label passed to `t($name)` becomes the option text; because it is rendered through core's
  form/select and render layer, HTML in a name is escaped, not executed.
- Sorting compares the resulting **names** (overridden ones included), so renamed countries sort by
  their new label.

## Testing

`tests/src/Kernel/CountryAlterUiHooksTest.php` (kernel test) exercises `countriesAlter()` for the
override, add, filter and sort behaviors — a useful reference for the exact expected outcomes.
