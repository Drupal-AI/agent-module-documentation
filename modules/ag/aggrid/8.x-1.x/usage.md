<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Integrates the ag-Grid JavaScript data-grid library as a Drupal field type so content can be stored and edited in spreadsheet form.

---

The module defines an `aggrid` config entity that describes a grid's structure and default rows, plus a field type (`AggridFieldType`) whose value is the grid's JSON, matching widgets (`AggridWidgetType`, `AggridJsonWidgetType`) and formatters (`AggridFormatterType`, `HtmlFormatterType`, and a preview-warning-list formatter). A general settings form records which ag-Grid edition (Community open edition or Enterprise) and version to load and, for Enterprise, the license key. Grid config entities are managed at `/admin/structure/aggrid`; general settings live at `/admin/config/content/aggrid/general`. A Diff plugin renders field changes, and an access controller governs entity operations. A separate `aggrid_demo` submodule ships an example.

The ag-Grid library files are not bundled — you download the Community and Enterprise builds (via the module's Drush download helper or manually) as documented on drupal.org. Both admin routes are permission-gated: `administer aggrid config entities` (create/edit grid structures) and `administer aggrid general settings` (edition, source, license key). Both permissions are flagged `restrict access`/security-implication in the permissions file because a grid config controls rendered markup and JS behaviour, so grant them only to trusted roles.
---
- Store tabular / spreadsheet data in a single field
- Add an ag-Grid field to any entity (node, etc.)
- Define reusable grid structures as `aggrid` config entities
- Set default rows for a grid at `/admin/structure/aggrid`
- Add a grid config entity via the collection's add form
- Edit or delete existing grid config entities
- Configure the ag-Grid edition (Community vs Enterprise)
- Record the ag-Grid library version to load
- Store an ag-Grid Enterprise license key in general settings
- Download the ag-Grid library with the module's Drush helper
- Present grid data read-only with the aggrid formatter
- Render grid content as HTML with the HTML formatter
- Show a preview / warning list formatter for grid fields
- Edit grid values with the ag-Grid widget on entity forms
- Provide raw JSON editing via the JSON widget
- Diff grid field revisions with the bundled diff plugin
- Restrict grid administration to trusted roles via permissions
- Try the module quickly with the aggrid_demo submodule
- Build editable data tables inside content without custom code
- Suppress or transform grid output via the suppression helper
- Embed a spreadsheet-like editing experience in the node form
- Model structured rows/columns without extra content types