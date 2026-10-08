<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Workbench Tabs pulls Drupal's local task tabs (Edit / View / Revisions / Delete) and status messages out of the theme and renders them in a fixed bar at the top of every page, so their position and styling no longer depend on which theme is drawing the current page.

---

The module implements `hook_page_top()` to add its own render element to every page. A small service, `WorkbenchTabsInfo::applyWorkbenchTabs()`, decides whether to do so: it returns TRUE when the `enable_for_admin_theme` setting is on, or when the current route is *not* using the admin theme. So out of the box (setting off) the bar appears only on front-end/non-admin-theme pages, where relocating the tabs is most valuable; the settings form's "Everywhere" option flips it on for admin pages too, and the `workbench_tabs_update_8001` hook sets that flag for existing sites to preserve prior behaviour. The bar itself is a themed `<div class="workbench-tabs toolbar">` containing two custom render elements: `workbench_tabs_local_tasks` (a `LocalTasks` element that asks the core `plugin.manager.menu.local_task` for the primary and secondary tasks of the current route, with a regex workaround for canonical entity routes hijacked by Page Manager) and `workbench_tabs_status_messages` (a `StatusMessages` element that reads `messenger->all()` and then `deleteAll()`, so each message is shown exactly once, in this bar instead of the theme's normal location). The whole element carries `#access => hasPermission('use workbench_tabs')`, so only users granted that permission (authenticated users by default) get the relocation; everyone else sees messages where their theme normally puts them. When the bar is active, `hook_block_build_alter()` sets `#access => FALSE` on the core `local_tasks_block` to prevent the tabs appearing twice. A small JS behaviour adds a Show/Hide-messages toggle and auto-collapses the message drawer once the user scrolls past it. Despite the "Workbench" package name the module is standalone — no dependency on the Workbench module or on the core Toolbar module. Settings live at `/admin/config/content/workbench-tabs` behind `administer site configuration`.

---

- Keep the Edit/View/Revisions tabs in one fixed place across every theme.
- Show status messages in a consistent location regardless of theme.
- Let a custom front-end theme skip placing and styling local task tabs.
- Surface local tasks on a front-end theme that has no tabs region.
- Prevent long status messages from breaking a page layout.
- Give editors a predictable spot for administrative controls while browsing the site.
- Restrict the relocated tabs/messages to editors via the `use workbench_tabs` permission.
- Apply the treatment only on non-admin themes (default) to leave the admin theme untouched.
- Apply the treatment everywhere, including admin pages, via the "Everywhere" setting.
- Ensure each Drupal message is displayed exactly once per request.
- Avoid duplicate tab rows by suppressing the core local tasks block when active.
- Collapse the message drawer automatically as the user scrolls down.
- Provide a manual Show/Hide toggle for the message area in the bar.
- Support editorial workflows where users move between front-end and admin themes.
- Standardize local-task placement across a multi-theme site.
- Keep local tasks working on entity pages whose routes are altered by Page Manager.
- Remove the need for each theme to define and style a status-message region.
- Give screen-reader-friendly, single-render message output for confirmations.
- Configure whether the bar covers admin pages from a single settings form.
- Roll out consistent editorial chrome without editing every theme template.
