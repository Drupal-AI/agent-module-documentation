<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Logging API & table schema

## The `event_log_track` table (`hook_schema`)

| Column | Type | Notes |
|---|---|---|
| `lid` | serial | Primary key. |
| `type` | varchar(50) | Handler/event type, e.g. `node`, `user`, `config`. |
| `operation` | varchar(50) | e.g. `insert`, `update`, `delete`, `save`, `login`. |
| `path` | varchar(2048) | Request path, or `cli`. |
| `ref_numeric` | int, nullable | Numeric reference (usually entity id). |
| `ref_char` | varchar(255), nullable | Character reference (label/name/config name). |
| `description` | medium text | HTML-stripped human description. |
| `uid` | int | User who triggered it (0 = anonymous). |
| `ip` | varchar(45), nullable | Client IP. |
| `created` | int | Unix timestamp. |

Indexes: `created`, `type_operation` (`type`,`operation`), `uid`, `ip`, `ref` (`type`,`ref_numeric`).

## `event_log_track.manager` — `EventLogTrackManager::insert(array &$log)`

Writes one row. You provide at least `type`, `operation`, `description`; it fills the rest:

```php
$manager = \Drupal::service('event_log_track.manager');
$log = [
  'type' => 'my_thing',
  'operation' => 'insert',
  'description' => 'Created my thing "Foo"',
  'ref_numeric' => 42,        // optional
  'ref_char' => 'Foo',        // optional
];
$manager->insert($log);
```

Behaviour of `insert()`:
- **Skips entirely if running under CLI and `log_cli` is not TRUE** (so Drush/cron custom logs need
  `log_cli` on, or set the row's fields and expect no write on CLI).
- Skips during site install.
- Defaults `created`=request time, `uid`=current user, `ip`=client IP, `path`=current route (or `cli`).
- If `ref_char` matches a configured `skip_patterns` glob, the event is dropped.
- Strips tags from `description`, then fires `hook_event_log_track_alter($log)` and
  `hook_event_log_track_log_alternative($log)` (syslog/stdout submodules).
- Inserts (or updates if `$log['lid']` is set) unless `disable_db_logs` is TRUE.

Other manager methods: `getEventHandlers()` (collected `hook_event_log_track_handlers`),
`sessionCount($uid)`, `addSubmitHandler()` / `handleFormSubmit()` (the form-submit dispatch path
used by handlers that declare `form_ids` / `form_ids_regexp` / `form_submit_callback`).

## `event_log_track.api` — `EventLogTrackApi`

- `getOldRecords()` / `deleteOldRecords($records)` — cron pruning (older than `timespan_limit`,
  chunked by `batch_size`).
- `getHandlerOptions()` / `getHandlerOptionsOperations()` — static callbacks that feed the report's
  Type / Operation exposed filters from the registered handlers.

## Views

The module registers `event_log_track` as a Views base table (join to `users_field_data`), and
submodules add relationships (e.g. `elt_node_join` to nodes, `elt_media_join` to media).
