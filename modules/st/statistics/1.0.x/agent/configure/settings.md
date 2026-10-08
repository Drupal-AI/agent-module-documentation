<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Statistics

Single settings form; no config entities. Route `statistics.settings` at
`/admin/config/system/statistics` (form `\Drupal\statistics\StatisticsSettingsForm`), gated by
the module permission `administer statistics`. All values live in the `statistics.settings`
config object, so they export/deploy with `drush config:export` and can be set with
`drush cset`.

## Settings (`statistics.settings`)

| Key | Default | Meaning |
|---|---|---|
| `count_content_views` | `0` | Master switch. `1` = record a view every time a node's full page is shown; `0` = counting disabled (the "Popular content" block and the counter link are also hidden). |
| `display_max_age` | `3600` | How long (seconds) the displayed counter / "N views" link may be cached before it refreshes. |

The settings **form only exposes the "Count content views" checkbox** (which writes
`count_content_views`). `display_max_age` has no form field — set it via config/Drush.

Enable / disable counting from the CLI:

```bash
drush cset statistics.settings count_content_views 1 -y   # turn on
drush cset statistics.settings count_content_views 0 -y   # turn off
drush cget statistics.settings count_content_views        # read current value
```

**How counting works:** with counting on, `statistics_node_view()` attaches the
`statistics/drupal.statistics` JS library to full node pages; the browser POSTs the node id to
the module's `statistics.php`, which calls `recordView()` on the storage service to increment
`node_counter`. So a view is only counted for a real full-page node view by a browser that runs
the JS — not for teaser/listing renders, previews, or new nodes. When `count_content_views` is
`0`, `statistics_block_alter()` removes the "Popular content" block definition entirely.

## "Popular content" block (`statistics_popular_block`)

Plugin id `statistics_popular_block` (admin label "Popular content"). Place it via
`/admin/structure/block` or a `block` config entity. Its settings (schema
`block.settings.statistics_popular_block`) are three integers — how many nodes to list in each
section:

| Block setting | Lists |
|---|---|
| `top_day_num` | Today's most-viewed nodes (by `daycount`). |
| `top_all_num` | All-time most-viewed nodes (by `totalcount`). |
| `top_last_num` | Most recently viewed nodes (by `timestamp`). |

The block only appears / renders when `count_content_views` is enabled.

## Daily reset & search ranking

`statistics_cron()` recomputes `state('statistics.node_counter_scale')` from the max total count
(used as a search-ranking boost factor via `hook_ranking()`), and the storage backend's
`resetDayCount()` zeroes every `daycount` once every 24h so "today's views" is a rolling daily
figure.
