<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Table Client-Side Download (CSV) (views_table_cs_download_csv) — agent index

**A Views area handler that adds a browser-side "Download CSV" button exporting the currently rendered table.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11 — depends on `drupal:views`
- **Plugin:** area handler `Button` (`@ViewsArea("views_table_cs_download_csv_button")`), only valid on core *Table* style (and contrib *Views flipped table*).
- **JS:** `initiator` library (`js/initiator.js`) reads the tagged table DOM and downloads a CSV Blob. Only visible/current-page rows are exported.
- **No route, controller, or permission** — access is entirely the host view's access.

**Access:** gating is inherited from the view (client-side export of already-rendered data — no separate endpoint). `js/initiator.js` wraps each cell as `"${cell.innerText}"` without escaping embedded quotes, so cells containing `"` can produce malformed CSV.

See [configure/button.md](configure/button.md)
