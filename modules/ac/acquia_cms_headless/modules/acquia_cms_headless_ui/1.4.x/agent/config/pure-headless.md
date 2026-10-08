<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pure headless mode — install handler, routes & rewrites

## Install / uninstall (`acquia_cms_headless_ui.install`)

`hook_install()` (non-syncing): via service `acquia_cms_headless.pure_headless_mode` →
`createHeadlessUiPaths()` + `updateHeadlessUiConfig(TRUE)`, then `drupal_flush_all_caches()`.
`hook_uninstall()` reverses it: `deleteHeadlessUiPaths()` + `updateHeadlessUiConfig(FALSE)`.

## `PureHeadlessModeInstallHandler` (`src/Service/PureHeadlessModeInstallHandler.php`)

Injects `path_alias.manager`, `config.factory`, `entity_type.manager`, `messenger`,
`module_handler`, `theme_handler`.

- `headlessAliases()` — the alias map, e.g. `/admin/config/people/simple_oauth` → `/admin/access/
  settings`, `/admin/people/roles` → `/admin/access/roles`, `/admin/people` → `/admin/access/
  users`, `/admin/structure/types` → `/admin/content-models/content`, etc. (block paths differ
  pre/post Drupal 10.1).
- `createHeadlessUiPaths()` / `deleteHeadlessUiPaths()` — create or remove those `PathAlias`
  entities.
- `updateHeadlessUiConfig(TRUE)` — sets `system.theme` default to `gin` (if present); sets
  `system.site` `page.403 => /user/login` and `page.front => /frontpage`; disables
  `moderation_dashboard.settings` `redirect_on_login`; sets `views.view.content` title field
  `link_to_entity => FALSE` (kills node canonical links from the content list); sets
  `acquia_cms_headless.settings` `headless_mode => TRUE`. `FALSE` restores each.

## Config subscriber (`EventSubscriber\ConfigSubscriber`)

On `ConfigEvents::SAVE`: if `media.settings.standalone_url` changed → clear local-task cache; if
`system.site` saved → re-apply `page.front => /frontpage` (via
`_acquia_cms_common_update_page_configurations`) so pure-headless front page can't be overridden.

## Routes (`acquia_cms_headless_ui.routing.yml`)

| route | path | access |
|-------|------|--------|
| `acquia_cms_headless_ui.frontpage` | `/frontpage` | `_access: 'TRUE'` (renders login form) |
| `admin.access_control` | `/admin/access` | `access acquia cms headless dashboard` |
| `acquia_cms_headless_ui.users` | `/admin/access/users` | `administer users` |
| `admin.content_models` | `/admin/content-models` | `access block library+administer block content` |
| `admin.cms` | `/admin/cms` | `administer site configuration` |
| `entity.node.headless_preview` | `/node/{node}/site-preview` | `_entity_access: node.view` + `_module_dependencies: content_moderation` |

`/frontpage` is intentionally public: `FrontController::frontpage()` shows the core
`UserLoginForm` to anonymous users and redirects authenticated users with `access content
overview` to the content list. The preview route additionally gets the parent module's
`_preview_link_access_check` requirement (via `PreviewLinkRouteSubscriber`), which allows access
only to users with create/edit permission on the node's bundle.

## Site preview (`Controller\SitePreviewController`)

`nodePreview()` loads the node's latest revision, resolves the `next_entity_type_config` +
`next_site`(s) via `next.entity_type.manager`, instantiates the configured site-previewer plugin
(`next.settings` `site_previewer`, default `iframe`) and returns its rendered preview (alterable via
`hook_next_site_preview_alter`). `SitePreviewRouteSubscriber` repoints core's
`entity.node.latest_version` task to this `/node/{node}/site-preview` path.

## Admin-experience hooks (`acquia_cms_headless_ui.module`)

- `hook_user_login()` — default post-login `destination` to `<front>` unless already set (skips
  password-reset login).
- `hook_local_tasks_alter()` — rewrites entity `*.canonical` "View" tasks to the JSON:API view via
  `Menu\ViewJsonTask` (title "API"); regroups OAuth/consumer/role/token/content-type/media-type/
  block tasks under the new API and content-model base routes.
- `hook_menu_links_discovered_alter()` — collapses admin menu under `admin.cms`, moves the headless
  dashboard + OAuth settings under the API menu, drops theme menu items, injects icon background
  images.
- `hook_toolbar_alter()` — removes the Home item, attaches the `toolbar` library.
- `hook_entity_operation_alter()` — removes `manage-display`.
- `hook_ENTITY_TYPE_create()` (node_type) — disables submitted info, preview mode, menu settings.
- `hook_form_node_form_alter` / `hook_form_node_type_add_form_alter` / process callback — hide
  Promote, Sticky, display and preview-mode options; `hook_form_*_form_alter` for node/media/user
  use `Redirect::entityForm()` to send saves back to the list views.
- `Redirect` (`src/Redirect.php`) — maps a form id to a `*Form()` redirect handler (nodeForm →
  `view.content.page_1`, mediaForm → `view.media.media_page_list`, userForm →
  `view.user_admin_people.page_1`).
