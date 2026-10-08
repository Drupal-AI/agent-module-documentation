<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Blocks

Two block plugins under `src/Plugin/Block/`. Place them like any block (Block layout, or a
`block` config entity). Each has a per-instance "Number of items to display" setting.

| Plugin id | Class | Admin label | Data source | Order | Access permission |
|---|---|---|---|---|---|
| `top_download` | `TopDownload` | Top Downloaded Files | `download_count_cache` joined to `file_managed` | `count` DESC | `access top download` |
| `recent_download` | `RecentDownload` | Recently Downloaded Files | `download_count` joined to `file_managed`, grouped by fid | `MAX(timestamp)` DESC | `access recent download` |

- **TopDownload** reads the cron-maintained `download_count_cache`, so it reflects data as of the
  last cron/queue run. Per-instance limit key: `download_count_top_block_limit` (default 10).
  Columns: file name, size, count.
- **RecentDownload** reads the raw `download_count` table (live), showing each file's most recent
  download time. Per-instance limit key: `download_count_recent_block_limit` (default 10).
  Columns: file name, size, "N ago". Injects the `date.formatter` service.
- Both render a `#theme => 'table'` and escape the filename with `Html::escape()`; both return an
  empty array (no output) when there are no rows.
- The two `access …` permission strings are **not** declared by this module (see
  [permissions/permissions.md](../permissions/permissions.md)), so grant them via another module
  or the blocks stay hidden.
