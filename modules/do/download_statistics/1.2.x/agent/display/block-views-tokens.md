<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Displaying counts: block, Views, tokens

All three displays require config `count_file_downloads` = TRUE and the viewer to hold the
**`view file download statistics`** permission.

## Popular file downloads block

Plugin `download_statistics_popular_block` ("Popular file downloads",
`Plugin/Block/DownloadStatisticsPopularBlock`, extends `BlockBase`).

- **Access** (`blockAccess()`): allowed only if `count_file_downloads` is on **and** the account has
  `view file download statistics`; otherwise forbidden. `Hook::blockAlter()` removes the plugin
  entirely when counting is off; `Hook::preprocess_block` adds `role="navigation"`.
- **Settings** (`blockForm()`, stored in block config `top_day_num`, `top_all_num`,
  `last_download`; default 0 = disabled; options 1–40): how many files to list for today's top,
  all-time top, and most-recently-downloaded.
- **build()**: for each enabled section calls `statisticsStorage->fetchAll('daycount'|'totalcount'|
  'timestamp', N)` and renders an `item_list__node` of file links (`filenameList()`), with file
  list cache tags. File names are placed in a `#type => link` `#title` (escaped by the render
  system).

## Views integration

Data in `download_statistics.views.inc` (`hook_views_data`, returns `[]` when counting off). Base
table `download_statistics`, group *"File Download Statistics"*, joined to `file_managed` on `fid`.

Exposed columns:

| Field | Title | Field handler | Filter / arg / sort |
|---|---|---|---|
| `fid` | File | `download_statistics_numeric` | numeric / numeric / standard; relationship → `file_managed` |
| `uid` | User | `download_statistics_numeric` | numeric / numeric / standard; relationship → `users_field_data` |
| `totalcount` | Total file downloads | `download_statistics_numeric` | numeric / numeric / standard |
| `daycount` | File downloads today | `download_statistics_numeric` | numeric / numeric / standard |
| `timestamp` | Most recent file download | `download_statistics_timestamp` | date / date / standard |

Field handlers (both override `access()` to require `view file download statistics`):

- `Plugin/views/field/DownloadStatisticsNumeric` (extends `NumericField`), id
  `download_statistics_numeric`.
- `Plugin/views/field/DownloadCounterTimestamp` (extends `Date`), id
  `download_statistics_timestamp`.

To show a counted download link inside a View, also select the **File URI with Download Count**
(`file_uri_download_count`) URI formatter (see `api/counting.md`). A test view lives at
`tests/modules/download_statistics_test_views/`.

## File tokens (`download_statistics.tokens.inc`)

`hook_token_info` returns `[]` when counting is off. On the **`file`** token type it adds:

| Token | Value (via `download_statistics_get()`) |
|---|---|
| `[file:total-count]` | total downloads |
| `[file:day-count]` | downloads today |
| `[file:last-view]` | last-download date (formatted; also supports `last-view:*` date-format chaining) |
| `[file:last-user]` | UID of the last downloader |

`hook_tokens` resolves each by loading the file's stats row for the file in `$data['file']`.
