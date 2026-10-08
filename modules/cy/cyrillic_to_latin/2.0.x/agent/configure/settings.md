# Settings form and configuration

## Route & form

- Route `cyrillic_to_latin.admin_settings` → path `/admin/config/regional/cyrillic-to-latin`,
  requirement `_permission: 'administer site configuration'`.
- Form `Drupal\cyrillic_to_latin\Form\SettingsForm` (extends `ConfigFormBase`), form id
  `cyrillic_to_latin_admin_settings_form`. Injects `language_manager` to build the language checkboxes.
- Menu link `cyrillic_to_latin.admin_settings` (title "Cyrillic to Latin") under
  `system.admin_config_regional`. `info.yml` declares `configure: cyrillic_to_latin.admin_settings`.

## Config object — `cyrillic_to_latin.settings`

Editable config name returned by `getEditableConfigNames()`. Schema in
`config/schema/cyrillic_to_latin.schema.yml`; install defaults in
`config/install/cyrillic_to_latin.settings.yml`.

| Key | Type (schema) | Default (install) | Form element | Meaning |
|---|---|---|---|---|
| `enabled` | integer | `1` | `select` (No=0 / Yes=1) | Master on/off for all conversion. |
| `transliterate_on_po_import` | boolean | `false` | `checkbox` (visible only when enabled) | Permanently rewrite stored locale translations to Latin on `.po` import (see [../api/services.md](../api/services.md)). |
| `languages` | sequence (langcode→langcode) | `sr: sr` | `checkboxes` (visible only when enabled) | Languages the conversion applies to; the current language must be in this list. |

`languages` is stored as a checkboxes array (`{sr: sr, en: 0, …}`); the runtime code
`array_filter(array_values(...))` drops the unchecked (`0`) entries before the `in_array()` check.

## Applying changes

`submitForm()` saves the three keys, then shows: *"The configuration options have been saved. You must
clear the cache for the change to take effect."* — because the `string_translation` service class is
swapped at container-build time and field/UI output is cached, a **cache rebuild** (`ddev drush cr`) is
needed after any change. The update hook `cyrillic_to_latin_update_8001` seeds `languages: {sr: sr}`
for sites upgraded from before that key existed.

## Drush / scripting

No module-specific drush commands. Set config from the CLI with core drush:

```
ddev drush cset cyrillic_to_latin.settings enabled 1 -y
ddev drush cset cyrillic_to_latin.settings transliterate_on_po_import true -y
ddev drush cr
```
