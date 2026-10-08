# Views integration

`tether_stats.views.inc` implements `hook_views_data()` and `hook_views_data_alter()`, exposing the
raw stat tables to Views (group **"Tether Stats"**). Use this to build custom reports beyond the
built-in overview pages.

## Base tables and fields

- **`tether_stats_element`** (base, key `elid`, title "Stats Elements"): fields `elid` (numeric),
  `name`, `entity_id`, `entity_type`, `url`, `query`, `derivative`, `count` (numeric), `created`,
  `changed`, `last_activity` (dates).
- **`tether_stats_activity_log`** (base, key `alid`, title "Stats Activities"): fields `alid`
  (numeric), `elid` (numeric + relationship to `tether_stats_element`), `type`, `uid` (relationship
  to `users_field_data`), `referrer`, `ip_address`, `browser`, `created` (date).
- **`tether_stats_impression_log`**: `alid` (relationship to `tether_stats_activity_log`), `elid`
  (relationship to `tether_stats_element`).

## Relationships

- `tether_stats_activity_log.elid` → `tether_stats_element` ("Activity Element").
- `tether_stats_activity_log.uid` → `users_field_data` ("User").
- `tether_stats_impression_log.alid` → `tether_stats_activity_log` ("Impression Activity");
  `tether_stats_impression_log.elid` → `tether_stats_element` ("Impressed Element").

## Entity relationship added by `hook_views_data_alter`

For every entity type, a relationship `tether_stats_elid` is added on the entity's base/data table:
it joins the entity to its matching **base** stats element
(`entity_type = '<type>' AND name IS NULL AND derivative IS NULL`, joined on `entity_id`). This lets
a node/user/etc. View pull in its stats-element row (label "Stats Elements", group "Tether Stats").

> The `referrer` and `browser` (User-Agent) columns hold visitor-supplied strings; standard Views
> field handlers escape output, so render them with the default (escaping) formatter.
