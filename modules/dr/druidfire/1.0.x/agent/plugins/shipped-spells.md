<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The five shipped spells

All live in `src/Plugin/Spell/`, extend `SpellBase`, and are annotated `@Spell`. The plugin **id**
is what you pass as the service method / Drush subcommand. `$this->schema` = the DB `Schema` object;
`$this->database` = the `Connection`.

## `resize` — `Resize.php`

- Label "Resize"; "Resizes a text or string field to a new length." Const `DEFAULTSIZE = 1024`.
- `schema()`: sets `$schema[$table]['fields'][$column]['length'] = $args['size'] ?? 1024` and calls
  `$this->schema->changeField($table, $column, $column, …)`.
- `storage()`: sets `$yaml['settings']['max_length'] = $args['size'] ?? 1024`.
- No `field`/display changes. Args: `size` (int), optional `property` (resolves which column).
- Use on `string`/`varchar`-backed fields to raise (or lower) max length in place.

## `string2formatted` — `String2Formatted.php`

- Label "String to Formatted Text". Converts a plain string field to `text_long`.
- `schema()`: changes the value column to `{type: text, size: big}` via `changeField()`; derives the
  format column name (`_value` → `_format`), adds a `varchar_ascii(255)` field plus an index for it
  (`addField` + `addIndex`).
- `storage()`: `type = 'text_long'`. `field()`: `field_type = 'text_long'`.
- `formDisplay()`: widget `text_textarea`, removes `settings.size`, sets `settings.rows = 9`.
  (No `viewDisplay()` override → view display widget unchanged.)

## `err2er` — `Err2Er.php`

- Label "ERR to ER". Entity Reference Revisions → plain Entity Reference.
- `schema()`: rewrites the column name `target_id` → `target_revision_id`, then
  `dropField()` that revision column and unsets it from `fields` and `indexes`.
- `storage()`: `type = 'entity_reference'`. `field()`: `field_type = 'entity_reference'`.
- `formDisplay()`: rewrites the widget `type` `entity_reference_revisions_` → `entity_reference_`.
  `viewDisplay()`: delegates to `formDisplay()` (same string replace).

## `err2bricks` — `Err2Bricks.php`

- Label "ERR to Bricks". ERR → Bricks `bricks_revisioned` (requires the contrib **Bricks** field
  type to exist).
- `schema()`: from `{base}_target_id` derives base name and `addField()`s two columns:
  `{base}_depth` (`int`, `tiny`, unsigned, nullable) and `{base}_options` (`blob`, `normal`,
  nullable, `serialize: TRUE`); merges them into the schema `fields`.
- `storage()`: `type = 'bricks_revisioned'`. `field()`: `field_type = 'bricks_revisioned'`.
- `formDisplay()`: unchanged (no-op). `viewDisplay()`: sets widget `type = 'bricks_revisions_nested'`.

## `string2taxonomyReference` — `String2TaxonomyReference.php`

- Label "String to Taxonomy Reference". String field → taxonomy-term entity reference. **Requires
  `args['vid']`** (vocabulary id) or `schema()` throws `InvalidArgumentException`.
- `schema()`: derives new column (`_value` → `_target_id`) and `addField()`s an unsigned `int`. Then:
  - Selects distinct existing values (via `$this->database->escapeField($column)`, vocabulary passed
    as bound `:vid`) that have **no** matching term name in `taxonomy_term_field_data`, and creates
    those `Term`s (`Term::create($data)->save()`).
  - `UPDATE`s the new `_target_id` column from a correlated subquery matching term name = value in
    that vocabulary.
  - `dropField()`s the original value column.
- `storage()`: `type = 'entity_reference'`, `settings.target_type = 'taxonomy_term'`.
- `field()`: `field_type = 'entity_reference'`, handler `default:taxonomy_term`, `target_bundles`
  `{vid: vid}` (empty if no vid), `auto_create = FALSE`.
- `formDisplay()`: widget `entity_reference_label` with `settings.link = FALSE`.
  `viewDisplay()`: widget `options_select`.

## Argument shapes (as the service receives them)

`->resize($type, $field, ['size' => 1024, 'property' => 'title'])` ·
`->string2formatted($type, $field)` · `->err2er($type, $field)` · `->err2bricks($type, $field)` ·
`->string2taxonomyReference($type, $field, ['vid' => 'tags'])`. The optional third array is the
`$optionalArguments` passed through to every spell method (and `property` also steers column
resolution in `FieldInspector::getColumnName()`).
