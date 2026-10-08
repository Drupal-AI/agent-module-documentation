<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Recording and Views reporting

The module has **no admin settings** (`configure: null`). Recording is automatic; reporting
is built with Views on the module's base table.

## What gets recorded, and when

`search_api_stats_search_api_results_alter(ResultSetInterface &$results)` in
`search_api_stats.module` fires after **every** Search API query. It inserts one row into the
`search_api_stats` table **only when the query has non-empty original keywords**
(`$query->getOriginalKeys()`), so facet/browse queries with no text are ignored. Keywords are
lower-cased and trimmed before storage.

## The `search_api_stats` table (Views base table)

Created by `hook_schema()` in `search_api_stats.install`. Columns:

| Column | Meaning |
|---|---|
| `qid` | serial primary key |
| `s_name` | Search API **server** machine name |
| `i_name` | Search API **index** machine name |
| `timestamp` | Unix request time of the query |
| `numfound` | number of results returned |
| `total_time`, `prepare_time`, `process_time` | timing (ms); reserved, written as 0 |
| `uid` | user id who ran the query |
| `sid` | session id |
| `showed_suggestions`, `page` | reserved |
| `keywords` | the lower-cased search phrase (varchar 128) |
| `filters`, `sort` | reserved, written empty |
| `language` | langcode when the search ran |

`search_api_stats.views.inc` (`hook_views_data()`) registers `search_api_stats` as a base
table (group *Search API stats*) with a **relationship to `users_field_data`** on `uid`. The
`language` field/filter is only exposed when the core `locale` module is enabled.

## Building a stats View (there is no working default view on D11)

The project ships `includes/views/search_api_stats.views_default.inc`, but it uses the
**Drupal 7** `hook_views_default_views()` / `new view()` API and does **not** load on Drupal
8-11. So on D11 there is no ready-made View - create your own:

- Base table: **Search API stats** (`search_api_stats`).
- For "top search terms": add the *Keywords* field, use an aggregation/group-by on keywords
  with a Count, sort by the count descending.
- For a raw log: add *Keywords*, *Timestamp* (date), and via the User relationship the user
  *Name*; expose *Keywords* and *Timestamp* filters.
- Gate the display with the **access search api stats** permission (see
  [../permissions/permissions.md](../permissions/permissions.md)).

### Create a View in config (scriptable)

A minimal stats View is just a `views.view.*` config entity whose `base_table` is
`search_api_stats`. Create it through the Views UI (`/admin/structure/views/add`, choosing the
*Search API stats* base table) or by importing a `views.view.<id>` config with
`base_table: search_api_stats`.

## Clearing the log

There is no built-in purge. To apply a retention policy, delete rows directly, e.g.
`drush sql:query "DELETE FROM search_api_stats WHERE timestamp < <cutoff>"`, or truncate the
whole table.
