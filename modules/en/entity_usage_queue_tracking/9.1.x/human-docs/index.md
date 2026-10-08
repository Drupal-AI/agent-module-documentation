# Entity Usage Queue Tracking — manual setup guide

**Entity Usage Queue Tracking** (`entity_usage_queue_tracking`) changes *when*
the [Entity Usage](https://www.drupal.org/project/entity_usage) module does its
work. Normally Entity Usage records "which entity references which" the instant
you save or delete a piece of content — synchronously, as part of the save. On
sites with content that references many other entities, that bookkeeping can add
noticeable latency to every save. This module moves that tracking into a queue
that is drained on cron instead, so saves stay fast and the reference data is
brought up to date the next time cron runs.

The trade-off is that reference data becomes *eventually* consistent rather than
instantly accurate: between a save and the next cron run, the usage records can
be momentarily stale. For that reason the maintainers describe the project as
experimental and deliberately hide the switch from the admin UI — you turn it on
in `settings.php`, not through a form. Only enable it if you are certain no
automated process relies on perfectly up-to-date usage data to update or delete
content.

The module also ships a Drush command, `drush clean_usage_table`, that prunes
duplicate and stale usage rows (for example references left pointing at outdated
revisions). Run it periodically — a cron job or crontab entry is the usual
approach — to keep the `entity_usage` table lean on high-churn sites. The module
adds no routes, permissions, or admin pages of its own, and it depends on the
Entity Usage module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, turn on queue mode in `settings.php`, and schedule the cleanup command.

There is **no configuration page** for this module. Queue mode is switched on
through a single line in `settings.php` (shown in Installation), because it is an
advanced, "know what you're doing" setting.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Turn on queue mode by adding this line to `settings.php`:

   ```php
   $config['entity_usage_queue_tracking.settings']['queue_tracking'] = TRUE;
   ```

   With this set, Entity Usage's own save/delete tracking hooks are stepped
   aside and replaced with queue items on the `entity_usage_tracker` queue.
3. Make sure **cron runs regularly** — the queue is processed on cron (with a
   worker time budget of 300 seconds), so how fresh your usage data stays
   depends on how often cron fires.
4. Periodically run the cleanup command to remove duplicate rows:

   ```bash
   drush clean_usage_table
   ```

   Add `--pointing` to also drop rows where a source references itself:

   ```bash
   drush clean_usage_table --pointing
   ```

To go back to real-time tracking, remove the `queue_tracking` line (or set it to
`FALSE`) and rebuild caches.
