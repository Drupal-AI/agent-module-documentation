# Transports: Drupal SQL, DSN options, table/schema, failures, retries

Transports are how messages are stored/carried. SM ships two kinds out of the box: **`sync://`**
(handled immediately, in-request) and the native **Drupal SQL** transport (`drupal-sql://`, an
async queue stored in the database). Other contrib/custom modules can add transports by registering a
Symfony `TransportFactoryInterface` (auto-tagged `messenger.transport_factory` by `SmServiceProvider`).

## Drupal SQL transport (`drupal-sql://`)

Factory `Drupal\sm\Transport\DrupalSql\TransportFactory` (service, private) →
`Transport` → `Connection` (all `@internal`). DSN + options are parsed by
`Connection::buildConfiguration()`.

- DSN form: `drupal-sql://default[?queue_name=...&table_name=...&...]`.
- Only the **`default`** database connection is supported (`buildConfiguration` throws
  `InvalidArgumentException` otherwise); the host part is the `$databases` connection key.
- Options may be given as DSN query parts **or** under the transport's `options:` key. Unknown keys
  in either place throw `InvalidArgumentException`.

Options and defaults (`Connection::DEFAULT_OPTIONS`):

| Key | Default | Meaning |
|---|---|---|
| `table_name` | `sm_messages` | Table storing this transport's messages. |
| `queue_name` | `default` | Logical queue (a column); one table can hold several queues. |
| `redeliver_timeout` | `3600` | Seconds a "delivered" (in-flight) message waits before being eligible for redelivery. |
| `auto_setup` | `true` | Auto-create the table on first insert/failure. Set `false` and pre-create for a small perf win. |

Example (README):

```yaml
parameters:
  sm.transports:
    highpriority:
      dsn: 'drupal-sql://default?queue_name=sm_messages_high'
    lowpriority:
      dsn: 'drupal-sql://default?queue_name=sm_messages_low'
    my_transport:
      dsn: 'drupal-sql://default?queue_name=myqueue'
      options:
        table_name: 'sm_messages__myqueue'
```

### Table schema (`Transport/DrupalSql/Schema.php`)
Columns: `id` (big serial, PK), `body` (big text), `headers` (big text, JSON), `queue_name`
(varchar 190), `created_at` / `available_at` / `delivered_at` (varchar 20, `Y-m-d H:i:s`). Indexes on
`delivered_at`, `available_at`, `queue_name`. Table description carries a `[DrupalSM]` marker to
signify ownership.

### Send / receive semantics (`Connection.php`)
- **Send**: inserts a row with serialized `body` + JSON `headers`; a `DelayStamp` shifts
  `available_at` into the future. Auto-creates the table on failure when `auto_setup` is on.
- **Receive** (`get`): selects the oldest row with `available_at <= now` whose `delivered_at` is NULL
  or older than `redeliver_timeout`, then stamps `delivered_at = now` (claim). Ordered by
  `available_at`.
- **Ack/Reject**: on MySQL, sets `delivered_at = 9999-12-31 23:59:59` (soft-delete, cleaned up lazily
  on the next `get`) to avoid multi-worker deadlocks; on other databases, deletes the row. Errors are
  wrapped in `TransportException`.
- Serialization uses `messenger.transport.native_php_serializer` (Symfony `PhpSerializer` = PHP
  `serialize`/`unserialize`) unless a transport sets its own `serializer`. Bodies are written and read
  only by application code / the consume worker.
- The transport implements `ListableReceiverInterface` + `MessageCountAwareInterface`, so
  `messenger:stats` and `messenger:failed:show` can count and list rows.

### Table lifecycle / tracking
Auto-created tables are recorded in State key **`sm_tables`** via
`Drupal\sm\Transport\DrupalSql\MessageTableTracker`. On module uninstall, `sm_uninstall()` calls
`MessageTableTracker::dropAll()`, dropping every tracked table and clearing the state entry (so
uninstalling discards queued messages).

## Failures & retries

- After a transport's `retry_strategy.max_retries` (default **3**, exponential backoff via
  `multiplier`/`delay`/`jitter`), a message is moved to the **failure transport**.
- Global default failure transport: `sm.failure_transport` (install default `failed`, itself a
  `drupal-sql://default?queue_name=failed`). Override per transport with a `failure_transport` key.
- `SmCompilerPass` aliases `messenger.failure_transports.default` and wires the failed-message
  commands only when a failure transport exists; otherwise those commands are removed from the
  container.
- Inspect / retry / remove failed messages with the `messenger:failed:*` commands
  ([console.md](console.md)).

## Rate limiting (developer)
Set `rate_limiter: <name>` on a transport and define a `RateLimiterFactory` service named
`limiter.<name>` (with its storage) in `services:`. Requires `symfony/rate-limiter`; the consume
worker throttles receiving accordingly. See README "Rate Limiting" for a full example.
