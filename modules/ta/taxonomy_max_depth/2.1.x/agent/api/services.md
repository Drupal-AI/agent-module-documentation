# taxonomy_max_depth — services & helper API

Four services (all in `taxonomy_max_depth.services.yml`). The reader/writer store the limit on the
vocabulary's third-party settings; the helper does pure depth math on term arrays/trees.

## `taxonomy_max_depth.vocabulary_settings_reader`

`VocabularySettingsReader` (implements `VocabularySettingsReaderInterface`).

```php
$reader = \Drupal::service('taxonomy_max_depth.vocabulary_settings_reader');
// Accepts a VocabularyInterface OR a vocabulary id (string).
$max = $reader->getMaxAncestorDepth('tags'); // int|null (NULL = unlimited/unset)
```

Reads `third_party_settings.taxonomy_max_depth.max_depth`. Throws `\InvalidArgumentException` if a
vocabulary id is passed that doesn't exist.

## `taxonomy_max_depth.vocabulary_settings_writer`

`VocabularySettingsWriter` (implements `VocabularySettingsWriterInterface`).

```php
$writer = \Drupal::service('taxonomy_max_depth.vocabulary_settings_writer');
$writer->setMaxAncestorDepth($vocabulary, 3); // set the cap
$writer->setMaxAncestorDepth($vocabulary);    // or NULL -> unset (unlimited)
$vocabulary->save();                          // writer only mutates; you save
```

Returns `$this` (chainable). Does **not** save the vocabulary — call `->save()` yourself.

## `taxonomy_max_depth.term_tree_depth_helper`

`TermTreeDepthHelper` (implements `TermTreeDepthHelperInterface`) — no dependencies.

```php
$helper = \Drupal::service('taxonomy_max_depth.term_tree_depth_helper');

// Deepest ancestor chain implied by a set of parent Term entities (walks each term's
// 'parent' references upward). Returns an int depth (parents themselves count as 1).
$depth = $helper->getMaxAncestorDepth($parentTerms);

// Deepest level in a loadTree() result array (uses each item's ->depth, +1). Returns an int.
$depth = $helper->getMaxDescendantDepth($treeItems);
```

`getMaxAncestorDepth(array $parents)` takes an array of loaded `Term` entities.
`getMaxDescendantDepth(array $tree)` takes the array returned by
`TermStorage::loadTree($vid, $parent_tid, $max_depth)` (objects exposing a `->depth` property).

## Notes

- These services are what `TermFormAlterer` / `VocabularyFormAlterer` use internally; reuse them
  instead of re-reading third-party settings by hand.
- `FormAltererBase::MODULE_NAME` = `'taxonomy_max_depth'`, `MAX_DEPTH_KEY` = `'max_depth'` — the
  third-party settings namespace/key, if you need to read the raw config.
