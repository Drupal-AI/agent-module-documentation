<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Stats — agent index

Records every Search API keyword search into a custom **`search_api_stats`** DB table and
exposes it to **Views**. No settings form, no `configure` route, no Drush, no plugin types.
Depends on `search_api`.

- **How recording works, the `search_api_stats` table columns, and building report Views**
  (incl. the D7 legacy default view that does NOT work on D11) →
  [configure/recording-views.md](configure/recording-views.md)
- **The `hook_search_api_stats_record_alter()` hook to rewrite/enrich a row before insert** →
  [api/record-alter.md](api/record-alter.md)
- **The `access search api stats` permission and what it gates** →
  [permissions/permissions.md](permissions/permissions.md)
- **Submodule — per-index "top search phrases" block** →
  [../../modules/search_api_stats_block/1.0.x/agent/start.md](../../modules/search_api_stats_block/1.0.x/agent/start.md)

Key facts: rows are inserted by `hook_search_api_results_alter()` in `search_api_stats.module`
only when the query has non-empty keywords. The table is a Views **base table**
(`hook_views_data()` in `search_api_stats.views.inc`) with a relationship to
`users_field_data`. There is **no shipped, working Drupal 11 View** — build your own on the
`search_api_stats` base table.
