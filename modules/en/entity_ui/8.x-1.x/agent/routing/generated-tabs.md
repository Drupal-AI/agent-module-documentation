<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Generated tab routes, local tasks & page access

## Attaching to target entity types

`entity_ui_entity_type_build()` (`entity_ui.module`) runs over the types returned by
`TargetEntityTypes::filterTargetEntityTypes()` (content group + has a `canonical` link template).
For each it:

1. Adds `Routing/TabRouteProvider` to the type's `route_provider` handlers (unless already set) —
   this generates the tab pages.
2. Sets an `entity_ui_admin` handler (unless the type already declares one) so the tab config UI
   sits beside the type's existing admin UI. Selection:
   - `EntityHandler/BundleEntityCollection` — type has a bundle entity type with a `collection`
     link template (e.g. nodes → content types list).
   - `EntityHandler/FieldUIWithoutBundleEntityProxy` — no bundle entity but a
     `field_ui_base_route`; at router rebuild this proxy resolves to
     `PlainBundlesEntityUIAdmin` or `BasicFieldUI`.
   - Types with a `bundle_plugin_type` are skipped (unimplemented).

## Per-tab page routes (`Routing/TabRouteProvider::getRoutes()`)

For each `entity_tab` of the type (loaded by `EntityTabsLoader::getEntityTabs()`), a `Route` is
built at `<canonical link template>/<path component>` with:

- `_controller` → `EntityTabController::content`
- `_title_callback` → `EntityTabController::title`
- default `_entity_tab_id` = the tab ID
- requirement `_custom_access` → `EntityTabController::access`
- `parameters` option upcasting the target entity (`type: entity:<type>`)

Route name is `entity.<target_type>.entity_ui_<path>` (`EntityTab::getRouteName()`).

## Local tasks & actions

- `Plugin/Derivative/EntityLocalTasks` (via `entity_ui.links.task.yml`
  `entity_ui.target_entity_local_tasks`) derives one local task per tab, `base_route` =
  `entity.<type>.canonical`, title = tab title, route = the tab route above.
- `Plugin/Derivative/EntityTabsAdminLocalTasks` / `EntityTabsAdminLocalActions` add the admin-side
  tasks/actions (the "Add entity tab" action, `entity_ui.links.action.yml`).
- `hook_local_tasks_alter()` lets each `entity_ui_admin` handler adjust tasks.

## Page rendering & access

`Controller/EntityTabController`:

- `content()` loads the tab by `_entity_tab_id`, gets the target entity from the route match, and
  returns `tab->getContentPlugin()->buildContent($target_entity)`.
- `title()` returns `tab->getPageTitle($target_entity)` (token-replaced).
- `access()` returns `tab->access('view', $account, TRUE, $target_entity)`.

`EntityTab::access('view')` (`src/Entity/EntityTab.php`) combines
`hasBundleAccess($target_entity)` (the tab must apply to that entity's bundle) with the content
plugin's `access()` result (its permission and logic checks — see
[../plugins/tab-content.md](../plugins/tab-content.md)). The tab's dedicated permission
(`access <path> tab on <any|own> <type> <bundle> entities`) is granular per bundle and, for
owner-aware entity types, per any/own ownership. Because a tab exposes entity management
(view / edit / owner change / action execution), grant each tab permission only to trusted roles
and scope `target_bundles`
appropriately.

## Breadcrumbs

`Breadcrumb/AdminBreadcrumbBuilder` (priority 100, extends the default) builds breadcrumbs for the
generated admin collection pages.
