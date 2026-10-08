# Queue Import — manual setup guide

**Queue Import** (`queue_import`) is a developer‑oriented tool for importing content
into a Drupal site using Drupal's **Queue API**. Instead of pulling everything in
one long, fragile request, it queues the incoming data and processes it in
background/cron batches with QueueWorkers, so large imports run reliably and can be
re‑run to update content on follow‑up passes. It handles media and file assets for
imported content, and it is aimed at migrating content from almost anywhere —
including scraping a URL or connecting directly to a legacy database.

Its headline use case is importing content out of a **legacy Drupal 7 database**:
you point the module at the D7 database, it reads the fields for a content type and
scaffolds a QueueWorker (a "map" class) for it, you fix up the field mapping, and
then you queue and process the content into your new site. Mapping on the legacy
Node ID means later imports can update the same content rather than duplicating it.

This is very much a hands‑on, Drush‑driven module (the maintainer describes parts of
the D7 workflow as still in progress), so expect to work at the command line and to
edit a generated PHP map class. It is not a point‑and‑click importer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the database‑connection form used for
   the Drupal 7 import workflow.

## Where it lives in the admin menu

The one admin screen is the database‑connection form at **Configuration →
Development → Queue Import** (`/admin/config/development/queue-import`), described in
[Configuration](configuration/index.md). Everything else is done with Drush.

## How to use it

A quick way to see the mechanism is the built‑in example, which queues and imports a
single article:

```bash
drush itest
drush queue-run node_queue_processor -v
```

The full Drupal 7 import workflow runs like this:

1. Fill in the D7 database connection on the form at
   `/admin/config/development/queue-import` (see [Configuration](configuration/index.md)).
2. `drush d7fm article` — generate a map class for the content type (this creates
   `MapArticleQueueProcessor.php`; `page` would create `MapPageQueueProcessor.php`,
   and so on).
3. Fix the field mapping inside that file and rename it to
   `ArticleQueueProcessor.php`.
4. `drush d7 article 1` — queue content of that type (the number is how many items
   to queue).
5. `drush queue-run article_queue_processor` — process the queued items into your
   site.
6. Review the results at **Content** (`/admin/content`) and check for errors. If you
   need to start over, `drush qicount article --delete` removes the imported
   content.
