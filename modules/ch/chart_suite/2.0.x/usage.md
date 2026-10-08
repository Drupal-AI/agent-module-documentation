<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Chart Suite

## What it is / when to use

- Adds file-field formatters that parse uploaded structured-data files (tables, trees, graphs) and render them as interactive charts.
- Use to visualise CSV/JSON/other tabular or graph data attached to entities.
- Built by SDSC with a bundled structured-data parsing library.

---

## Install & configure

- Depends on `field`, `file`, `system (>=8.7)`, `jquery_ui_dialog`, and `jquery_ui_menu`.
- On a file field's "Manage display", choose a Chart Suite formatter.
- Admin settings live at `/admin/config/media/chart_suite` (route uses the `admin` permission).
- The module attaches its `chart_suite/chart_suite` library for rendering.

---

## Usage & API notes

- Formatters detect the file's format via the bundled `SDSC\StructuredData\Format` registry and render an appropriate chart.
- Supported structures include tables, trees, and graphs.
- File parsing uses `file_get_contents` on the managed file's local path (server-side, on already-uploaded files).
- Rendering is client-side via the attached JS charting library.
- The admin route permission is literally `admin` (a non-standard permission string), effectively limiting access to users granted that permission / user 1.
- No anonymous or state-changing endpoints are added.
- Templates under `templates/` control chart markup.
- Works on standard core File fields; no custom entity types.
- The structured-data library is vendored under `src/SDSC/`.
- Charts are interactive (dialog/menu via jQuery UI).
- No external network calls — data comes from uploaded files.
- Config schema is provided for the formatter settings.
- Suited to scientific/data-portal sites presenting datasets.
- Extend by adding new format parsers to the registry.
- Access to charted data follows the host entity/file access.
- Uninstall removes the module's config and formatters.
