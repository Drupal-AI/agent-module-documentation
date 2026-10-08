# statistics_counter (2.0.x)

Extends the Statistics module. Adds `weekcount`, `monthcount`, `yearcount`
columns to the `node_counter` table and exposes them to Views. No UI, no
config, no permissions, no Drush.

Depends on: `statistics` (drupal/statistics ^1.0). core: ^10.3 || ^11.

## How it works (3 mechanisms)
- Counting: a kernel TERMINATE event subscriber increments all three counters
  by 1 on each node page view, gated by `statistics.settings:count_content_views`.
- Reset: `hook_cron` zeroes each rolling counter when its calendar period
  (ISO week / month / year) rolls over.
- Views: `hook_views_data_alter` registers the three columns as field / filter /
  argument / sort under the `node_counter` table (group "Content statistics").

## Docs
- [agent/api/counters-and-views.md](api/counters-and-views.md) — the counter
  columns, the event subscriber, cron reset behavior, and the exact Views
  field/filter/argument/sort ids you can use.

## No-ops
No permissions, no Drush commands, no config schema, no admin route, no plugin
types, no libraries, no submodules. Install/uninstall add/drop the 3 columns.
