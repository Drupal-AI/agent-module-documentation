<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views integration (the `router` base table)

`routes_list.module` implements `hook_views_data()` (function `routes_list_views_data()`) to expose
Drupal's `router` database table to Views as a base table. This is independent of the report page;
it lets you build a custom routes view if core `views` is enabled.

Registered data:
- **Base table** `router`: group "Routes", base title "Routes", help "Core Routes", `field => 'router'`.
- **Fields**: `name` (title "Name", `id => standard`, property `name`, click-sortable) and `path`
  (title "Path", `id => standard`, property `path`, click-sortable).
- **Filters**: `name` and `path`, both `id => string`.
- **Sorts**: `name` (`field => name`) and `path` (`id => standard`).

Usage: with Views enabled, create a view whose base is **Routes** and add the Name/Path fields,
string filters, or sorts. Note the definitions are minimal — only `name` and `path` are declared as
Views handlers even though the `router` table has more columns; there is no relationship, argument,
or access handler provided here.
