<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DROWL Admin Dashboard ships a ready-made administrative dashboard page at `/admin/dashboard` that aggregates content, people, and quick-link blocks as an overview and landing page for site maintainers.

---

The 2.x line builds the dashboard entirely from shipped configuration: a `page_manager` page (`admin_dashboard`, path `/admin/dashboard`) with a Layout Builder variant on a module-provided eight-region layout (`admin_dashboard_default`), populated by blocks. Those blocks include three shipped Views (a Content list, a People list, and a compact current-user profile), a menu_block "Add content" tile menu, an Admin Quicklinks menu, and optional third-party blocks (search_api, devel switch-user, who's online, scheduler). The page is gated by a single module permission, `access drowl admin dashboard` (via `user_permission_condition`), while each embedded View independently enforces its own standard Drupal permission. The module has no settings form; it also optionally redirects users to the dashboard on login, adds a body class on the dashboard route, and attaches admin-toolbar CSS. It requires the contrib modules `drowl_admin`, `menu_block`, `page_manager`, and `user_permission_condition`, plus core `layout_builder`, `node`, `user`, and `views`, and suggests the `npm-asset/drowl-admin-iconset` asset library for its icons.

---

- Give site maintainers a single administrative landing page at `/admin/dashboard`.
- Add a "Dashboard" link under the top-level Administration menu (weight -9).
- Restrict who sees the dashboard with the `access drowl admin dashboard` permission.
- Automatically redirect a role to the dashboard after login (opt-in permission).
- Show a recent/all Content list with title, type, author, status, and operations, linking to `/admin/content`.
- Show a People list with picture, username, roles, created, last-access, and operations, linking to `/admin/people`.
- Show the logged-in user's compact profile (picture, name, email, "user since", last access, edit/password/logout links).
- Surface an editable "Admin Quicklinks" menu of frequently used admin links on the dashboard.
- Present content-type "Add content" links as styled tiles via a menu_block of the admin `node.add` menu.
- Embed a global site search block (search_api_page) on the dashboard when available.
- Embed a "Who's online" block and a Scheduler "scheduled content" block when those modules exist.
- Provide an eight-region Layout Builder layout (`admin_dashboard_default`) reusable for admin pages.
- Reuse the three dashboard Views as standalone blocks elsewhere (each has a block display).
- Improve onboarding for new site managers with one consolidated overview screen.
- Theme the admin toolbar for Gin or Adminimal admin themes via bundled CSS libraries.
- Filter the dashboard Content list by title, status, type, and language (exposed filters).
- Filter the dashboard People list by username and role (exposed filters).
- Use the dashboard as a customizable base: rearrange or add blocks through Page Manager / Layout Builder.
- Provide a maintainer overview of content and user activity without hunting through the admin menu.
