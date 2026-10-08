<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Adding the CSV download button to a view

## Requirements
- Core **Views** enabled. The display style must be **Table** (core) or **Views flipped table** (contrib `view_flipped_table`).

## Steps
1. Edit a view whose format is *Table*.
2. In the **Header** or **Footer**, add the area handler **"Views table client side download csv button"** (plugin id `views_table_cs_download_csv_button`).
3. Save. The button renders as `Download CSV`; the validate step blocks it on unsupported (non-Table) styles.

## How it works
- `Button::render()` emits `#theme` `views_table_cs_download_csv_button` with `view_id`, `display_id`, and a `filename` derived from the view title (`Html::cleanCssIdentifier`, lowercased, else `table`).
- `template_preprocess_...button()` builds a `<button>` with a JSON `data-views-table-client-side-download-csv-button` attribute and attaches library `views_table_cs_download_csv/initiator`.
- `hook_preprocess_views_view_table` / `_flipped_table` tag the matching table with `data-views-table-client-side-download-csv-target-table="{view_id}--{display_id}"`.
- `js/initiator.js` finds that table, iterates `tr`/`td,th`, quotes each `innerText`, joins with `,`/`\n`, and downloads a `text/csv` Blob named `<filename>.csv`.

## Operational notes
- **Client-side only:** only the rows currently in the DOM (the visible page) are exported. For full-dataset/server export use `views_data_export`.
- **Access:** governed solely by the view's access settings — there is no separate export route.
- **Quoting (`js/initiator.js:37`):** embedded double quotes in cell text are not escaped, so such cells can produce malformed CSV.
