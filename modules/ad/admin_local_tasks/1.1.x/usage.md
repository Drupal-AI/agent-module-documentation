Restyles Drupal's local-task (tabs) block into a fixed, minimalistic icon menu pinned to the left or right of the screen for logged-in users on non-admin (front-end) routes.

---

Admin Local Tasks makes the primary/secondary local tasks (the View / Edit / Delete / Revisions / Translate tabs) fancier and easier to reach for content editors while they browse the front end of the site. For authenticated users on a non-admin route it attaches a small CSS/JS library and overrides the `menu-local-tasks` template so the tabs become a compact, fixed icon menu docked to the left (or right) of the viewport; on admin routes the normal core tabs are untouched, and anonymous visitors are never affected. Each task is given an icon CSS class derived from its route name (canonical→view, edit_form→edit, delete_form→delete, version_history→revisions, translation overviews→translate, and many more), and optional hover tooltips (powered by the bundled Tippy.js) can show each link's title. A settings form at `/admin/config/user-interface/admin-local-tasks` (guarded by the `administer admin_local_tasks` permission) chooses the screen side and toggles tooltips. Other modules can extend the route-to-icon mapping through the `hook_local_tasks_mapping_alter()` hook. Requires the core Primary tabs (local tasks) block to be placed in the theme.

---

- Give content editors quick, always-visible View/Edit/Delete tabs while previewing pages on the front end.
- Pin the local tasks to the left side of the screen as a fixed icon bar.
- Pin the local tasks to the right side instead, via the settings form.
- Turn each local task into a compact icon rather than a full-width tab row.
- Show the link title as a hover tooltip using the bundled Tippy.js when tooltips are enabled.
- Keep the standard core tabs on admin routes while restyling them only on front-end routes.
- Avoid affecting anonymous visitors — the restyled tabs load only for logged-in users.
- Provide editors a consistent quick-edit affordance across all front-end content types.
- Map edit/delete/revision/translate routes to recognizable icons automatically.
- Add a translate icon to content and config translation overview tabs.
- Add a revisions icon to version-history tabs.
- Add a user icon to the user edit tab.
- Add clone / shortcuts / backlinks icons when those contrib tabs are present.
- Add Webform-specific icons (submissions, test, results, settings, export) on Webform local tasks.
- Let a custom module register its own route-to-icon mapping via `hook_local_tasks_mapping_alter()`.
- Restrict who can change the appearance settings with the `administer admin_local_tasks` permission.
- Switch the tab position site-wide from one config screen without touching theme code.
- Reuse the module's shipped SVG icon set for common admin actions.
- Improve editor UX on decoupled-ish or front-end-heavy sites where editors rarely enter `/admin`.
- Cache-tag the styling so changing the position/tooltips setting invalidates the tabs block correctly.
