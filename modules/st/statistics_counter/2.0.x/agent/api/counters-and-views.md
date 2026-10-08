# Counters & Views integration

## Schema (added to core Statistics' `node_counter` table)
On install, three columns are added to `node_counter` (int, unsigned, not null,
default 0, medium size); on uninstall they are dropped:

- `weekcount`  — views this ISO week
- `monthcount` — views this month
- `yearcount`  — views this year

On enable, all three are seeded from the existing `daycount` value.
Core Statistics already provides `daycount`, `totalcount` and `timestamp` on the
same table keyed by `nid`.

## Counting (increment)
`Drupal\statistics_counter\EventSubscriber\StatisticsCounterSubscriber`
(service `statistics_counter.subscriber`, tag `event_subscriber`) listens on
`KernelEvents::TERMINATE`. On each request it increments all three counters by 1
via a MERGE on `node_counter` keyed by `nid`, but ONLY when all hold:

- the request has a `node` route attribute that is a `NodeInterface`, AND
- the response is an `HtmlResponse`, AND
- `\Drupal::config('statistics.settings')->get('count_content_views')` is TRUE.

So counting follows core Statistics' "Count content views" setting; if that is
off (default), nothing is counted. Enable it at Admin > Configuration > System >
Statistics, or:
`drush cset statistics.settings count_content_views 1 -y`

## Reset (cron)
`statistics_counter_cron()` compares the current ISO week / month / year against
the stored `state('statistics_counter.timestamp')`:

- new ISO week (or new year) → `weekcount = 0`
- new month (or new year)    → `monthcount = 0`
- new year                   → `yearcount = 0`

Resets are a single table-wide UPDATE (all nodes). Then it stores the current
request time back to state. Rolling windows refresh only as often as cron runs.

## Reading a single node's counter (procedural, not a service)
`_statistics_counter_getter_callback($nid, $counter)` returns the integer for one
of `weekcount|monthcount|yearcount`. There are also legacy
`statistics_counter_{week,month,year}count_getter_callback($node)` wrappers and a
`hook_entity_property_info_alter` that registers the three as node properties
(Entity API-era; inert without the contrib Entity module). Prefer Views or a
direct query on `node_counter` for reads.

## Views (the primary API)
`hook_views_data_alter` adds three handlers to the `node_counter` table (which
core Statistics groups under "Content statistics" in the Views UI). Each column
is registered identically:

| Column      | Title (Views UI)   | field id  | filter id | argument id | sort id    | click-sortable |
|-------------|--------------------|-----------|-----------|-------------|------------|----------------|
| weekcount   | Views this week    | numeric   | numeric   | numeric     | standard   | yes            |
| monthcount  | Views this month   | numeric   | numeric   | numeric     | standard   | yes            |
| yearcount   | Views this year    | numeric   | numeric   | numeric     | standard   | yes            |

Use them like core's own `node_counter.totalcount` / `daycount`:
- Field: display the period view count in a listing.
- Sort: order descending on `weekcount` for "most popular this week".
- Filter: e.g. `weekcount >= N` to threshold on popularity.
- Argument (contextual filter): drive a period-ranked feed.

No config export is involved — these are code-defined Views data, available as
soon as the module is enabled.
