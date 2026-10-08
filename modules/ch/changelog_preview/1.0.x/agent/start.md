<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Changelog Preview (changelog_preview) — agent index

Renders one or more admin-configured Markdown CHANGELOG files as HTML pages inside Drupal. An admin
lists "changelog items" (file path + display name + browser URL) on a settings form; the module
registers a dynamic route per item, reads the file from disk, converts Markdown→HTML with
`michelf/php-markdown`, and outputs it. Version 1.0.0, core `^9 || ^10 || ^11`.

## Dependencies
- No Drupal module dependencies.
- Composer: `michelf/php-markdown ^2.0`, `symfony/routing ^7.1` (installed automatically).
- Ships one CSS asset library, `changelog_preview/code-element.styling`.

## What it provides
- **Permission** (`changelog_preview.permissions.yml`): `view changelog`.
  Managing config uses core `administer site configuration`.
- **Config object**: `changelog_preview.changelog_manage_form` (no config schema shipped).
- **Static routes** (`changelog_preview.routing.yml`):
  - `changelog_preview.changelog_manage_form` — `/admin/changelog_manage`, settings form.
  - `changelog_preview.object` — `/changelog/base`, lists configured changelogs.
  - `route_callbacks` → `ChangelogPreviewRoutes::routes` for the dynamic per-item routes.
- **Dynamic routes**: `changelog.<i>` at each item's configured browser path (permission `view changelog`).
- **Controller**: `ChangelogPreviewController` (`content()`, `listChangelogs()`).
- **Form**: `ChangelogManageForm` (repeatable items, AJAX "add another").
- **Route callback**: `Routing\ChangelogPreviewRoutes`.
- **Local-task deriver**: `Plugin\Derivative\DynamicLocalTasks`.
- **Hooks** (`changelog_preview.module`): `hook_toolbar`, `hook_page_attachments`, plus a
  (misnamed, non-firing) `changelog_preview_menu_link`.

## Solution docs
- Config + operation: [agent/config/settings.md](config/settings.md)
- Routes, controller, hooks: [agent/api/routes-controller.md](api/routes-controller.md)
