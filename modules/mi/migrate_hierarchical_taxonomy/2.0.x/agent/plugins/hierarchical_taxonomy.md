<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate process plugin `hierarchical_taxonomy`

Class `Drupal\migrate_hierarchical_taxonomy\Plugin\migrate\process\HierarchicalTaxonomy`
(`src/Plugin/migrate/process/HierarchicalTaxonomy.php`), declared with the PHP attribute
`#[MigrateProcess(id: 'hierarchical_taxonomy')]`, **extending**
`Drupal\migrate_plus\Plugin\migrate\process\EntityGenerate`.

It takes an ordered list of source level values and resolves them into a nested chain of taxonomy
terms, creating any level that does not yet exist, and returns the **ID of the deepest level** so it can
be written to an `entity_reference` taxonomy field.

## Install / enable

1. Requires core `migrate` and `taxonomy`, plus contrib `migrate_plus` (`>=6.0.6, <7.0`). Core
   `^10.6 || ^11.4`, PHP `>=8.2`.
2. `composer require drupal/migrate_hierarchical_taxonomy` then
   `drush en migrate_hierarchical_taxonomy -y`.
3. Reference the plugin from a migration's `process:` section (see the example below) and run with
   `migrate_tools` (`drush migrate:import <id>`).

## Config keys (migration YAML, under the field's `process:` entry)

- `plugin: hierarchical_taxonomy` — selects this process plugin (required).
- `bundle:` — the taxonomy **vocabulary machine name** (`vid`) that terms are looked up in and created
  under (required). Used as both the `loadTree` vocabulary argument and the created term's `vid`.
- `source:` — an **ordered list** of the source properties/values, one per hierarchy level, outermost
  (root) first. The plugin iterates this list in order; each entry supplies the term name for that level.
- `ignore_case:` — present in the plugin's documented example, **but not consulted** by the current
  code. Matching is done with `$searchTerm == $termName` and stays **case sensitive** regardless of this
  flag (documented in `README.txt` as preserved historical behavior).

`parent` is set internally by the plugin before each create — it is not a key you configure.

## How it runs (from `transform()`)

1. If the destination property is a subfield (e.g. `field_topics/target_id`), only the field name part
   before `/` is kept and passed to `determineLookupProperties()` (inherited from `EntityGenerate`).
2. `$result` starts as `FALSE` and `$parent` starts at `0` (root).
3. For each `$level` in `configuration['source']`:
   - If `empty($value[$level])` the level is **skipped** (this also skips a PHP-empty `'0'` and `NULL`).
   - Otherwise `$searchTerm = trim($value[$level])` (leading/trailing whitespace removed).
   - `entityTypeManager->getStorage('taxonomy_term')->loadTree($bundle, $parent, 1, TRUE)` loads the
     **immediate children** (depth `1`) of the current parent, as loaded term entities.
   - The children are scanned; if a term's `getName()` **equals** `$searchTerm`, its ID becomes
     `$result`. The loop does **not** break, so when siblings share a name the **last match wins**.
   - If no sibling matched (`!$result`), `configuration['parent']` is set to the current `$parent` and
     the inherited `generateEntity($searchTerm)` creates the term (via `EntityGenerate`).
   - `$parent = $result` — the resolved/created ID becomes the parent for the next level.
4. Returns `$result`: the deepest resolved/created term ID, or `FALSE` if every level was empty.

### `entity()` override

`entity($value): array` builds the values used when creating a term:
`['name' => $value, 'vid' => $lookupBundle, 'parent' => $this->configuration['parent']]`. This adds the
`parent` to the standard `EntityGenerate` create values so new terms nest under the current branch.

### Factory pinning (`create()`)

`create()` calls the parent and then sets the inherited lookup properties for taxonomy terms:
`lookupValueKey = 'name'`, `lookupBundleKey = 'vid'`, `lookupEntityType = 'taxonomy_term'`.

## Behavior notes

- **Unlimited depth:** depth is simply the length of the `source` list; each level is resolved relative
  to the parent found for the previous level.
- **Contextual lookup:** a name is matched only among the *immediate children of the current parent*, so
  the same name under different parents (or different vocabularies) yields distinct terms.
- **Reuse:** re-running the same path reuses existing terms — no duplicates are created for a path that
  already exists end to end.
- **Empty levels:** skipped without breaking the chain; a level present after an empty one still nests
  under the last non-empty level's term. All-empty input returns `FALSE`.
- **Whitespace:** values are trimmed before matching and creation.
- **Case:** matching is case sensitive; `ignore_case` does not change this in the current code.
- **Stub rows:** follow the same lookup/create path and keep their stub flag (covered by the unit test).
- The plugin does **not** apply `EntityGenerate` `values`/`default_values`; only name, vid and parent are
  set on created terms.

## Full example migration

```yaml
id: topics
label: Topics (hierarchical)
migration_group: legacy
source:
  plugin: embedded_data
  data_rows:
    - id: 1
      continent: Europe
      country: France
      city: Paris
    - id: 2
      continent: Europe
      country: France
      city: Lyon
  ids:
    id:
      type: integer
process:
  field_place/target_id:
    plugin: hierarchical_taxonomy
    bundle: places
    source:
      - continent
      - country
      - city
destination:
  plugin: 'entity:node'
  default_bundle: article
```

Row 1 creates `Europe` (parent 0) → `France` (under Europe) → `Paris` (under France) and writes Paris's
ID to `field_place`. Row 2 reuses `Europe` and `France` and only creates `Lyon` under France.

## Trust / operating model

The plugin runs only when an operator imports a migration (Drush / admin migrate UI). The source level
values and target `bundle` are authored by the developer who writes the migration. Imported terms are
content created from source data — validate the source before importing, and rehearse representative
migrations on a copy of the site database before production (per `README.txt`).
