<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Recalculating depths, Views & uninstall

There is no settings form. "Configuration" here means (re)building the stored depths, using the
field in Views, and preparing for uninstall.

## Recalculate depths

Depth is maintained automatically on term save, but you re-run a full calculation after bulk
imports or when installing on an existing site.

- **UI:** each vocabulary has an **Update term depths** local task / entity operation:
  `/admin/structure/taxonomy/manage/{taxonomy_vocabulary}/taxonomy_term_depth_update`
  (route `taxonomy_term_depth.update_depth_form`, permission `administer taxonomy`).
- **On install:** `hook_install()` queues all terms via the queue service's `queueBatch()`.
- **Programmatically** via the queue manager service `taxonomy_term_depth.queue_service`
  (`Drupal\taxonomy_term_depth\QueueManager\Manager`):

```php
$qm = \Drupal::service('taxonomy_term_depth.queue_service')->setVid('my_vocab');
$qm->queueBatch();          // clear + queue ALL terms in the vocab, then process now
$qm->queueBatchMissing();   // only terms whose depth_level is NULL
$qm->clear();               // empty the queue
$size = $qm->queueSize();   // items pending
// convenience wrapper:
taxonomy_term_depth_queue_manager('my_vocab')->queueBatch();
```

Omit `setVid()` (or pass NULL) to operate across all vocabularies. `queueBatch()` clears the
existing depth values for the targeted terms, queues them in batches of 20, and processes the
queue immediately with the `taxonomy_term_depth_update_depth` QueueWorker (whose `processItem()`
calls `taxonomy_term_depth_get_by_tid($tid, TRUE)`); the worker also runs on cron.

Alternatively, force a single term: `taxonomy_term_depth_get_by_tid($tid, TRUE)`.

## Views integration

`hook_views_data_alter()` adds a **Depth** field to `taxonomy_term_field_data`
(`depth_level`): a numeric **field**, a standard **sort**, and a numeric **filter**. Use it to
show only depth-1 terms, cap a listing at a maximum level, or sort a hierarchy outline.

## Uninstalling

A populated base field blocks uninstall, so the module provides:

- A **`DepthUninstallValidator`** (service `taxonomy_term_depth.uninstall_validator`) that stops
  uninstall while depth data exists.
- A **Delete taxonomy term depths data** form at `/admin/modules/uninstall/taxonomy_term_depth`
  (route `taxonomy_term_depth.prepare_modules_uninstall`).
- A legacy Drush command **`term-depth-prepare-uninstall`** (alias **`tdpu`**) that nulls every
  `depth_level` value so the module can then be uninstalled.
