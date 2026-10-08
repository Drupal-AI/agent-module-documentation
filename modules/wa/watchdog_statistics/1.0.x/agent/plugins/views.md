# Watchdog statistics — Views fields, sorts & the GROUP BY mechanism

The module does **not** define a new plugin type. It defines a few Views handler plugins
(instances of core Views field/sort base classes) and registers them on the `watchdog` table.

## Views data added (`watchdog_statistics_views_data_alter()`)
On the `watchdog` table:

| Views id | Kind | Title | Backed by |
|---|---|---|---|
| `messages_count` | field + sort → `watchdog_message_count` | "Message count" | `COUNT(wid)` + grouping |
| `latest_watchdog_id` | field → `latest_watchdog_id` | "Latest WID" | `MAX(wid)` |
| `latest_watchdog_timestamp` | field + sort → `latest_watchdog_timestamp` | "Latest timestamp" | `MAX(timestamp)` |

## Field/sort plugin classes (`src/Plugin/views/…`)
- **`WatchdogMessageCount`** (`@ViewsField("watchdog_message_count")`): in `query()` adds
  `COUNT(wid)` as the field alias and calls `$this->query->addTag('watchdog_message_count')`.
- **`LatestWatchdogId`** (`@ViewsField("latest_watchdog_id")`): adds `MAX(wid)`.
- **`LatestWatchdogTimestamp`** (`@ViewsField("latest_watchdog_timestamp")`, extends core
  `Date`): adds `MAX(timestamp)`, rendered as a date.
- **`WatchdogMessageCount`** sort (`@ViewsSort("watchdog_message_count")`, extends `Standard`):
  `addOrderBy(NULL, '(COUNT(watchdog.wid))', $order, 'watchdog_message_count')`.
- **`LatestWatchdogTimestamp`** sort (`@ViewsSort("latest_watchdog_timestamp")`, extends core
  `Date` sort): `addOrderBy(NULL, '(MAX(watchdog.timestamp))', $order, 'latest_watchdog_timestamp')`.

## The grouping rewrite (the actual "statistics")
`watchdog_statistics_query_watchdog_message_count_alter()` implements
`hook_query_TAG_alter()` for the `watchdog_message_count` tag added by the count field. It:

1. Clears the existing GROUP BY.
2. Groups by `message`, `variables`, `type`, `severity`.
3. Adds the expression `COUNT(wid)` as `watchdog_message_count`.

So any View that includes the `messages_count` field collapses identical log messages into one
row with a count. Because `latest_watchdog_id` / `latest_watchdog_timestamp` use `MAX()`, each
grouped row can still link to and be dated by its most recent occurrence.

## Config schema
`config/schema/watchdog_statistics.schema.yml` defines schema for the
`latest_watchdog_timestamp` field (custom_date_format, date_format, timezone) and sort
(granularity) handlers so they store cleanly in View config.

## To build your own aggregated log View
Add the `Message count` field (`messages_count`) — that alone triggers the grouping — plus
`Latest WID` and `Latest timestamp`, then sort by `Message count` DESC.
