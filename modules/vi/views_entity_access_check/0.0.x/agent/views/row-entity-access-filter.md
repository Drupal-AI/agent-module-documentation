<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Row-level entity access filter for Views

## When you need it
Use this module when a view lists entities that the current user should not be able to see, even
though a custom access module is installed. This happens because the access module decides in
`hook_entity_access()` / `hook_node_access()` (runtime PHP), and Views filters only at the SQL level
(node access grants, or `hook_query_TAG_alter()`). The runtime decision is never applied to the
listing, so forbidden rows appear. Core issue 777578 tracks the underlying gap.

Do **not** reach for this if the access module can express its rule in SQL — implementing
`hook_query_TAG_alter()` in that module is the correct, performant fix. This module is a workaround.

## How to enable
1. Install and enable `views_entity_access_check` (depends on core `views`).
2. Grant yourself the ability to reach the settings form. The form route requires the permission
   `administer views_entity_access_check configuration`, which the module never declares in a
   `.permissions.yml`; on a stock install only user 1 can open the form. If you need a non-superuser
   to configure it, you must declare/grant that permission yourself (e.g. a small custom module).
3. Visit `/admin/config/system/views-entity-access-check`.
4. In the multi-select "Enable on the following Views", pick **only** the views that leak. The value
   stored is a list of view machine names in `views_entity_access_check.settings:views`.
5. Test the affected views as a low-privilege account and confirm the forbidden rows are gone.

## What happens at runtime
On `hook_views_pre_render()`, for each selected view the module loops `$view->result` and, for every
row that has a loaded `_entity`, calls `$row->_entity->access('view')` as the **current user**. Rows
that fail are removed with `unset()`. Only the `'view'` operation is checked — there is no per-view
option to check `update` or `delete`, because the module is aimed at listings.

## Things to verify after enabling
- **Pager and counts**: because rows are removed after the query runs, the pager length and the total
  count come from the unfiltered query. A page can show fewer items than its configured size, and any
  displayed total is wrong. If exact paging matters, this workaround does not provide it.
- **Performance**: every row triggers an entity load and a full access check. Keep the selection list
  as small as possible and never enable it site-wide.
- **Rows without `_entity`**: only rows exposing a loaded `_entity` are checked. Aggregated views,
  views on a base table without an entity, or field-only rows expose no `_entity` and are passed
  through unchecked — confirm your view actually yields entity rows.
- **Caching**: the module's own settings screen warns it "impacts caching." Review the view's caching
  settings after enabling and re-test as different accounts.

## Retiring it
This is interim. When the access module gains a `hook_query_TAG_alter()` implementation, or core
resolves 777578, remove the view from the settings list and disable the module.
