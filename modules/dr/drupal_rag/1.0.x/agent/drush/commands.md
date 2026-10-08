<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands & queue backfill

`Drush\Commands\DrupalRagQueueCommands` (uses `AutowireTrait`; deps `config.factory`,
`entity_type.manager`, `queue`).

## `drupal-rag:queue-all` (alias `rag:qa`)

Backfills existing content into the RAG index. Reads `enabled_entity_types` from
`drupal_rag.settings`; if empty, logs a warning and stops (configure the settings form first). For
each enabled entity type it runs a bulk entity query, adds `condition(status_key, 1)` when the type
has a `status` key (so only *published* entities are queued), loads them, and pushes one item per
entity onto the `drupal_rag_entity_processing` queue
(fields: `entity_type`, `entity_id`, `event_type` = `entity_insert`, `entity_label` via
`self::getLabel()`, `bundle`, `langcode`). Logs per-type and total counts.

```bash
drush drupal-rag:queue-all      # or: drush rag:qa
drush queue:run drupal_rag_entity_processing   # process now (else cron drains it, time:60/run)
```

## Processing the queue

Queued items are processed by `DrupalRagEntityProcessingWorker` (see
[services/pipeline.md](../services/pipeline.md)) — automatically on **cron** (`cron: {time: 60}`
per run) or immediately via `drush queue:run drupal_rag_entity_processing`. Each processed item
extracts → chunks → embeds → upserts vectors; check totals at `/admin/reports/drupal-rag`.

## `getLabel()` helper

`DrupalRagQueueCommands::getLabel($entity)` (static, also used by `EntityHooks`): `node` → label,
`file` → filename, otherwise the entity id.
