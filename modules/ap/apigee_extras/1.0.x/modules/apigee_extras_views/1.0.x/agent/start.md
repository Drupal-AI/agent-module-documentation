<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Apigee Extras Views (apigee_extras_views) — agent index

Submodule of **Apigee Extras** that exposes Apigee developer apps to **Views**. Package `Apigee`.
Depends on `apigee_extras:apigee_extras` and `views:views` (transitively `apigee_edge`).
Core `^10.3 || ^11.1`. GPL-2.0-or-later. Version **1.0.0-beta1**.

## What it provides

- **Views base table `apigee_app`** — declared in `apigee_extras_views.module`
  (`apigee_extras_views_views_data()`), group *"Apigee App"*, `query_id => apigee_app_query`.
  Fields: `name`, `display_name`, `status`, `developer_email`, `created_at`, `description`.
  Only `name` also declares `filter`/`sort`/`argument` handlers (string / standard / string).
- **Field handler `apigee_app_field`** — `src/Plugin/views/field/ApigeeAppField.php`
  (`ApigeeAppField extends FieldPluginBase`). `query()` is a no-op; `render()` reads the row property
  and returns `$this->sanitizeValue($value)` (output escaped).
- **Query plugin `apigee_app_query`** — `src/Plugin/views/query/ApigeeAppQuery.php`
  (`ApigeeAppQuery extends QueryPluginBase`). No SQL: `execute()` loads `developer_app` entities from
  the Apigee Edge entity storage and builds one `ResultRow` per app. `addField/addTable/addWhere/
  addOrderBy` are stubs, so exposed filters/sorts do not translate into a backend query.

No permissions, routes, services, config or Drush of its own. Access is whatever the site builder sets
on the view display.

## Docs

- Base table, handlers, plugins and how rows are fetched → [views/integration.md](views/integration.md)
