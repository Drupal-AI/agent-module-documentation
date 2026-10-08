<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Table Client-Side Download (CSV) provides a Views area handler that drops a "Download CSV" button into a table-style view; clicking it builds a CSV from the already-rendered table and downloads it in the browser.

---

The area plugin (`Button`, `@ViewsArea("views_table_cs_download_csv_button")`) can only be added to displays whose style plugin is the core *Table* (its `validateOptionsForm` rejects unsupported styles, and it also supports the contrib *Views flipped table*). When rendered, it emits a `<button>` carrying a JSON data attribute (view id, display id, filename, target-table identifier) and attaches the `initiator` JS library. A preprocess hook tags the matching table with a `data-...-target-table` attribute so the script can find it. On click, `js/initiator.js` walks the table's `tr`/`td`/`th` cells, wraps each cell's `innerText` in double quotes, joins rows, and triggers a Blob download. Because the export reads the rendered DOM, only the rows currently visible are exported — paged results export a single page (the README points to views_data_export for full-dataset server-side export).

There is no server route, controller, or permission of its own: access is entirely governed by the host view's access settings, since the data is already on the page the user is viewing. Note that the JS does not escape embedded double quotes inside cell text, so such cells can produce malformed CSV.
---
- Add a client-side "Download CSV" button to a Table-style view.
- Let users export the current page of a Views table without a server round-trip.
- Export a filtered/sorted table exactly as displayed.
- Provide CSV download on a public report view gated only by the view's own access.
- Add the button to a Views flipped table display.
- Set a custom download filename (derived from the view title).
- Place the button in a view header or footer area.
- Offer a lightweight export where full-dataset server export is unnecessary.
- Give editors a quick CSV of an admin listing they are already viewing.
- Combine with exposed filters so users export their filtered result set.
- Avoid extra module dependencies beyond core Views.
- Export tabular data for spreadsheets from a dashboard view.
- Restrict export visibility by restricting the host view's access.
- Prevent adding the button to unsupported (non-table) style plugins.
- Support multi-column tables including header cells in the output.
- Download the table as a `.csv` Blob generated in the browser.
- Add a self-serve data grab to a members-only view.
- Use on a paged view knowing only the visible page is exported.
- Skip server load for small tables that fit on one page.
- Pair with views_data_export when the full dataset must be exported instead.
