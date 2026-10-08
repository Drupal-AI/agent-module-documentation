<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web Admin default recipe (`recipes/default/recipe.yml`)

`type: install`, name "Web Admin - Default". Applied by `webadmin_install()` when the module
is enabled standalone. This is the entire behaviour of the module — Web Admin has no PHP logic
beyond running this recipe.

## `install:` — modules enabled
Core admin tools: `announcements_feed`, `config`, `contextual`, `dblog`, `field_ui`, `help`,
`node`, `update`, `views_ui`, `toolbar`, `shortcut`, `content_moderation`, `workflows`,
`package_manager`.
Contrib tools: `automatic_updates`, `coffee`, `drupical`, `project_browser`, `sam`, `tagify`,
`tagify_user_list`, `view_password`, `views_bulk_operations`, `views_bulk_edit`, `masquerade`.
Themes: `claro`, `default_admin` (both core admin themes).
Last: `webadmin` itself (after its deps).

## `config.import:` — config entities pulled in
Recipes install modules in config-syncing mode, which does not create config *entities* from a
module's `config/install`. The recipe explicitly imports:
- `shortcut`: `shortcut.set.default` — so the toolbar's shortcuts have a set to display.
- `claro`: block config `block.block.claro_{breadcrumbs,content,help,local_actions,messages,page_title,primary_local_tasks,secondary_local_tasks}`.
- `default_admin`: the equivalent `block.block.default_admin_*` blocks.

Without these, the admin theme would render no local actions ("Add user", "Add workflow") or
local tasks. `config.strict: false`.

## `config.actions:` — configuration changes
- `system.theme` → `admin: default_admin` (Default Admin is the back-end/admin theme).
- `node.settings` → `use_admin_theme: true` (add/edit content in the admin theme).
- `user.settings` → `verify_mail: true`, `register: admin_only`, `cancel_method: user_cancel_block`.
- `?user.role.content_editor` (conditional — only if that role exists) → `grantPermissions:`
  `access contextual links`, `access toolbar`, `view the administration theme`. (Coffee search is
  intentionally left to site administrators, not granted here.)
- `announcements_feed.settings` → `limit: 2`.
- `core.menu.static_menu_link_overrides` → `overrideMenuLinks` disables `announcements_feed.announcement`.
- `automatic_updates.settings` → `allow_core_minor_updates: true`.
- `package_manager.settings` → `additional_trusted_composer_plugins: [cweagans/composer-patches, webship/patches]`
  (so Automatic Updates readiness checks pass for Webship's patch workflow).
- `drupical.settings` → `limit: 5`.
- `project_browser.admin_settings` → `allow_ui_install: true`, `max_selections: 1`.
- `tagify.settings` → `set_default_widget: true`.
- `update.settings` → `check.disabled_extensions: true`.

## Operating notes
- Install standalone: `drush pm:install webadmin` (or `drush recipe modules/contrib/webadmin/recipes/default`).
- Result: core Default Admin theme is the admin theme; toolbar, contextual links, Coffee, VBO/VBE,
  Masquerade, Tagify, Project Browser, Automatic Updates, Drupical are all live.
- Not installed here: Layout Builder, Navigation, dashboards — those live in the separate
  Web Dashboard recipe (`webdash` / `webdashboard`).
- The `?user.role.content_editor` grant is a no-op unless a `content_editor` role already exists
  when the recipe runs.

![Admin content listing under the Default Admin theme installed by Web Admin](../../../../../../../screenshots/webadmin/12.0.x/admin-content.png)
