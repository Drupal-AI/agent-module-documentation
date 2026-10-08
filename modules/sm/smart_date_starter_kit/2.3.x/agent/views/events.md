# The Events view (`views.view.events`)

Imported once from `config/install/views.view.events.yml`. Base table `node_field_data`
(`base_field: nid`). Access: `perm` → **`access content`** (standard published-node viewing).
Row style is `entity:node` in the `teaser` view mode on the page/master displays. Edit at
`admin/structure/views/view/events`.

All displays share three filters: `status = 1` (published), `type = event`, and a date filter on
`field_when_end_value` vs. `now` (offset) — this is what splits **upcoming** from **past**.

## Displays

| Display | Type | Path / placement | Sort | Date filter | Pager |
|---|---|---|---|---|---|
| default (Master) | — | title "Upcoming Events" | `field_when_value` **ASC** (min) | `field_when_end_value > now` | mini, 20/page |
| `page_1` | page | `events/upcoming` — **default tab** "Upcoming" (main menu, tab set "Events") | inherits default (ASC) | inherits (`> now`) | inherits (mini 20) |
| `page_2` | page | `events/past` — tab "Past" | `field_when_value` **DESC** (max) | overrides to `field_when_end_value <= now` | inherits |
| `block_1` | block | placeable block "Upcoming Events" | inherits (ASC) | inherits (`> now`) | `some`, 5 items; `use_more` → links to `page_1` |

`page_1` registers as a `default tab` and `page_2` as a sibling `tab`, so visiting
`events/upcoming` shows an **Upcoming / Past** local-task tab bar.

## Fields shown

- Master/pages (teaser row mode): rendered node teaser, so the `smartdate_default` formatter from
  the teaser view display supplies the date. The master display also defines a `title` field
  (linked to entity) that is used when a display switches to a fields row style.
- `block_1` uses a **fields** row style with `field_when` (`smartdate_default`, `format: default`)
  and `title` (linked to entity).

## Header — "Add an Event"

The default display has an `add_content_by_bundle` header handler (label **"Add an Event"**,
`bundle: event`, rendered as a `button`, width 600) from the required `add_content_by_bundle`
module. It renders a node-add link for the `event` bundle; node create access is still enforced by
core when the link is followed.

## Grouping / caching

- Master display sets `group_by: true` (aggregation) with the `field_when` sort using a min/max
  group so multi-value `field_when` events collapse to one row keyed on their earliest/latest date.
- Cache plugin `tag`; `block_1` additionally invalidates on `config:field.storage.node.field_when`.

## Notes for changes

- To show unpublished or role-restricted events, change the `access` option away from
  `access content` and/or the `status` filter.
- The upcoming/past boundary is `field_when_end_value` (the event's **end**), so an in-progress
  event still counts as upcoming until it ends.
