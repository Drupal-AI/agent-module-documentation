<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Json table provides a field widget and formatters to store table data in a JSON field and render it as tables, charts or a gridstack layout.

---

Json table provides a widget and formatters for storing tabular data in a JSON field and rendering
it in several ways — as an HTML table (via spreadsheet-style editors), as charts (Google Charts /
Chart.js), and as a draggable gridstack layout (the `json_gridstack` submodule). Editors enter data in
a grid/spreadsheet widget and choose a formatter to display it. Rendered output goes through Drupal's
render layer: the raw formatter uses `#markup` (filtered by `Xss::filterAdmin`), and templates render
values through Twig.

Use it to let editors maintain tables, simple charts or card grids as structured JSON on an entity,
without custom field types per case. It is a content-editing/display module; the data is authored, and
because a raw formatter passes field content through `#markup`, apply the usual caution about who may
edit these fields (admin-XSS filtering allows a broad tag set). No access-control role.

---

- Store tabular data in a JSON field.
- Provide a spreadsheet-style widget.
- Render JSON data as an HTML table.
- Render data as Google Charts or Chart.js.
- Lay out data as a gridstack (json_gridstack).
- Choose a formatter per display.
- Edit data in a grid widget.
- Maintain tables as JSON on an entity.
- Render values through the Twig layer.
- Note the raw formatter uses filtered #markup.
- Caution who may edit these fields.
- Avoid custom field types per table.
- Build simple charts from field data.
- Display card grids from JSON.
- Provide widget and formatters.
- Store structured JSON data.
- Present editable tables.
- Use spreadsheet editors for input.
- Have no access-control role.
- Render JSON as tables/charts/grids.
