# API — Admin Audit Trail

## Write a log row: `admin_audit_trail_insert(array &$log)`
The one public logging function (procedural, in `admin_audit_trail.module`). Inserts a row into
the `admin_audit_trail` table (or updates it if `$log['lid']` is set).

`$log` fields:
| Key | Required | Notes |
|---|---|---|
| `type` | ✓ | event type (e.g. `node`, `user`, matches a registered handler) |
| `operation` | ✓ | e.g. `insert`, `update`, `delete` |
| `description` | ✓ | HTML text shown in the report |
| `ref_numeric` | — | numeric id of the referenced object |
| `ref_char` | — | string label of the referenced object |
| `uid`, `ip`, `path`, `created` | — | auto-filled from the current request if omitted |
| `lid` | — | set to update an existing row instead of inserting |

It auto-fills `created` (request time), `uid` (current user), `ip` (client IP), and `path`
(current route), invokes `hook_admin_audit_trail_log_alter()`, safe-truncates `path` to 255
chars, and invalidates the report View's cache tag.

> **CLI caveat (important for Drush/eval):** the first line is
> `if (PHP_SAPI == 'cli') { return; }` — so `admin_audit_trail_insert()` is a **no-op under
> Drush / `drush php:eval`**. It only writes during real web requests. To create a row from
> the CLI (tests, seeding), insert into the table directly (see below).

## Alter every row: `hook_admin_audit_trail_log_alter(array &$log)`
Invoked inside `admin_audit_trail_insert()` before the DB write. Mutate `$log` to add context,
rewrite the description, or set `$log['type'] = ''`-style vetoes. Defined in
`admin_audit_trail.api.php`.

## Query the log
There is no entity API — it is a plain table. Query with the database service, or use the
built-in `\Drupal\admin_audit_trail\AdminAuditTrailStorage::getSearchData($filters, $header, $limit)`
(static; returns a paged, table-sortable result) which the report uses. `$filters` keys:
`type`, `operation`, `id` (→ `ref_numeric`), `ip`, `name` (→ `ref_char`), `path`, `keyword`
(LIKE on description), `user` (→ `uid`).

```php
// Count node deletes:
$n = \Drupal::database()->select('admin_audit_trail', 'a')
  ->condition('type', 'node')->condition('operation', 'delete')
  ->countQuery()->execute()->fetchField();

// Most recent 10 rows:
$rows = \Drupal::database()->select('admin_audit_trail', 'a')
  ->fields('a')->orderBy('created', 'DESC')->range(0, 10)
  ->execute()->fetchAll();
```

## Table schema (`admin_audit_trail`, from `hook_schema` in `.install`)
`lid` (serial PK), `type` varchar(50), `operation` varchar(50), `path` varchar(255),
`ref_numeric` int (nullable), `ref_char` varchar(255) (nullable), `description` mediumtext,
`uid` int, `ip` varchar(255) (nullable), `created` int (unix timestamp).
Indexes: `created`, `(uid, ip)`, `ip`, and `(type, operation, ref_numeric, ref_char)`.

```php
// CLI-safe row insert (what admin_audit_trail_insert does internally, minus the CLI guard):
\Drupal::database()->insert('admin_audit_trail')->fields([
  'type' => 'my_thing', 'operation' => 'insert',
  'description' => 'Created X', 'created' => \Drupal::time()->getRequestTime(),
  'uid' => 1, 'ip' => '127.0.0.1', 'path' => 'cli', 'ref_char' => 'X', 'ref_numeric' => 42,
])->execute();
```

## Helper functions
- `admin_audit_trail_get_event_handlers()` — all registered handlers (invokes the hook + alter).
- `admin_audit_trail_get_event_types()` — `type => label` map, sorted, for filters.
- `admin_audit_trail_safe_truncate($value, $max = 255)` — multibyte-safe truncation used on `path`.
