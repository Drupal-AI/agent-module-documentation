# Views integration

`counter.views.inc` (`hook_views_data`) exposes the `counter` table as a Views **base table**
(group "Counter"), so you can build a view listing raw hit rows. Create a view of type
**Counter**.

Base table `counter`, base field `counter_id`. Exposed fields (each with field / filter /
sort / argument handlers unless noted):

| field | handler id | notes |
|-------|-----------|-------|
| `counter_id` | numeric | base field |
| `ip` | standard / string | IP address |
| `url` | standard / string | recorded URL |
| `created` | date | timestamp (date filter/sort) |
| `uid` | numeric + **relationship** | joins to `users_field_data` (label "Counter User"); LEFT join wired both ways |
| `nid` | numeric | node id |
| `type` | standard / string | node bundle |
| `browser_name` | standard / string | |
| `browser_version` | standard / string | |
| `platform` | standard / string | |

Typical uses: a table of recent hits, a per-node or per-URL view-count aggregation (add a
Count aggregation on `counter_id` grouped by `nid`/`url`), or a per-user activity list via the
`uid` relationship. Restrict such views with a permission-based access filter — the rows
contain visitor IPs.
