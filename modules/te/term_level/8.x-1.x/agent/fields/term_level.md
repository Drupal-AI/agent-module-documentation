<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `term_level` field type, widget and formatter

## Install & enable

```bash
composer require drupal/term_level
drush en term_level -y
```

Only dependency is core **`taxonomy`**. No sub-modules, no permissions, no Drush commands, no
routes. To include the level value in HAL+JSON serialization, also enable core **`hal`** (the
`term_level.normalizer` service extends a hal class, so without hal the class cannot load — see
below).

## Add a field

In Field UI (*Structure → (bundle) → Manage fields → Add field*) choose **Term level** (the field
type id is `term_level`, label "Term level", listed under the *reference* category). The target
entity type is fixed to `taxonomy_term` by `TermLevelItem::defaultStorageSettings()` — you cannot
point it at another entity type.

## Field storage settings: the level list

The only extra storage setting is **`levels`** (`storageSettingsForm()` in `TermLevelItem.php`), a
**required textarea**, disabled once the field has data (`#disabled => $has_data`). Enter one level
per line:

```
1|Beginner
2|Intermediate
3|Advanced
4|Expert
```

Rules enforced by `validateLevels()`:

- Each line must contain a `|`; the part before it is the **level key**, the part after is the
  **label**.
- The level key must match `/^\d+$/` — a **non-negative integer**. A non-numeric key fails with
  *"The level key must be positive integer."*
- At least one valid level must parse, or the form errors with *"Please enter valid levels."*

`TermLevelItem::extractLevels($value)` is the shared parser: it splits on `\n`, trims, drops empty
lines, and for every line containing `|` does `list($key, $label) = explode('|', $line)` into a
`[key => label]` array. (Note: `explode('|', ...)` without a limit means a label that itself
contains `|` is truncated at the first `|`.)

## Storage schema

`TermLevelItem::schema()` extends the entity-reference schema with:

- column `level`: `int`, `unsigned`;
- index `level` on that column.

`propertyDefinitions()` adds a `level` integer property (`unsigned = TRUE`, label "Level").
So each field item row carries the standard `target_id` (the term id) plus `level` (the numeric
key).

## Widget: `term_level_widget`

`TermLevelWidget` extends core `EntityReferenceAutocompleteWidget` and, in `formElement()`:

- renders the normal term autocomplete as `target_id` (re-titled **"Term"**, weight 0);
- adds a **`level` `<select>`** (weight 1, title "Level") whose `#options` are
  `TermLevelItem::extractLevels($field_settings['levels'])` — i.e. the key→label map from the
  field settings — with `#default_value` set to the item's stored `level`.

All the usual autocomplete widget settings (match operator, size, placeholder) still apply.

## Formatter: `term_level_formatter`

`TermLevelFormatter` extends core `EntityReferenceLabelFormatter` (so it inherits the "link to the
referenced entity" setting). In `viewElements()` it:

1. calls the parent to build the per-term label elements;
2. reads the raw item values and the field's `levels` map;
3. for each delta, if the stored `level` key **still exists** in the current `levels` map, appends
   a child element `['#markup' => ' : ' . $levels[$level]]`.

The guard (`if (isset($levels[$level]))`) means an outdated level value left in the database after
the level list changed simply renders no suffix instead of erroring. The label text is the
administrator-defined level label from field settings (not end-user input).

## Config schema

`config/schema/term_level.data_types.schema.yml`:

| Schema key | Type | Notes |
|---|---|---|
| `field.storage_settings.term_level` | `base_entity_reference_field_settings` + `levels` (text) | The newline `key|label` list. |
| `field.field_settings.term_level` | `field.field_settings.entity_reference` | Inherits entity-reference field settings. |
| `field.value.term_level` | `field.value.entity_reference` + `level` (int) | Default-value schema, adds the level key. |

## HAL normalizer (optional, requires `hal`)

Service `term_level.normalizer` → `TermLevelItemNormalizer` (tagged `normalizer`, priority 100),
`supportedInterfaceOrClass = TermLevelItem::class`. It extends
`Drupal\hal\Normalizer\FieldItemNormalizer` and overrides `normalizedFieldValues()` to add
`$value['level'] = $field_item->level` on top of the parent's entity-reference normalization, so
HAL+JSON output for the field includes the level. Because the parent class lives in the **`hal`**
module — which is **not** declared in `term_level.info.yml` — this normalizer is only relevant on
sites where `hal` is enabled; the service is defined unconditionally.

## Operating notes

- The level scale is **per field** (storage-level), not global. Two `term_level` fields can have
  different scales.
- The stored value is the numeric **key**, so the scale is orderable — you can sort/filter on
  `level` in Views or queries. Labels are display-only and resolved from settings at render time.
- Changing a level's label later re-labels existing values automatically (labels aren't stored);
  removing a key hides its suffix in the formatter but leaves the numeric value in the DB.
- The vocabulary itself is chosen through the normal entity-reference handler settings
  (target bundles), just like any core term reference field.
