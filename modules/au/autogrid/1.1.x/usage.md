<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Displays all content of a chosen entity type/bundle in a sortable, paged table whose columns are generated automatically from the bundle's fields.
---
At `/admin/config/content/autogrid/settings` (`administer autogrid settings`) an admin selects which entity types get a grid. A route subscriber (`RouteSubscriber`) then adds a `.../grid` route hung off each selected type's edit-form/canonical link template (e.g. `/admin/structure/types/manage/<type>/grid`), guarded by the `view autogrid` permission. The `GridController` builds a header from the bundle's field definitions, renders each field with its display formatter, appends entity operation links, and pages the results.

The module is display-only and entirely permission-gated: the settings form requires `administer autogrid settings` and the generated grid routes require `view autogrid` (both `restrict access: true`). It does not expose anonymous or mutating endpoints; it reads existing entities and renders them. Use it to give editors a spreadsheet-like overview of a content type without building a View.
---
- Show all nodes of a content type in a table without configuring a View.
- Auto-generate table columns from a bundle's field definitions.
- Enable grids per entity type from the settings form.
- Provide editors a spreadsheet-style overview of content.
- Sort the grid by any column (ID or field).
- Page through large result sets with the core pager.
- Include per-row operation links (edit/delete) in the grid.
- Render each field value using its configured display formatter.
- Add a grid tab to content-type management pages.
- Restrict grid access with the `view autogrid` permission.
- Restrict grid configuration with `administer autogrid settings`.
- Give a quick data overview for custom/config entity types that use bundles.
- Support taxonomy, media or other bundled entity types.
- Review content at a glance before bulk editing elsewhere.
- Use the default view mode to render field cells.
- Expose grids only for the entity types you explicitly enable.
- Avoid writing custom Views for simple tabular overviews.
- Let content admins scan field values across many entities.
- Combine with Field UI to control which fields display.