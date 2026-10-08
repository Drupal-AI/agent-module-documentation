<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add & configure a Language field

The module has **no global settings page**. You add a field of type `language_field` to a
bundle, then tune its **storage settings** (which languages are selectable) and its
widget/formatter.

## Field type

- id: `language_field`, label "Language"
- default widget: `languagefield_select`; default formatter: `languagefield_default`
- storage column: single `value` `varchar_ascii(maxlength)`, indexed. Multi-value works via
  field cardinality like any field.

## Storage settings (`field.storage.<entity>.<field>` → `settings`)

| key | meaning |
|---|---|
| `maxlength` | code length, default `12` |
| `language_range` | array (keyed) of which language sets are offered — see values below |
| `included_languages` | allow-list of langcodes (empty = no restriction) |
| `excluded_languages` | deny-list of langcodes |
| `groups` | optgroup labels string |
| `allowed_values_function` | callback, default `languagefield_allowed_values` |

`language_range` values (from `LanguageItem` / `CustomLanguageManager`):

| value | set |
|---|---|
| `1` | site **configurable** languages (`en`, `de`, …) |
| `2` | **locked** languages (`und`, `zxx`) |
| `3` | all core languages (configurable + locked) |
| `4` | site **default** only |
| `11` | all **predefined** ISO languages (default) |
| `12` | the module's **custom** languages |

Combine ranges by including several keys, e.g. `[11 => 11, 12 => 12]` = predefined + custom.

## Create a field with drush (scriptable)

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;
FieldStorageConfig::create([
  'field_name' => 'field_spoken', 'entity_type' => 'node', 'type' => 'language_field',
  'cardinality' => -1,
  'settings' => [
    'maxlength' => 12,
    'language_range' => [11 => 11],        // predefined
    'included_languages' => [], 'excluded_languages' => ['zxx'],
    'groups' => '', 'allowed_values_function' => 'languagefield_allowed_values',
  ],
])->save();
FieldConfig::create([
  'field_name' => 'field_spoken', 'entity_type' => 'node',
  'bundle' => 'article', 'label' => 'Spoken languages',
])->save();
```

## Widget (`entity_form_display` component `type`)

- `languagefield_select` — select list (default)
- `languagefield_autocomplete` — single autocomplete textfield (settings: `size`, `placeholder`, `autocomplete_route_name`)
- `languagefield_autocomplete_tags` — multi-value tags autocomplete

## Formatter (`entity_view_display` component `type: languagefield_default`)

`settings.format` is a sequence of display keys, tried in order:
`icon` (needs Language Icons), `iso` (ISO 639 code), `name` (English name), `name_native`
(native name). `settings.link_to_entity` (0/1) wraps the output in a link to the host entity.

## Read it back

```bash
drush cget field.storage.node.field_spoken settings
drush cget core.entity_form_display.node.article.default content.field_spoken
```
