<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Summary Word Limit (summary_word_limit) — agent index

Adds a maximum **word count** to the summary of core `text_with_summary` fields (*Text
(formatted, long, with summary)*). Package `Fields`. Core `^10 || ^11`. License
GPL-2.0-or-later. **No dependencies outside core.** No routes, no permissions, no Drush, no
config entity, no config schema, no settings page.

- **Enable it, set a limit on a field, config-export equivalent, and the mechanism** →
  [fields/word-limit.md](fields/word-limit.md)

## What it actually is

- The limit is a **third-party setting** (`summary_word_limit.summary_word_limit_count`, an
  integer) stored **on the FieldConfig** of a `text_with_summary` field — it lives with the field,
  not in a global settings form. `0`/empty = no limit.
- Enforcement is a **validation constraint**, so it fires wherever the entity is validated: the
  node form **and** REST, JSON:API, migrations and programmatic `$entity->save()` paths.

## Provided code (all of it)

- `summary_word_limit.module`:
  - `hook_form_field_config_edit_form_alter()` + entity-builder
    `summary_word_limit_field_config_edit_form_builder()` — adds the **Summary word limit count**
    number field to the field-edit form (visible only when *Summary input* is checked) and
    saves/unsets the third-party setting.
  - `hook_entity_bundle_field_info_alter()` — attaches the `SummaryWordLimit` constraint to any
    `text_with_summary` field that has a non-zero limit set.
  - `hook_help()` — the module help page.
- Constraint plugin `SummaryWordLimit` (id `SummaryWordLimit`, type `string`) in
  `src/Plugin/Validation/Constraint/SummaryWordLimit.php` — holds the violation message
  `overWordLimit`.
- `SummaryWordLimitValidator` in the same dir — counts `str_word_count($item->summary)` and adds a
  violation when it exceeds the configured count.

Two classes plus one `.module` file; that is the entire module.
