# Manage tampers in code

Service **`feeds_tamper.feed_type_tamper_manager`**
(`Drupal\feeds_tamper\FeedTypeTamperManagerInterface`).

```php
$manager = \Drupal::service('feeds_tamper.feed_type_tamper_manager');
// Get the tamper meta wrapper for a feed type.
$meta = $manager->getTamperMeta($feed_type);          // pass TRUE to force a fresh instance

// Read.
$meta->getTamper($instance_id);                        // one Tamper plugin instance
$meta->getTampers();                                   // TamperPluginCollection (all)
$meta->getTampersGroupedBySource();                    // instances keyed by source

// Mutate (then save the feed type to persist).
$id = $meta->addTamper(['plugin' => 'trim', 'source' => 'title', 'weight' => 0]);
$meta->setTamperConfig($id, ['weight' => 5]);
$meta->removeTamper($id);
$meta->rectifyInstances();                             // drop tampers for removed sources
```

`FeedTypeTamperMetaInterface` extends `ObjectWithPluginCollectionInterface`, so the collection
persists into the feed type's third-party settings when the feed type entity is saved.

**How it runs:** `EventSubscriber\FeedsSubscriber` listens on Feeds parse events and pushes each
item through `Adapter\TamperableFeedItemAdapter`, applying the configured Tamper chain to each
source value before Feeds maps it. You normally don't call the subscriber directly.
