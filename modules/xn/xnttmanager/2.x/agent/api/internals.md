# Internals — helper functions, batch callbacks, service

No public plugin type or drush command. The integration surface is a handful of procedural helpers in
`xnttmanager.module`, two Batch API callbacks, and one logger service.

## Helper functions (`xnttmanager.module`)

- `xnttmanager_get_external_entity_type_list(): array` — `[machine_name => entity_type_id]` of every
  `external_entity_type` whose **required fields are all mapped** (checks each required field's
  `getFieldMapper()`→`getPropertyMapper()`). This is why some types don't appear in the UI selects.
- `xnttmanager_get_synchronized_external_entity_list(): array` — `[xnttType => collection_label]` for
  the types that currently have an `xnttsync` cron.
- `xnttmanager_get_content_entity_type_list(): array` — `["node/<bundle>" => label]` for all node
  bundles (target content types; **nodes only** — there is a `@todo` to broaden this).

## Batch callbacks

`xnttmanager_bulk_process($params, &$context)` — the single batch operation used by both the
management form and the sync form. Behaviour is switched by `$params`:

| Param | Effect |
|---|---|
| `xntt_type` | (required) external type machine name. |
| `save` | `->save()` each loaded external entity. |
| `annotate` | create a missing annotation content per entity (type must be annotatable). |
| `sync_stats` | count missing / different / orphan local content; **write nothing**. |
| `sync` | full sync: create/update/delete local content. |
| `content_type` | `"<entity_type>/<bundle>"` target for sync/stats. |
| `sync_add_missing` / `sync_update_existing` / `sync_remove_orphans` | per-action toggles for `sync`. |

It walks the source in pages of 5 (`$data_aggregator->query([], [], $offset, 1)` per record),
accumulates counters in `$context['sandbox']`, and on completion runs orphan detection
(`content_store->getQuery()->accessCheck(FALSE)->condition('xnttid', $seen, 'NOT IN')…`) and, for
`sync_remove_orphans`, deletes them. Errors are collected and logged, not fatal.

`xnttmanager_bulk_finished($success, $results, $operations)` — formats a plural-aware status/log
message (loaded/saved/annotations, sync stats, created/updated/removed, error counts).

Both callbacks are registered via `ManagementForm::launchBatchProcessing()` /
`SyncForm::launchBatchProcessing()` as `operations => [['xnttmanager_bulk_process', [$params]]]`,
`finished => 'xnttmanager_bulk_finished'`.

## Content model created by sync

Sync writes to a **node** bundle carrying two extra string fields the module creates on demand:

- `xnttid` — the external entity's id (the join key against the source).
- `xntttype` — the external entity type machine name.

Field-by-field update skips `id`, `uuid`, `xnttid`, `nid`, `default_langcode`. New nodes get `uid` 1
(cron) or the current user (interactive batch) when the source supplies none.

## Service

- `logger.channel.xnttmanager` — a `LoggerChannel` (factory `logger.factory:get`, arg `xnttmanager`).
  All notices/warnings/errors from cron, sync and batch go here. No other services are defined
  (`xnttmanager.services.yml`).
