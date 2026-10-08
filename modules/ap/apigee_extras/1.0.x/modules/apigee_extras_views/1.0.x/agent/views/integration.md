<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Apigee Apps in Views

## Enable

```bash
drush en apigee_extras_views -y   # requires apigee_extras + views (+ apigee_edge)
```

Then *Structure → Views → Add view* and pick **"Apigee Apps"** (View settings → *Show:* Apigee Apps)
as the base. Add fields/filters/sort from the list below and choose a display (page/block).

## Base table (`apigee_extras_views_views_data()` in `apigee_extras_views.module`)

`$data['apigee_app']['table']['base']` sets `title = "Apigee Apps"`, `help = "Lists developer apps
from Apigee Edge."`, and crucially `query_id => 'apigee_app_query'` — so this base uses the custom
query plugin, not the SQL backend.

| Views field | Property | Handlers declared |
|---|---|---|
| `name` | app machine name | field `apigee_app_field`, **filter** `string`, **sort** `standard`, **argument** `string` |
| `display_name` | app display name | field `apigee_app_field` |
| `status` | app status (approved/revoked) | field `apigee_app_field` |
| `developer_email` | owning developer id/email | field `apigee_app_field` |
| `created_at` | creation timestamp | field `apigee_app_field` |
| `description` | app description | field `apigee_app_field` |

## Field handler — `ApigeeAppField` (`apigee_app_field`)

`src/Plugin/views/field/ApigeeAppField.php`, `@ViewsField("apigee_app_field")`, extends
`FieldPluginBase`.

- `query()` — empty (no SQL contribution; data comes from the query plugin).
- `render(ResultRow $values)` — resolves the property name from
  `$this->definition['field_name'] ?? $this->realField`, reads `$values->{$field}`, and returns
  `$this->sanitizeValue($value)`. Output is therefore **escaped** by core's field sanitizer.

## Query plugin — `ApigeeAppQuery` (`apigee_app_query`)

`src/Plugin/views/query/ApigeeAppQuery.php`, `@ViewsQuery(id = "apigee_app_query")`, extends
`QueryPluginBase`. Constructed with `entity_type.manager` (see `create()`).

`execute(ViewExecutable $view)`:

1. Resets `$view->result = []`.
2. Gets the `developer_app` storage from Apigee Edge, runs an entity query, and
   `loadMultiple()`s the apps.
3. For each app builds a `ResultRow` with `name` (`getName()`), `display_name`
   (`getDisplayName()`), `status` (`getStatus()`), `developer_email` (`getDeveloperId()`),
   `description` (`getDescription()`), `created_at` (`getCreatedAt()?->format('Y-m-d H:i:s')`),
   plus `_entity` (the app object) and an incrementing `index`.
4. Sets `$view->total_rows = count($view->result)`.
5. On any `\Exception`, logs `$e->getMessage()` to the `apigee_extras_views` logger channel and
   leaves the result empty.

The `addField()`, `addTable()`, `addWhere()`, `addOrderBy()` methods are **stubs**. Consequences:

- Exposed **filters/sorts/arguments** declared on `name` are Views-layer handlers only; because the
  query plugin ignores `addWhere`/`addOrderBy`, they do **not** narrow or order the underlying
  Apigee fetch — every app is loaded and (depending on the handler) filtering happens, if at all,
  in the Views result layer. Treat this base as an "all apps" source and expect no pager pushdown.
- There is **no paging at the API level**: all developer apps are loaded on every view build. On an
  org with many apps this is a performance consideration.

## Notes

- This base is **read-only**; there are no write/edit handlers.
- Values shown are app metadata (name, status, developer email, description, dates) — the query
  plugin does not put consumer keys/secrets onto the row.
- Access control for who may see a view built on this base is entirely the site builder's
  responsibility (the display's access plugin/permission). Plan the view's audience deliberately.
