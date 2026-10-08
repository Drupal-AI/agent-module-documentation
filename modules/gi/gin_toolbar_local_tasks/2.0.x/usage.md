<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Gin Toolbar Local Tasks moves the current page's local task tabs (Edit / View / Revisions / Translate and the like) into Drupal's administration toolbar, so they sit in one fixed place instead of in the local-tasks row on the page.

---

The module is tiny and does exactly one thing. It implements `hook_toolbar_alter()` to attach a `#pre_render` callback (`GinToolbarLocalTasks::localTasks`, a `TrustedCallbackInterface`) to the core toolbar's `administration` tray. At render time that callback asks core's local-task plugin manager (`plugin.manager.menu.local_task`) for the local tasks of the current route, walks the primary tabs in weight order, and — crucially — keeps only the tabs whose `#access` result `isAllowed()`, so a user never sees a tab they cannot reach. The surviving tabs are injected as a single expandable "Local Tasks" menu item at the top of the administration menu (below any `admin_toolbar_tools.help` item, which is kept on top). The parent link points at the route's `edit_form` task when one exists. Because the tab set and its visibility depend on the page and the viewer, the callback copies the local-task manager's cacheable metadata onto the toolbar build — that metadata carries the `route` cache context plus whatever contexts the access checks depend on (typically `user.permissions`), which is what keeps the relocated tabs correct per page and per user. Despite the name, it does **not** require the Gin theme or the `gin_toolbar` module: it operates on core's toolbar, so it works with any theme that uses the core toolbar; `gin_toolbar` is only *suggested*, for using the tabs with Gin's frontend toolbar. There is no configuration, no permission, no admin form — enable it and the tabs move. It depends only on core `toolbar`, targets core `^10 || ^11`, and pairs naturally with Admin Toolbar. Its main limitation is directional: core's new `navigation` module is superseding the classic toolbar, and this module hooks the classic toolbar, so on sites that have switched to `navigation` it has nothing to alter.

---

- Move a node's Edit / View / Revisions tabs into the admin toolbar.
- Keep local tasks in one fixed position across every admin page.
- Stop the local-tasks row from pushing page content down.
- Tidy a crowded tabs row on entities with many local tasks.
- Give editors a single, predictable place to find "Edit".
- Improve editing ergonomics on the Gin admin theme specifically.
- Combine with Admin Toolbar so tabs live alongside the admin menu.
- Keep Translate / Manage-display tabs reachable without hunting the page.
- Reclaim vertical space above the content on edit-heavy screens.
- Surface Layout / Manage tabs for content editors in the toolbar.
- Keep moderation-related tabs visible in a consistent spot.
- Provide toolbar access to the current page's tasks on narrow viewports.
- Preserve per-user tab visibility (access-filtered) after relocation.
- Avoid a bespoke theme override just to reposition the tabs row.
- Standardise tab placement across a content team using Gin.
- Use with any core-toolbar theme, not only Gin, despite the name.
- Reduce visual clutter for first-time editors orienting on a page.
- Keep the active task discoverable while the page scrolls.
- Migrate from 1.x (which required gin_toolbar) to 2.x (which does not).
- Serve tabs from core's local-task manager so custom tabs appear automatically.
