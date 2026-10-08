<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins, tokens & integrations

## Field plugins provided

| kind | id | notes |
|---|---|---|
| Field type | `language_field` | `LanguageItem`, extends core `LanguageItem`, implements `OptionsProviderInterface` |
| Widget | `languagefield_select` | select list (default) |
| Widget | `languagefield_autocomplete` | single autocomplete textfield |
| Widget | `languagefield_autocomplete_tags` | multi-value tags autocomplete (`multiple_values = TRUE`) |
| Formatter | `languagefield_default` | extends core `StringFormatter`; `format` sequence + `link_to_entity` |

## Allowed values

`languagefield_allowed_values()` (in `.module`) is the default `allowed_values_function`.
It reads the field's storage settings (`language_range`, `included_languages`,
`excluded_languages`) and returns `code => label`. Override by setting a field's
`allowed_values_function` storage setting to your own callback with the same signature
(`callback_allowed_values_function()`).

## Integration plugins (only active when the partner module is enabled)

- **Views**: `languagefield_field_views_data()` adds field data; filter plugin
  `Drupal\languagefield\Plugin\views\filter\LanguageFilter` (id `language_field`).
- **Tokens**: `languagefield_token_info()` / `languagefield_tokens()` expose the stored code.
- **Feeds**: target `Drupal\languagefield\Feeds\Target\LanguageField` maps import values in.
- **Tamper**: `Drupal\languagefield\Plugin\Tamper\LanguageToCode` (id `language_to_code`)
  converts a language name to its code during a Feeds/Tamper pipeline.
- **Diff**: field builder `Drupal\languagefield\Plugin\diff\Field\LanguageFieldBuilder`.
- **Language Icons**: when enabled, the formatter's `icon` format key renders a flag.

## Autocomplete route

`languagefield.autocomplete` →
`/languagefield/autocomplete/{entity_type}/{bundle}/{field_name}`
(`LanguageAutocompleteController::autocomplete`), used by the autocomplete widgets.

## No hooks / no Drush

The module defines its own field plugins and a config entity but invites no `hook_*` of its
own (no `languagefield.api.php`) and ships no Drush commands. Programmatic use = create
fields (see [../configure/field.md](../configure/field.md)) and `custom_language` entities
(see [../configure/custom-languages.md](../configure/custom-languages.md)).
