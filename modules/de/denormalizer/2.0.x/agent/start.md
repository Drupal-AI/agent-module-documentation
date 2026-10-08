<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Denormalizer (denormalizer) — agent index

Flattens Drupal content entities and webform submissions into plain `denormalizer_<id>` SQL tables for BI/ETL consumption. Version **2.0.0-alpha1**, core `^8.8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.

## What it provides
- **Config entity** `denormalizer_table` (`src/Entity/DenormalizerTable.php`) — one per denormalized table; holds source (`entity` / `non_entity`) and configuration (entity_type, bundle, selected base/bundle fields). Creates, populates, updates, deletes the backing DB table.
- **Settings config object** `denormalizer.settings` — global SQL mode, target DB, prefixes, cron cadence.
- **Queue worker plugin** `denormalizer_queue` (`src/QueueWorker/DenormalizerWorker.php`, `@QueueWorker`) — applies per-entity insert/update/delete to the table.
- **Hooks** (`denormalizer.module`): `hook_cron` (re-queues rows), `hook_entity_insert/update/delete` (queue sync via `DenormalizerTable::onContentEntityCrud`).

## Dependencies
- Required: none (core only). Optional/suggested: `webform` (webform_submission source), `duration_field` (duration widgets on cron intervals).

## Routes & permission
- `denormalizer.settings` → `/admin/config/development/denormalizer` (DenormalizerSettingsForm).
- `entity.denormalizer_table.*` collection/add/edit/delete under `/admin/structure/denormalizer-tables` (AdminHtmlRouteProvider).
- All gated by `administer denormalizer` (`restrict access: TRUE`).

## Solution docs
- [config/settings.md](config/settings.md) — the `denormalizer.settings` form, config keys, schema, cron.
- [entities/denormalizer-table.md](entities/denormalizer-table.md) — the `denormalizer_table` config entity, its form, table creation/population, sync queue & hooks, webform handling.
