# Selecting the active Purge queue

`purge_queues` has **no settings page of its own** (`configure` is null). It only contributes
queue plugins to Purge; you pick the active one through **Purge's** queue selection.

## In the UI

*Administration → Configuration → Development → Performance → Purge*
(`admin/config/development/performance/purge`) → the **Queue** section → change the queue engine
to **"Database unique"** or **"Database unique (upsert)"** (or "Database (extended)").

## Where the choice is stored

Purge stores the selected queue plugin id in its own config object:

```
purge.plugins:
  queue: database_unique
```

The config object does **not** exist until a non-default queue is chosen; when absent, Purge
falls back to the `database` plugin. Inspect the effective value with the Purge queue service
(more reliable than reading config, which may be missing):

```
drush php:eval 'print current(\Drupal::service("purge.queue")->getPluginsEnabled());'
# => database_unique   (or "database" by default)
```

## Setting it programmatically

Prefer Purge's own API so the queue is emptied/reinitialised correctly:

```php
\Drupal::service('purge.queue')->setPluginsEnabled(['database_unique']);
```

`setPluginsEnabled()` writes `purge.plugins:queue` (single value) and reloads the buffer. Setting
the raw config value works too but does not re-initialise the runtime queue:

```
drush config:set purge.plugins queue database_unique_upsert
```

## Notes

- Available ids from this module: `database_alt`, `database_unique`, `database_unique_upsert`
  (plus Purge core's `database`, `a_memory`, `file`, …). List them with
  `\Drupal::service('purge.queue')->getPlugins()`.
- Switching queues changes only the storage backend/dedup behavior; purgers, processors, and
  queuers are unaffected.
