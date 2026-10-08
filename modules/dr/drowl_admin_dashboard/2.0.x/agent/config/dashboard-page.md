<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The dashboard page, layout, blocks, libraries, and hooks

Everything here is shipped config + a small `.module`. There is no PHP plugin/service code and no
settings form (README: "The module has no menu or modifiable settings").

## Page Manager page — `config/install/page_manager.page.admin_dashboard.yml`

- `id: admin_dashboard`, `path: /admin/dashboard`, `use_admin_theme: true`.
- Access: `access_logic: and`, one `access_conditions` entry — plugin `user_permission`
  (from the `user_permission_condition` module), `permission: 'access drowl admin dashboard'`,
  `negate: false`, `context_mapping.user: current_user`. So the page renders only for users with
  that permission.
- Enforced module dependencies: `user_permission_condition`, `drowl_admin_dashboard`.

## Page Variant — `config/install/page_manager.page_variant.admin_dashboard-layout_builder-0.yml`

- `variant: layout_builder`, `id: admin_dashboard-layout_builder-0`. One section using
  `layout_id: admin_dashboard_default`. Depends on the three views + the page config.
- Components placed into layout regions:
  - `left_top`: menu_block `admin` ("Add content") — `parent: admin:admin_toolbar_tools.extra_links:node.add`,
    `level 1`, `depth 1`, `expand_all_items`, `suggestion: drowl_admin_dashboard_tiles` (styled tiles);
    then `views_block:drowl_admin_dashboard_content-…_content_block`; then
    `views_block:scheduler_scheduled_content-block_1` (only if Scheduler is installed).
  - `left_middle`: `views_block:drowl_admin_dashboard_people-…_people_block`.
  - `right_top`: `views_block:drowl_admin_dashboard_user_profile_display-…` with
    `context_mapping.uid: '@user.current_user_context:current_user'` (shows the current user);
    `menu_block:admin-quicklinks` ("Admin Quicklinks"); `search_api_page_form_block`
    (search_api_global); `devel_switch_user` (Switch user); `views_block:who_s_online-who_s_online_block`.
  - `right_bottom`: `system_powered_by_block`.
- Route generated for the variant: `page_manager.page_view_admin_dashboard_admin_dashboard-layout_builder-0`
  (this is what the menu link targets).

Note: several referenced blocks come from **optional/other** modules (search_api_page, devel,
who's online view, scheduler). They are placed as components but only render where that provider
exists; each still enforces its own access.

## Layout — `drowl_admin_dashboard.layouts.yml`

`admin_dashboard_default` (label "Admin Dashboard Default Layout", category `Administration`),
template `templates/layout/admin_dashboard_default.html.twig`. Eight regions: `top`, `left_top`,
`left_middle`, `left_bottom`, `right_top`, `right_middle`, `right_bottom`, `bottom`.

## Libraries — `drowl_admin_dashboard.libraries.yml`

- `admin_dashboard`: `css/drowl_admin_dashboard.min.css`, depends on `admin_iconset`.
- `admin_iconset`: `/libraries/drowl-admin-iconset/style.css` (external asset; see requirements
  check in `.install`).
- `admin_toolbar_gin`, `admin_toolbar_adminimal`: toolbar CSS variants for the Gin/Adminimal admin
  themes.

## `.module` hooks

- `hook_form_user_login_form_alter` + `drowl_admin_dashboard_user_login_submit`: after login, if no
  `destination` is set and the user has **both** `redirect to drowl admin dashboard on login` and
  `access drowl admin dashboard`, redirect to `internal:/admin/dashboard`; otherwise preserve any
  `destination`.
- `hook_preprocess_html`: adds body class `drowl-admin-dashboard` when the current path is
  `/admin/dashboard`.
- `hook_toolbar_alter`: attaches `drowl_admin_dashboard/admin_toolbar` to the administration
  toolbar item.
- `hook_theme`: registers `menu__drowl_admin_dashboard_tiles` (base hook `menu`) for the "Add
  content" tiles, template `templates/menu--drowl-admin-dashboard-tiles.html.twig`.

## `.install`

`hook_requirements($phase == 'runtime')`: looks up the `admin_iconset` library and reports OK/ERROR
depending on whether its CSS file exists under `DRUPAL_ROOT`, telling the operator to
`composer require npm-asset/drowl-admin-iconset` (via the asset-packagist repo). No schema updates.
