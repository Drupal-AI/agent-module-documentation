# Service API

Service id `node_revision_delete` (`Drupal\node_revision_delete\NodeRevisionDelete`,
interface `NodeRevisionDeleteInterface`; also autowirable by the interface name).

```php
$nrd = \Drupal::service('node_revision_delete');

$ids   = $nrd->getPreviousRevisionIds($nid, $currentlyDeletedVid, $langcode);
$revs  = $nrd->getPreviousRevisions($nid, $currentlyDeletedVid, $langcode);
$queued = $nrd->nodeExistsInQueue($nid);                 // bool
$result = $nrd->createQueueItem($nid);                   // QueueItemCreationResult
$nrd->removeNodeFromQueueMap($nid);
$has  = $nrd->contentTypeHasEnabledPlugins($contentTypeId);  // bool
$vids = $nrd->getActiveVidsPerLanguage($node);           // active vid per language
```

Batch operations live in `node_revision_delete.batch`
(`NodeRevisionDeleteBatchInterface`) for UI/Drush-driven bulk deletion.
`createQueueItem()` returns a `QueueItemCreationResult` describing whether/why an item was
created. Use these to integrate revision pruning into custom workflows or reports.
