<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `SampleValueGenerator` plugin type

## Install & enable

```bash
composer require drupal/field_sample_value
drush en field_sample_value -y
```

No dependencies beyond core, no sub-modules, no permissions, no Drush commands.

## The plugin type

- Manager: `SampleValueGeneratorManager` (`src/SampleValueGeneratorManager.php`), service id
  **`plugin.manager.field_sample_value`**. Extends `DefaultPluginManager`.
- Discovery namespace: **`Plugin/Field/SampleValueGenerator`**. Interface
  `SampleValueGeneratorInterface`. Annotation `@SampleValueGenerator`
  (`src/Annotation/SampleValueGenerator.php`). Cache key `sample_value_generators`.
- Alter hook: **`sample_value_generator_info`** (via `alterInfo()`), so other modules can add,
  remove or reweight generator definitions.
- Base class: `SampleValueGeneratorBase` (`src/SampleValueGeneratorBase.php`).

### Annotation properties

| Property | Meaning |
|---|---|
| `id` | Plugin ID (stored in field third-party settings). |
| `label` / `title` | Human label shown in the radio list. |
| `field_types` | Array of field types the generator applies to; **empty = all field types**. |
| `weight` | Sort weight; lower sorts first (`getApplicableGenerators()` sorts by weight). |

`SampleValueGeneratorManager::getApplicableGenerators(string $field_type)` returns the plugin IDs
whose `field_types` is empty or contains `$field_type`, ordered by weight.

## Interface (`SampleValueGeneratorInterface`)

Extends `PluginInspectionInterface`, `ConfigurableInterface`, `PluginFormInterface`,
`ContextAwarePluginInterface`. Methods to implement/override:

- `generateSampleValue(FieldItemListInterface $item_list): void` — set the sample value on the
  passed field item list.
- `shouldPreventSave(): bool` — whether an entity carrying an unchanged generated value should be
  blocked from saving.

`SampleValueGeneratorBase` supplies: `getConfiguration()`/`setConfiguration()` (deep-merged over
`defaultConfiguration()`), a default `prevent_save => FALSE` config with a "Prevent save"
checkbox in `buildConfigurationForm()`, `shouldPreventSave()` reading that flag, and no-op
`validate/submitConfigurationForm()`. The base constructor injects a context definition
`field_item_list`; the form/service always call `->setContextValue('field_item_list', $items)`
so generators can inspect the field via `$this->getContextValue('field_item_list')`.

## The four shipped generators

All live in `src/Plugin/Field/SampleValueGenerator/`.

### `default` — "Field type default" (weight -10, all field types)
`DefaultValue.php`. `generateSampleValue()` just calls core's
`$item_list->generateSampleItems()`. This is the catch-all lowest-weight option.

### `random_string` — "Random words" (`string`, `string_long`)
`RandomStringValue.php` extends `RandomTextValueBase`. Generates
`(new Random())->sentences($count, TRUE)`. Config: `count` (number, min 1; "How many words…").

### `random_text` — "Random text" (`text`, `text_long`, `text_with_summary`)
`RandomTextValue.php` extends `RandomTextValueBase`. For fields with a `max_length` it generates
`sentences(mt_rand(1, count), FALSE)`; otherwise `paragraphs($count)`. Adds a **filter format**
(`filter_format`) to the stored value; default is `filter_fallback_format()`. Its config form
shows a filter-format `select` (populated from `filter_formats(currentUser())`) for textareas, and
caps `count`'s max at `ceil(max_length / 3)` for textfields.

`RandomTextValueBase` (`generateSampleValue()`) truncates the generated text to `max_length` when
set and calls `setValue(buildValues($value))`; `buildValues()` returns `['value' => …]` (plus
`'format' => filter_format` in `RandomTextValue`).

### `entity_reference` — "Entity Reference" (`entity_reference`)
`EntityReference.php`, injects `entity_type.manager`. `generateSampleValue()` reads the field's
`target_type` and `handler_settings.target_bundles`, runs an **access-checked entity query**
(`getQuery()->accessCheck(TRUE)`), filters to the target bundles and to published entities
(`published` key = 1) where those keys exist, takes up to 10 (`range(0, 10)`), and sets
`target_id` to a random one (`array_rand`). If none are found it adds a messenger message and
sets nothing.

## Add your own generator

1. Create `Plugin/Field/SampleValueGenerator/MyGenerator.php` extending `SampleValueGeneratorBase`.
2. Annotate with `@SampleValueGenerator(id, label, field_types = {…}, weight = N)`.
3. Implement `generateSampleValue(FieldItemListInterface $item_list)` to call
   `$item_list->setValue(...)` (or `generateSampleItems()`).
4. Optionally override `defaultConfiguration()` / `buildConfigurationForm()` for extra options
   (keep the `prevent_save` behavior from the base unless you replace it).
5. `drush cr` to clear the plugin cache; the new option appears on any applicable field's settings
   form.

## Notes

- If no generator is explicitly selected, the field's config carries no third-party setting and the
  entity generator leaves the field alone (its real default/emptiness is respected). The README's
  "last option in the list will be selected" refers to the radios default when the box is checked.
- Random text stored with an editor format the current user cannot access is why the README
  suggests `drush cset filter.settings fallback_format <format_id>` to set the global default.
