Tab Toolbar (Tabs in Toolbar) moves a page's local task tabs (the primary/secondary tabs like *View / Edit / Delete*) out of the page body and into a "Page Actions" tray in Drupal's admin toolbar.

---

The module implements `hook_toolbar()` to add a `Page Actions` toolbar item whose tray lists the current route's primary and secondary local tasks, retrieved from the `plugin.manager.menu.local_task` service for the active route. It renders them through a small `tab_toolbar` theme hook / `tab-toolbar.html.twig` template as `toolbar-menu` lists. By default the tabs are hidden while the active theme is the admin theme; a single config flag (`admin.enabled` in `tab_toolbar.settings`) toggles whether they also show on the admin theme. The toolbar item carries `user.permissions` + `url.path` cache contexts and merges the local-task manager's cacheability so it varies correctly per page and per user. When core's Contextual Links module is disabled, the module attaches its own small CSS library for the toolbar-icon styling. It depends only on core's `toolbar` module and defines no permissions, services, or Drush commands; its one admin form lives at `/admin/config/tab_toolbar/settings` behind the core `administer site configuration` permission.

---

- Move node/entity View / Edit / Delete tabs into the toolbar to declutter the page body.
- Give editors a consistent "Page Actions" menu in the toolbar regardless of the page being viewed.
- Surface secondary local tasks (sub-tabs) in the same toolbar tray.
- Keep local tasks accessible on themes that hide or restyle the default tab block.
- Show page-action tabs only on the front-end theme (default) to keep the admin theme clean.
- Opt in to showing the tabs on the admin theme via the settings checkbox.
- Provide a toolbar-based tabs UI on a site that has removed the default `tabs` region/block.
- Reduce vertical space taken by local task tabs on content-heavy pages.
- Offer a keyboard/tab-reachable actions menu anchored in the toolbar.
- Integrate page actions into an existing custom toolbar setup that already uses `hook_toolbar()`.
- Let contextual-links-disabled sites still get styled toolbar action icons.
- Standardize where moderators find Edit/Revisions/Translate tabs across content types.
- Improve small-screen editing by collapsing tabs into a toolbar dropdown tray.
- Pair with an admin theme that intentionally omits the tabs block.
- Expose Views UI or other module tabs (which register as local tasks) inside the toolbar.
- Give a distraction-free reading layout on the front end while keeping edit actions one click away.
- Ensure per-user cache correctness so users only see tabs they have access to.
- Use as a lightweight alternative to admin_toolbar-style tab surfacing.
- Theme the toolbar tabs list by overriding the `tab-toolbar.html.twig` template.
- Toggle the feature per-environment purely through configuration (`tab_toolbar.settings:admin.enabled`).
- Provide a home-page link icon in the toolbar that opens the page-actions tray.
