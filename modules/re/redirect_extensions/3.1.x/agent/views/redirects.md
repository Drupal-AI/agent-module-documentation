<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Redirect listing View and CSV export (`url_redirects`)

The module ships one View, `views.view.url_redirects` (`config/install/`), that **replaces**
Redirect's built-in `redirect` listing so the extra tracking columns can be shown, and adds
a CSV export. On enable, `redirect_extensions_install()` loads the core `redirect` View and
sets it to disabled (`setStatus(FALSE)`) so the two do not collide. Update hooks
`redirect_extensions_update_8101` (disable core view) and `8102/8103/8104` (re-import this
View's config) keep older sites in sync.

## The View

- `base_table: redirect`, `base_field: rid`.
- Access on every display: **permission `administer redirects`**.
- Config module deps: `csv_serialization`, `link`, `redirect`, `redirect_extensions`,
  `rest`, `serialization`, `user`, `views_data_export`.

| Display | Plugin | Path | Purpose |
|---|---|---|---|
| `default` (Master) | `default` | — | shared fields/filters/access |
| `page_1` (Page) | `page` | `/admin/config/search/redirect` | the admin redirect list |
| `data_export_1` (Data export) | `data_export` | `/admin/config/search/redirect/redirects.csv` | CSV download |

Fields shown include: `redirect_bulk_form` (the VBO checkbox column that drives the bulk
actions — see [../configure/bulk-operations.md](../configure/bulk-operations.md)), the
redirect source path, the redirect "To" value rendered as a link, `status_code`, the
creating user, and the created / modified timestamps.

## CSV export

`data_export_1` uses the `views_data_export` `data_export` style with the `csv` format
(delimiter `,`, enclosure `"`, `strip_tags: true`, `trim: true`, UTF-8, BOM off). Requesting
`/admin/config/search/redirect/redirects.csv` streams the current redirect list as CSV;
`automatic_download` is off, so it renders inline unless the browser downloads by MIME type.
This is why `views_data_export` (and transitively `rest` + `serialization` +
`csv_serialization`) is a hard dependency.

## Tracking columns exposed to Views

`redirect_extensions.views.inc` (`hook_views_data`) describes the custom
`redirect_extensions` table (implicit join to `redirect` on `rid`) and exposes:

| Views field | Source column | Handlers |
|---|---|---|
| Created User ID | `redirect_extensions.uid_created` | field/argument/filter/sort/relationship → `users_field_data` |
| Creation timestamp | `redirect_extensions.created` | date field/sort/filter |
| Last Modified timestamp | `redirect_extensions.modified` | date field/sort/filter |
| Status code | `redirect.status_code` | numeric field/filter/sort/argument |

Where those columns are populated is covered in [../hooks/tracking.md](../hooks/tracking.md).
