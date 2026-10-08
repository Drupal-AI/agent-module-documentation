# Migrate Batch — manual setup guide

**Migrate Batch** (`migrate_batch`) is a developer tool that adds **batch
processing with automatic offset tracking** to Drupal's migration system. Where
core's `drush migrate:import --limit` starts over each time, Migrate Batch
remembers where it stopped: each run processes the next chunk of source items and
advances a stored offset, so you can cycle through a very large source in
predictable, resumable batches.

The problem it solves is running big migrations without exhausting memory or time
limits, and being able to drive that chunking from your own code or from CI. It
exposes both a **service** you call from custom code (or a hook) and a set of
**Drush commands** for the same thing. Progress is kept in Drupal's State API, so
it survives between runs.

There is **no settings form** — you use it from Drush or from PHP. It depends only
on core's **Migrate** module and runs on **Drupal 10 and 11**. For very large
datasets, source plugins can opt into true LIMIT/OFFSET fetching by using the
module's `BatchableSourceTrait` (a developer step in your source plugin, not a
UI setting).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it's driven from Drush and
from code, as described below.

## How to use it

### From Drush

| What it does | Command | Alias |
|--------------|---------|-------|
| Process the next batch of items | `drush migrate:batch-next` | `mbn` |
| Show the current offset | `drush migrate:batch-offset` | `mbo` |
| Set the offset to a specific value | `drush migrate:batch-offset:set` | `mbos` |
| Reset the offset back to 0 | `drush migrate:batch-offset:reset` | `mbor` |

Call `migrate:batch-next` repeatedly (for example from a scheduled CI job) to walk
through the whole source a batch at a time.

### From your own code

Use the `migrate_batch` service directly:

```php
/** @var \Drupal\migrate_batch\Service\MigrateBatchService $batch */
$batch = \Drupal::service('migrate_batch');

// Process a batch of the default size (20 items).
$batch->next('my_migration');

// Process the next 50 items.
$batch->next('my_migration', 50);

// Process 50 items starting from offset 100.
$batch->next('my_migration', 50, 100);

// Inspect / manage the stored offset.
$offset = $batch->getOffset('my_migration');
$batch->setOffset('my_migration', 100);
$batch->resetOffset('my_migration');
```

The service tracks progress automatically via the State API; each `next()` call
processes a batch and advances the offset.

### Optional source‑plugin integration

For best performance on large datasets, have your source plugin use the
`BatchableSourceTrait`, which provides `isBatchRequest()`, `getBatchLimit()` and
`getBatchOffset()`. Apply the returned limit and offset in the plugin's
`initializeIterator()` so only the current batch is actually fetched from the
source. See the project README for a worked example.
