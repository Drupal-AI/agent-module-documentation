<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Design System (design_system) — agent index

Thin admin-UI convenience module. Adds a "Design System" link to the admin menu/toolbar that
opens a single administrator-configured URL (default `internal:/storybook/`) inside an iframe on
an admin page. No entities, plugins, services, or Drush commands.

- Version dir: `1.0.x` (installed 1.0.2). Package: User interface.
- Requires: `drupal:toolbar`. Core `^9.5 || ^10 || ^11`. PHP 8.0.
- Optional integration: `gin_toolbar` (extra icon CSS when Gin toolbar is active).

## Routes
- `design_system.settings` → `/admin/config/user-interface/settings`, `_form`
  `DesignSystemSettingsForm`; requires `administer site configuration`.
- `design_system.design_system` → `/admin/design-system`, `_controller`
  `DesignSystemController::displayDesignSystem`; requires `access design system`; `_admin_route: TRUE`.

## Permissions
- `access design system` — view the embedded design-system page.
- (URL editing is gated by core's `administer site configuration`.)

## Config
- `design_system.settings` config object, one key: `design_system_url` (string; schema
  `config/schema/design_system.schema.yml`; default `internal:/storybook/` from
  `config/install/design_system.settings.yml`).

## Menu links (`design_system.links.menu.yml`)
- `design_system.design_system_settings_form` (settings, under `system.admin_config_ui`).
- `design_system.admin_design_system` (view page, under `system.admin`, class `design-system`).

## Libraries & hook
- `design_system/admin_toolbar_icon`, `design_system/gin_admin_toolbar_icon`
  (`design_system.libraries.yml`).
- `hook_page_attachments()` in `design_system.module` attaches the toolbar-icon library on every
  page; adds the Gin variant when `gin_toolbar` is enabled and `_gin_toolbar_gin_is_active()`.

## Solution docs
- Configuration: [`agent/config/settings.md`](config/settings.md)
- Display route / controller: [`agent/routes/display.md`](routes/display.md)
