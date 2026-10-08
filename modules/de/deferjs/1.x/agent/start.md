<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DeferJs (deferjs) — agent index

Adds the `defer` HTML attribute to a site's `<script>` tags to cut Total Blocking Time. When enabled,
`hook_page_attachments()` inlines the bundled `@shinsenter/defer.js@3.6.0` library (`js/defer.min.js`)
into `<head>` on **every** page, and `hook_js_alter()` sets `attributes['defer'] = TRUE` on Drupal's
aggregated/managed JS assets, subject to page/file/content-type filters read from config
`deferjs.settings`. Everything is driven by one admin settings form; there is no API, service, plugin
type, or permission of its own. The module is a no-op until an admin saves the form (no `config/install`
default, and `module_enable` defaults to unset/false).

- **Depends on:** nothing declared (info.yml has no `dependencies`); `hook_js_alter` reads node type via
  `node` route params but `node` is not a declared dependency.
- **Core:** `^9 || ^10 || ^11`. **Package:** `custom`. **PHP:** none declared.
- **Settings page:** `/admin/config/development/performance/deferjs` (route `deferjs.settings`, form
  `\Drupal\deferjs\Form\DeferJsForm`, gated by core permission `administer site configuration`).
- **Permissions:** none of its own (`deferjs.permissions.yml` is empty).
- **Config schema:** none (no `config/schema/` — config is stored schema-less).
- **Drush / services / plugin types / hook_update_N:** none.
- **Known quirks (functional, not security):** the info.yml `configure:` key names a route that does not
  exist (`deferjs.settings_form`) so the modules-page *Configure* link is dead; the `enabled_content_types`
  field acts as an **exclude** list, not include (see hooks doc); `deferjs.libraries.yml` declares a library
  pointing at `/js/defer.min.jss` (typo, double `s`) and is never attached anywhere.

## What you'd do → where
- Configure deferral, exclude pages/files/content types → `agent/configure/settings.md`
- Understand what actually gets deferred and when → `agent/hooks/asset-alter.md`

## Key facts (real machine names)
- **Route:** `deferjs.settings` → `/admin/config/development/performance/deferjs`, `_form:
  \Drupal\deferjs\Form\DeferJsForm`, `_permission: administer site configuration`, `_admin_route: TRUE`.
- **Form ID:** `deferjs_form` (extends `ConfigFormBase`).
- **Config object:** `deferjs.settings`. Keys: `module_enable` (bool), `enabled_content_types` (array of
  node-type ids — used as an exclude list), `exclude_page` (string, `\r\n`-separated path aliases),
  `exclude_file` (string, `\r\n`-separated JS paths, matched with a leading `/`).
- **Hooks:** `deferjs_help`, `deferjs_page_attachments`, `deferjs_js_alter` (all in `deferjs.module`).
- **Menu/local task:** `deferjs.settings` under `system.performance_settings` (`deferjs.links.menu.yml`,
  `deferjs.links.task.yml`).
- **Bundled asset:** `js/defer.min.js` = `@shinsenter/defer.js@3.6.0` (MIT), inlined verbatim; not loaded
  as a Drupal library.
- **info.yml `configure`:** `deferjs.settings_form` (nonexistent — real route is `deferjs.settings`).
