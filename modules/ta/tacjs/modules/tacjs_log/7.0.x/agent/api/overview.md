# TacJS Log — routes, table, controller

## Routes (`tacjs_log.routing.yml`)

| Route | Path | Controller | Permission |
|---|---|---|---|
| `tacjs_log.report` | `/reports/tacjslog/{service}` | `LogController::report` | `access content` |
| `tacjs_log.overview` | `/admin/config/system/tacjs/overview` | `LogController::overview` | `administer tacjs` |

`tacjs_log.overview` is also declared as a local task tab (`tacjs_log.links.task.yml`, base route
`tacjs.edit_texts`) so it appears alongside the other TacJS admin tabs.

## The `tacjslog` table (`tacjs_log.install` → `hook_schema`)

| Column | Type | Notes |
|---|---|---|
| `uid` | serial | primary key (unique row id — not a Drupal user id) |
| `timestamp` | int | consent time (`datetime.time` current time) |
| `ip_address` | varchar(255) | `Request::getClientIp()` |
| `services_allowed` | text | the service string the visitor allowed |

## Controller behaviour (`LogController`)

- `report($service)` — inserts one row `{timestamp, ip_address, services_allowed: $service}` into
  `tacjslog` and returns that data as a `JsonResponse`. Called by the attached
  `tacjs_log/tacjs_log` JS (`js/tarteaucitron-log.js`) when a visitor allows a service.
- `overview()` — selects from `tacjslog` with pager + tablesort extenders, 50 rows/page, header
  Timestamp / IP address / Services allowed; empty text "No log available."

## Inspecting / writing the log directly

```bash
# Read stored consents
drush sqlq "SELECT uid, timestamp, ip_address, services_allowed FROM tacjslog ORDER BY timestamp DESC LIMIT 20"
```

```php
// Insert a consent record programmatically (what the report endpoint does):
\Drupal::database()->insert('tacjslog')->fields([
  'timestamp' => \Drupal::time()->getCurrentTime(),
  'ip_address' => \Drupal::request()->getClientIp(),
  'services_allowed' => 'youtube',
])->execute();
```
