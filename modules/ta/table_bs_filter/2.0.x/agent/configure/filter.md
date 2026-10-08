<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Bootstrap table filter

No global settings page — the filter is configured per text format.

## Enable it

1. Go to **Configuration › Content authoring › Text formats and editors**
   (`/admin/config/content/formats`) and edit a format (e.g. *Full HTML*).
2. Under **Enabled filters**, tick **"Add Bootstrap Class to any tables"**.
3. In **Filter settings** (the *table_bs_filter* section), tick the options you want.
4. **Filter processing order** matters — place it so it runs on the final table markup (after the
   "Limit allowed HTML tags" filter, which must permit `<table>`, `<div>`, and the `class` attribute).
5. Save the format.

## Settings (`filter_settings.table_bs_filter`)

| Setting | Effect |
|---|---|
| `table_bordered` | Adds `table-bordered` when on, else `table-borderless`. |
| `table_condensed` | Adds `table-condensed` (compact cells). |
| `table_row_hover` | Adds `table-hover` (row hover highlight). |
| `table_striping` | Adds `table-striped` (zebra striping). |
| `remove_width_height` | Strips inline `width`/`height` from the table and (`<tr|td|th>`) cells. |

All are booleans (checkboxes), default `FALSE`.

## What `process()` does

For each opening `<table>` tag (regex `TABLE_BS_FILTER_REGEX`):
- keeps existing `id`, `class`, `style`, `dir` attributes;
- prepends the base `table` class plus the enabled Bootstrap modifier classes;
- wraps the table in `<div class="table-responsive">` (closing `</table></div>` at the end).

When `remove_width_height` is on, a second pass strips `width`/`height` (inline style and attributes)
from `<tr|td|th>` cells, and `width...;` is stripped from the table's own `style`.

## Notes

- Filter type is `TYPE_TRANSFORM_REVERSIBLE`, so it transforms output without altering stored content.
- Styling assumes a Bootstrap-based theme provides the `table-*` classes.
- Trust boundary: enabling/configuring a text-format filter is an `administer filters` (trusted admin)
  operation, and the filter only re-emits table markup the format already allows — it does not
  introduce a new sink for untrusted input.
