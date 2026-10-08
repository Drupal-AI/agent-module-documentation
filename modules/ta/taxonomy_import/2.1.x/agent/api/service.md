# Programmatic import — `taxonomy_import.term_utils`

Service id `taxonomy_import.term_utils`, class
`Drupal\taxonomy_import\Service\TaxonomyUtils` (interface `TaxonomyUtilsInterface`), constructed
with `@entity_type.manager`. This is what the import form calls; you can call it directly to
import terms without a file/UI.

## `saveTerms($vid, array $rows, $forceNewTerms)`

- `$vid` — an **existing** vocabulary machine name.
- `$rows` — an array of associative arrays, each with keys `name`, `parent`, `description`
  (extra keys are treated as custom-field candidates, set only if a matching term field exists).
- `$forceNewTerms` — `1`/TRUE = always create a new term; `0`/FALSE = update a same-named term.

For each row it resolves the parent by term **name** within `$vid` (last match wins, else `0`),
then either `updateTerm()` (when a same-named term exists and `$forceNewTerms` is falsey) or
`createTerm()`.

```php
$utils = \Drupal::service('taxonomy_import.term_utils');
$rows = [
  ['name' => 'Fruit',  'parent' => '',      'description' => 'Top level'],
  ['name' => 'Apple',  'parent' => 'Fruit', 'description' => 'A pome fruit'],
  ['name' => 'Banana', 'parent' => 'Fruit', 'description' => 'A tropical fruit'],
];
$utils->saveTerms('tags', $rows, 0);   // 0 = update existing by name; 1 = force new
```

## Other methods (`TaxonomyUtilsInterface`)

- `loadTerm($vid, $name)` — first term in `$vid` with that name, or NULL.
- `createTerm($vid, $name, $parentId, $description, $rowData, $termCustomFields)` — create + save.
- `updateTerm($vid, $term, $parentId, $description, $rowData, $termCustomFields)` — save only if
  the parent/description/custom fields actually changed.
- `getTermParentIds($term)` — the IDs of a term's existing parents.
- `createVocabulary($vocabularyName)` — **avoid**: this method references an undefined `$name`
  variable, so create vocabularies with `Vocabulary::create()` yourself first.

There are no Drush commands; `saveTerms()` via `drush php:eval` (or a custom script) is the
scriptable path.
