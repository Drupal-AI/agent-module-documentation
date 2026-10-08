# Views integration

`google_analytics_counter.views.inc` implements `hook_views_data`, exposing the node-total storage table
directly to Views. (For most cases, adding the `field_google_analytics_counter` field to nodes and using
its normal Views field is simpler — see [../configure/custom-field.md](../configure/custom-field.md).)

## Base table `google_analytics_counter_storage`

- Group: "Google Analytics Counter". Base field: `nid`.
- Can be used as a Views **base table** (one row per node that has pageview totals).

| Field | Handlers | Notes |
|---|---|---|
| `nid` | relationship → `node_field_data` (base field `nid`, id `standard`, label "nodes") | Join to node data to pull title, etc. |
| `pageview_total` | field `numeric`, sort `standard`, filter `numeric`, argument `numeric` | The stored total pageviews for the node. |

## Typical use

Build a "most viewed" view on the `google_analytics_counter_storage` base table, add the `nodes`
relationship, then add node fields and sort by `pageview_total` descending. The `google_analytics_counter`
path table is not exposed to Views (it is an internal path→pageviews staging table).
