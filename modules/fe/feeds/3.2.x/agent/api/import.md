# Import programmatically

Load a `feeds_feed` entity and drive the pipeline from its methods
(`Drupal\feeds\FeedInterface`, `src/Entity/Feed.php`).

```php
$feed = \Drupal::entityTypeManager()->getStorage('feeds_feed')->load($fid);

$feed->import();                 // run the full fetch→parse→process import synchronously
$feed->startBatchImport();       // run import as a Batch API operation (UI/large sets)
$feed->startCronImport();        // queue the import for the next cron run
$feed->pushImport($raw_string);  // process a raw payload you already have (PuSH/webhook)

$feed->startBatchClear();        // delete all items this feed imported
$feed->startBatchExpire();       // remove items past the feed type's expire time

$feed->lock(); $feed->isLocked(); $feed->unlock();   // concurrency control
$feed->getState($stage);         // per-stage progress (FETCH/PARSE/PROCESS/…)
$feed->getItemCount();           // number of items imported by this feed
```

Create a feed of an existing feed type:

```php
$feed = \Drupal::entityTypeManager()->getStorage('feeds_feed')->create([
  'type' => 'my_feed_type',
  'title' => 'Nightly import',
  'source' => 'https://example.com/data.csv',
]);
$feed->save();
$feed->import();
```

- `getSource()/setSource()`, `getImportPeriod()`, `getNextImportTime()`, `getImportedTime()`,
  `isActive()/setActive()` manage scheduling and the source location.
- Plugin config for a feed type: `$feed->getConfigurationFor($plugin)` /
  `setConfigurationFor()`. Read a target's plugin managers via `plugin.manager.feeds.*`.
- Prefer the Drush commands ([../drush/commands.md](../drush/commands.md)) for CLI/cron jobs;
  hook into stages via events ([../extend/events.md](../extend/events.md)).
