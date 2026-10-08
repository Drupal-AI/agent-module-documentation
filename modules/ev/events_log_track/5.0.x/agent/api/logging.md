# Logging API, the log table, tokens, and retention

## Service: `event_log_track.manager` → `EventLogTrackManager`

`public function insert(array &$log): void` — the single entry point for writing an event.
Autowired; inject `Drupal\event_log_track\EventLogTrackManager` or use
`\Drupal::service('event_log_track.manager')`.

The `$log` array (only `type`, `operation`, `description` are required; the rest are filled in):

| Key | Required | Filled by insert() if empty |
| --- | --- | --- |
| `type` | yes | — (matches a `hook_event_log_track_handlers` key) |
| `operation` | yes | — |
| `description` | yes | `strip_tags()` applied |
| `ref_numeric` | no | `NULL` |
| `ref_char` | no | `NULL`; else `Xss::filterAdmin()` applied |
| `created` | no | `time.getRequestTime()` |
| `uid` | no | `currentUser->id()` |
| `ip` | no | `request->getClientIp()` |
| `path` | no | current internal path, or `'cli'` under CLI |
| `lid` | no | when set, `insert()` **updates** that row instead of inserting |

Behavior inside `insert()` (in order): skips entirely during site install; skips when
`PHP_SAPI === 'cli'` unless `log_cli` is TRUE; fills the defaults above; if `ref_char` matches
a configured skip pattern the event is dropped (`shouldSkip()`); fires
`hook_event_log_track_alter`; fires `hook_event_log_track_log_alternative` (syslog/stdout);
finally, unless `disable_db_logs` is set, writes a parameterized INSERT/UPDATE into
`event_log_track` (DB errors are swallowed).

Other manager methods: `getEventHandlers()`, `sessionCount(int $uid)` (rows in `sessions`
for a uid; used by the auth/tfa submodules), `addSubmitHandler()`, static
`formSubmitCallback()` / `handleFormSubmit()` (form dispatch — see hooks/event-handlers.md).

## Service: `event_log_track.api` → `EventLogTrackApi`

Retention + Views helpers:
- `getOldRecords(): array` — `lid`s older than `timespan_limit` days.
- `deleteOldRecords(array $records): void` — batch-deletes in `batch_size` chunks (static
  `processOldRecords()` callback). Driven from `hook_cron` when `enable_log_deletion` is on.
- static `getHandlerOptions()` / `getHandlerOptionsOperations()` — Views exposed-filter option
  callbacks for the `type` / `operation` columns.

## Table: `event_log_track` (hook_schema)

| Field | Type | Notes |
| --- | --- | --- |
| `lid` | serial | primary key |
| `type` | varchar(50) | handler/event type |
| `operation` | varchar(50) | operation label |
| `path` | varchar(2048) | request path or `cli` |
| `ref_numeric` | int, null | numeric reference (entity id, …) |
| `ref_char` | varchar(255), null | text reference (label, machine name, …) |
| `description` | text (medium) | human description (tags stripped) |
| `uid` | int | actor (0 = anonymous) |
| `ip` | varchar(45), null | client IP |
| `created` | int | request timestamp |

Indexes: `created`, `type_operation`, `uid`, `ip`, `ref (type, ref_numeric)`. The table is
dropped on uninstall. `hook_update_10001` migrated old `syslog`/`stdout` sub-keys out of
`event_log_track.settings` into the two backend submodules' own config.

## Tokens: `event-log` type

`EventLogTrackTokenHooks` defines the `event-log` token type with:
`type`, `operation`, `description`, `created` (date), `entity`, `user` (user, chainable),
`session_duration` (request time − last login; 0 for anon), `ip`, `path`, `severity`,
`ref_char`, `ref_numeric`. Used to build the format strings in the syslog/stdout submodules
and available anywhere an `event-log` data object is supplied to `token->replace()`.
