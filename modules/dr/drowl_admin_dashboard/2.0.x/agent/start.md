<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Admin Dashboard (drowl_admin_dashboard) — agent index

A configuration-only admin dashboard for the **2.x** line. It ships a `page_manager` page at
**`/admin/dashboard`** whose Layout Builder variant places blocks (three shipped Views + menus +
optional third-party blocks) onto a module-provided 8-region layout. No `src/`, no services, no
routes of its own, no settings form. Package `Administration`. License GPL-2.0-or-later. Version
**2.0.6**. Core `^8.9 || ^9 || ^10 || ^11`.

Note: 2.x is superseded upstream (3.x uses a Twig template + twig_tweak, 4.x uses core Navigation).

## Dependencies (info.yml)

Core: `layout_builder`, `node`, `system`, `user`, `views`. Contrib: `drowl_admin`, `menu_block`,
`page_manager`, `user_permission_condition`. Suggests asset `npm-asset/drowl-admin-iconset`
(icons; a `hook_requirements()` runtime check warns if the `/libraries/drowl-admin-iconset` CSS
is missing).

## What it provides

- **The dashboard page + layout** (page_manager page, layout_builder variant, `admin_dashboard_default`
  layout, the block components, libraries, and the `.module` hooks) →
  [config/dashboard-page.md](config/dashboard-page.md)
- **The three shipped Views** (Content, People, current-user profile — fields + per-view access) →
  [views/dashboard-views.md](views/dashboard-views.md)
- **Permissions, menu link, and the Admin Quicklinks menu** →
  [config/permissions-and-menu.md](config/permissions-and-menu.md)

## Quick facts (from source)

- **Permissions** (`drowl_admin_dashboard.permissions.yml`): `access drowl admin dashboard`
  (`restrict access: true`) gates the page; `redirect to drowl admin dashboard on login` opts a
  role into post-login redirect.
- **Page access** (`config/install/page_manager.page.admin_dashboard.yml`): `access_logic: and`,
  one `user_permission` condition requiring `access drowl admin dashboard` (current_user).
- **Views** (`config/install/views.view.drowl_admin_dashboard_*`): each display uses a `perm`
  access plugin — People → `administer users`, Content → `access content overview`,
  User profile → `access user profiles`. Each also has a `block` display used on the page.
- **Menu** (`drowl_admin_dashboard.links.menu.yml`): `Dashboard` under `system.admin`, weight -9,
  targeting the page_manager route. `config/optional/system.menu.admin-quicklinks.yml` defines an
  empty, editable `admin-quicklinks` menu.
- **Hooks** (`drowl_admin_dashboard.module`): login redirect, dashboard body class,
  `hook_toolbar_alter` (attach CSS), `hook_theme` (`menu__drowl_admin_dashboard_tiles`).
