# Aggregator API

## Services

| Service | Class | Use |
|---|---|---|
| `aggregator.items.importer` | `ItemsImporter` | Run/undo the import pipeline for a feed. |
| `plugin.manager.aggregator.fetcher` | `AggregatorPluginManager` | Discover/instantiate fetcher plugins. |
| `plugin.manager.aggregator.parser` | `AggregatorPluginManager` | Discover/instantiate parser plugins. |
| `plugin.manager.aggregator.processor` | `AggregatorPluginManager` | Discover/instantiate processor plugins. |
| `keyvalue.aggregator` | `KeyValueAggregatorFactory` | Key/value store used for feed hashes. |
| `logger.channel.aggregator` | — | `aggregator` log channel. |

### ItemsImporter (`ItemsImporterInterface`)

```php
$importer = \Drupal::service('aggregator.items.importer');
$feed = \Drupal::entityTypeManager()->getStorage('aggregator_feed')->load($fid);
$importer->refresh($feed);   // fetch → parse → process (returns bool)
$importer->delete($feed);    // remove all stored items for the feed
```

Also: `getHash()`, `setHash()`, `deleteHash()` for change detection.

## Content entities

**`aggregator_feed`** (`Entity\Feed` implements `FeedInterface`, base table `aggregator_feed`,
id key `fid`). Convenience methods on `FeedInterface`:
`getUrl()/setUrl()`, `getRefreshRate()/setRefreshRate()` (seconds),
`getLastCheckedTime()`, `getQueuedTime()`, `getWebsiteUrl()`, `getDescription()`,
`getImage()`, `getEtag()`, `getLastModified()`, `getHash()`,
plus `refreshItems()` and `deleteItems()` (delegate to the importer),
and `getItems()/setItems()` / `getSourceString()/setSourceString()` used mid-pipeline.

**`aggregator_item`** (`Entity\Item` implements `ItemInterface`, id key `iid`). Methods:
`getFeedId()/setFeedId()`, `getTitle()`, `getLink()`, `getAuthor()`, `getDescription()`,
`getPostedTime()`, `getGuid()`. Load them like any entity:

```php
$items = \Drupal::entityTypeManager()->getStorage('aggregator_item')
  ->loadByProperties(['fid' => $fid]);
```

## Import lifecycle

`hook_cron()` queues feeds whose `refresh` interval has elapsed into the
`aggregator_feeds` queue; the `AggregatorRefresh` queue worker (cron time 60s) then calls
`Feed::refreshItems()` → `ItemsImporter::refresh()`. Call `refresh()` directly to import
outside cron.
