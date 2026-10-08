# Queue Order — manual setup guide

**Queue Order** (`queue_order`) is a tiny operations module that lets you control
the **order** in which Drupal's queue workers run during cron. Out of the box, core
processes cron‑enabled queues in an undefined order; Queue Order adds support for a
`weight` value in a QueueWorker's annotation so you can say which queues should run
first.

This matters when one queue is more time‑sensitive than another — for example,
sending notifications should probably run before a background cleanup task. Give the
important worker a lower (more negative) weight and it runs earlier in the cron pass:

```php
/**
 * @QueueWorker(
 *   id = "custom_media_entity_thumbnail",
 *   title = @Translation("Custom thumbnail downloader"),
 *   cron = {"time" = 60},
 *   weight = -10
 * )
 */
class CustomThumbnailDownloader extends ThumbnailDownloader {}
```

One important nuance: Queue Order controls **order, not capacity**. If cron doesn't
have enough time to process every queue, ordering decides *what runs first*, not
*whether everything runs*. If you want to override the weight of a worker you don't
own, install the **Queue UI** module and set it there.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — ordering is set through the
`weight` value in each QueueWorker's annotation (or via the Queue UI module for
workers you cannot edit), not through a settings form.

## How to use it

Enable the module, then add a `weight` to your QueueWorker annotations as shown
above — lower weights run first. To adjust the weight of a worker provided by
another module, install **Queue UI** and change it there. No admin configuration is
needed for Queue Order itself.
