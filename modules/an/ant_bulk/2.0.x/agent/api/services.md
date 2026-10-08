# Service: ant_bulk.manager (TranslationManager)

Service id `ant_bulk.manager` → `Drupal\ant_bulk\TranslationManager` (`final`).

Constructor args (from `ant_bulk.services.yml`):
`auto_node_translate.translator` (`Translator`), `entity_type.manager`, `messenger`.
Setter call: `setContentModerationInformation(@?content_moderation.moderation_information)` — the
`@?` makes content-moderation optional (null when the module is absent).

## Public methods

| Method | Purpose |
|---|---|
| `getNodes(array $bundles, $batch_size, $overwrite, array $languages, $status = FALSE): array` | Returns the nids to translate. `$languages` is a checkbox map (`['fr'=>1,'de'=>0]`); when `$overwrite` is false, nids already translated in the selected languages are removed; `$batch_size` slices the total; `$status` adds a `status = 1` filter. Uses `accessCheck(FALSE)`. |
| `getDefaultNodes(array $bundles, $status = FALSE): array` | Entity query for all nids of `$bundles`, `nid DESC`, optional published filter. |
| `getCheckboxSelectedKeys(array $values): array` | Keys of entries whose value `== 1`. |
| `getTranslatedNode(&$node, $languageId)` | Returns the existing translation or adds one. |
| `translateBatch($total, array $nodes, array $translations, $workflows, &$context)` | Batch worker — processes **1 node per step**: loads it, calls `Translator::translateNode()`, applies the moderation state when moderated + workflow given. |
| `static translateBatchSet($total, array $nodes, array $translations, $workflows, &$context)` | Batch operation callback; resolves the service from the container and delegates to `translateBatch()`. |
| `static translateFinished($success, $results, $operations)` | Batch finished callback; adds a status message with the processed count. |

## Translate programmatically

```php
/** @var \Drupal\ant_bulk\TranslationManager $manager */
$manager = \Drupal::service('ant_bulk.manager');

// nids of all 'article' nodes not yet translated to French (all nodes, published + unpublished).
$nids = $manager->getNodes(['article'], 0, FALSE, ['fr' => 1], FALSE);

$batch = [
  'title' => 'Translating…',
  'operations' => [
    [
      ['\Drupal\ant_bulk\TranslationManager', 'translateBatchSet'],
      [count($nids), array_values($nids), ['fr' => 1], []],
    ],
  ],
  'finished' => ['\Drupal\ant_bulk\TranslationManager', 'translateFinished'],
];
batch_set($batch);
// Under Drush: drush_backend_batch_process();
```

The actual translation (provider, credentials, field-by-field mapping) is delegated to
`auto_node_translate`'s `Translator::translateNode()`; this service only orchestrates node/language
selection and batching.
