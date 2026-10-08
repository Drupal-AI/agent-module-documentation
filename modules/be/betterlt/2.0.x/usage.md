<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Better Local Tasks replaces the rendering of Drupal's local task tabs (Edit / View / Delete, etc.) with a fixed, icon-driven slide-out panel pinned to the left edge of the page.

---

Local tasks are the small tab strip Drupal renders at the top of many pages via the Local Tasks block. In 2.0 this module overrides two templates (`menu_local_tasks` and `block__local_tasks_block`) and ships CSS that turns that strip into a vertical, collapsed panel fixed to the left edge of the viewport, mostly hidden off-screen and sliding out on hover, with an SVG icon per tab type. A `hook_preprocess_menu_local_task()` inspects each tab's route name and adds a semantic class (`view`, `edit`, `delete`, `revisions`, `devel`, `translate`, `clone`, `shortcuts`) that the CSS maps to the matching icon. The styling and the library are attached only on **front-end (non-admin) routes**, and only for users who have the **`access contextual links`** permission — anonymous users and admin-theme pages keep core's default tabs. There is no configuration form, no settings, no permissions of its own, and no database or config schema; enabling the module is the entire setup. Because the whole effect is a CSS/Twig presentation layer over the existing local-task system, the tabs still point at the same routes and do the same thing — the main check is that the fixed-panel styling agrees with your theme's markup and doesn't collide with other fixed elements. This is a new major over 1.x: the UI is now a specific left-edge slide-out panel rather than a generic tab restyle, and it explicitly scopes itself to non-admin routes.

---

- Replace Drupal's default local task tabs with a fixed slide-out panel.
- Pin View/Edit/Delete tabs to the left edge of front-end pages.
- Give each local task an icon (view, edit, delete, revisions, translate, clone, devel, shortcuts).
- Collapse a crowded tab strip into a compact hover-out panel.
- Keep tab actions and routes unchanged while restyling them.
- Show refined tabs on the public site without touching the admin theme.
- Limit the fancy tabs to users who can see contextual links (editors/admins).
- Modernise the editorial experience on the front end.
- Free up horizontal space at the top of content pages.
- Provide an icon-based quick-action rail for content editors.
- Style primary and secondary tabs consistently.
- Apply a distinctive tab UI site-wide (front end).
- Add semantic per-task CSS classes for further theming.
- Override the local tasks block template project-wide.
- Restyle revisions/translate tabs with dedicated icons.
- Polish the front-end UI cheaply with no code.
- Enable a modern tab look with zero configuration.
- Provide a base to further customise via CSS overrides.
- Hide tabs off-screen until hovered to reduce clutter.
- Keep default tabs on admin pages while restyling the front end.
