<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mechanism, builder & theming

All logic lives in `admin_toolbar_tasks.module` plus one class,
`src/AdminToolbarTasksBuilder.php`. There is no config, no route, no permission, no service, no
`.install`. Enable with `drush en admin_toolbar_tasks`; nothing to configure.

## The flow

1. **`hook_toolbar()`** registers a `#type => toolbar_item` keyed `admin_toolbar_tasks`
   (`#weight` 1000, `#wrapper_attributes` class `admin-toolbar-tasks-tab`). Its tab body is a
   `#lazy_builder` calling `AdminToolbarTasksBuilder::build` with `#create_placeholder => TRUE` and
   `#cache => ['keys' => ['admin_toolbar_tasks'], 'contexts' => ['route']]`. It attaches library
   `admin_toolbar_tasks/toolbar.item`.

2. **`hook_menu_local_tasks_alter(&$data)`** runs on every request and decides which primary tabs
   (`$data['tabs'][0]`) to relocate. It **returns early (does nothing)** when:
   - the current route is an admin route (`router.admin_context` → `isAdminRoute()`), or
   - the current user lacks the `access toolbar` permission, or
   - the active theme name equals the configured admin theme (`system.theme:admin`) — covers routes
     rendered with the admin theme but not flagged as admin routes, or
   - there are no primary tabs.

   Otherwise, for each tab whose `#link['url']` is a routed `Url` pointing at an **admin route**, it
   sets `#admin_toolbar_tasks = TRUE`, copies the tab's current `#access` into
   `#admin_toolbar_tasks_access`, then overwrites `#access` with `AccessResult::forbidden()`. That
   forbidden result hides the tab from the normal local-tasks block so it is not shown twice.

3. **`AdminToolbarTasksBuilder::build()`** (a `TrustedCallbackInterface`, so it is allow-listed as a
   lazy builder — `trustedCallbacks()` returns `['build']`). It builds
   `#theme => 'links__admin_toolbar_tasks'` with `#links` from `getAdminTasks()`, and applies a
   `CacheableMetadata` bag to the render array.

4. **`getAdminTasks(CacheableMetadata $cacheability)`** adds the `route` cache context, then
   re-fetches `plugin.manager.menu.local_task` → `getLocalTasks($currentRouteName)['tabs']`, sorts
   by `#weight`, and keeps only tabs flagged `#admin_toolbar_tasks`. For each kept tab it re-reads
   the stashed `#admin_toolbar_tasks_access`: the link is emitted **only if** that value is an
   `AccessResultInterface` **and** `->isAllowed()`, and the access result is registered as a
   cacheable dependency. Each emitted link is `['type' => 'link', 'title' => $tab['#link']['title'],
   'url' => $tab['#link']['url']]`.

**Access note:** the module never widens access — it carries the tab's own access result through and
enforces it again before rendering. Tabs with no `AccessResultInterface` in the stash are skipped.

## Dependencies injected
`AdminToolbarTasksBuilder::create()` pulls `plugin.manager.menu.local_task`
(`LocalTaskManagerInterface`) and `current_route_match` (`RouteMatchInterface`).

## Cacheability
Placeholdered per `route`; the rendered links additionally carry the cacheability of every task's
access result. Because it is a lazy-builder placeholder, the toolbar block itself stays cacheable
while the per-route/per-user variation happens inside the placeholder.

## Theming / overriding
- **Template** `templates/links--admin-toolbar-tasks.html.twig`: sets `bem_block =
  'admin-toolbar-tasks'`; when more than one link, prints a hidden checkbox
  (`admin-toolbar-tasks__toggle-state`) + a `⋮` `<label>` toggle, then a `<ul>`
  (`admin-toolbar-tasks__menu`) of `<li>` items. Override via a theme suggestion on
  `links__admin_toolbar_tasks`.
- **CSS** `css/admin-toolbar-tasks.css`: floats the tab right, and a pure-CSS
  checkbox-toggle dropdown (no JavaScript). Override/replace by defining your own library or
  extending the theme.
