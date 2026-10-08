# Views Node Access Filter — the "Editable" filter

## What it is
A Views filter that keeps only nodes the current user has **update (edit) access** to. Registered by
`views_node_access_filter_views_data_alter()` on:
- `node_field_data['editable']` — filter id `views_node_access_filter_editable`, `field => nid`.
- `node_field_revision['editable']` — same filter id, `field => vid`.

Plugin: `src/Plugin/views/filter/Editable.php` (`@ViewsFilter("views_node_access_filter_editable")`,
extends `FilterPluginBase`).

## Adding it to a view
In the Views UI, add filter criterion **Content: Editable** (or **Content revision: Editable**).
There are no operator/value options (`operatorForm()` and `adminSummary()` are empty) and it **cannot
be exposed** — `canExpose()` returns `FALSE`. In config, add a filter with
`plugin_id: views_node_access_filter_editable`. The filter adds the cache context `user`.
`query()` throws `\Exception("Editable filter is only compatible with SQL views.")` if the view's
query backend is not `Sql`.

## How access is enforced (fail-closed)
1. `Editable::query()` calls `ensureMyTable()` and `addTag('views_node_access_filter_editable')`.
2. `views_node_access_filter_query_views_node_access_filter_editable_alter()` runs on that tagged
   query: `addMetaData('op', 'update')` then `addTag('node_access')`.
3. Core's `node_query_node_access_alter()` sees the `node_access` tag with `op = update` and joins
   the `node_access` registry table, restricting rows to nodes with an UPDATE grant for the user.
4. `views_node_access_filter_module_implements_alter()` forces this module's `query_alter` to run
   *before* core's so the metadata/tag are present when core alters the query.

This ADDS a constraint (it can only remove rows), and because the filter is non-exposable there is no
request/URL parameter that can weaken or disable it. Empty/anonymous grant sets simply match nothing
for edit access.

## Node grants it registers (why lists work at all)
Core only writes *view* grants to the node access registry (list queries never call
`hook_node_access()`), so update access would not be filterable in SQL. To fix that
(`views_node_access_filter.access_records.inc`):
- `hook_node_grants($account, 'update')` → grants `edit any <type> content` (gid 0) and
  `edit own <type> content` (gid = uid) per content type, from the user's permissions; for `view`,
  grants `view own unpublished content` (gid = uid).
- `hook_node_access_records($node)` → per node writes `edit any <type> content` (grant_update=1) and,
  for the owner, `edit own <type> content` (grant_update=1). **All with `grant_view = 0`** — these
  records never grant view access.
- `hook_node_access_records_alter(&$grants, $node)` → because core stops writing its default
  `all/0/grant_view=1` record as soon as ANY module writes records, this re-adds the default VIEW
  grant to mimic core: `all/0/grant_view=1` for published nodes, `view own unpublished content` for
  the owner of unpublished nodes — but ONLY when no other node-access module has defined records
  (`_views_node_access_filter_external_grants_are_defined()` compares counts). So enabling this
  module does not change default view visibility, and when another node-access module is present it
  defers view handling to that module.

## Rebuild triggers
- `views_node_access_filter_user_role_update()` calls `node_access_needs_rebuild(TRUE)` when a role
  changes.
- `views_node_access_filter_update_8002()` flags a rebuild on update/install.
- Otherwise the standard core triggers (node save, permission save, module enable/disable) keep the
  registry current.

## Caveats (from `hook_help`)
- Node-access modules that alter **update** access purely via `hook_node_access()` without
  registering grants via `hook_node_grants()` / `hook_node_access_records()` are **not** reflected in
  this filter. The help text notes the node may still be listed if view access is allowed, but edit
  access will still be denied by the other module at the entity level — so this is a listing
  inaccuracy, not an access bypass.
- SQL Views only.

## Security note
This is an access-tightening filter and is fail-closed: it only adds constraints, cannot be exposed,
and its own grants never grant view.
