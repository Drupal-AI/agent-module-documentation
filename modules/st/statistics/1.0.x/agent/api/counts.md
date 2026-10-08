<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Statistics API — reading & recording view counts

All access to the counts goes through one service, `statistics.storage.node`, which implements
`Drupal\statistics\StatisticsStorageInterface`. The interface is also registered as an alias, so
you can autowire `StatisticsStorageInterface` or fetch `statistics.storage.node` from the
container. The default backend `NodeStatisticsDatabaseStorage` reads/writes the `node_counter`
table (`nid`, `totalcount`, `daycount`, `timestamp`); the service is `backend_overridable`, so a
custom backend can replace it.

```php
$storage = \Drupal::service('statistics.storage.node');   // StatisticsStorageInterface
```

## Interface methods

| Method | Returns | Purpose |
|---|---|---|
| `recordView($id)` | `bool` | Increment `totalcount` and `daycount` for node `$id` (upserts the row) and stamp `timestamp` with the current request time. This is what the front-end `statistics.php` endpoint calls. |
| `fetchView($id)` | `StatisticsViewsResult` \| `FALSE` | Counts for one node, or `FALSE` if the node has no row yet. |
| `fetchViews($ids)` | `StatisticsViewsResult[]` | Counts for many nodes, keyed by node id (missing ids are absent). |
| `fetchAll($order = 'totalcount', $limit = 5)` | `int[]` | Top-N node ids ordered by `'totalcount'`, `'daycount'`, or `'timestamp'` (DESC). Any other `$order` fails an assertion. |
| `deleteViews($id)` | `bool` | Delete the `node_counter` row for node `$id`. |
| `resetDayCount()` | `void` | Zero every `daycount` if ≥ 24h since the last reset (called from cron). |
| `maxTotalCount()` | `int` | Highest `totalcount` across all nodes. |

## Result value object — `Drupal\statistics\StatisticsViewsResult`

Returned by `fetchView()` / `fetchViews()`. Read-only getters:

| Getter | Value |
|---|---|
| `getTotalCount()` | Total number of views (`totalcount`). |
| `getDayCount()` | Views recorded today (`daycount`). |
| `getTimestamp()` | Unix timestamp of the last view (`timestamp`). |

## Examples

Read one node's total views:

```php
$result = \Drupal::service('statistics.storage.node')->fetchView($nid);
$total  = $result ? $result->getTotalCount() : 0;
$today  = $result ? $result->getDayCount() : 0;
```

Record a view from custom code (e.g. a decoupled front end):

```php
\Drupal::service('statistics.storage.node')->recordView($nid);
```

Top 10 most-viewed node ids of all time:

```php
$ids = \Drupal::service('statistics.storage.node')->fetchAll('totalcount', 10);
```

## Tokens

With the module enabled you can also read per-node counts through tokens:
`[node:total-count]`, `[node:day-count]`, and `[node:last-view]` (a formatted date of the last
view). Useful in Views rewrites, messages, or templates without touching the service directly.
