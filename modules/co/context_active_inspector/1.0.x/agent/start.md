<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Context Active Inspector (context_active_inspector) — agent index

Adds an admin **Toolbar** tray listing the [Context](https://www.drupal.org/project/context) contexts active on the
current page (debug conditions/reactions). No routes, no controllers, no config form, no config objects.

- **Version:** 1.0.2 (version-dir `1.0.x`). Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Package: Administration.
- **Dependencies (info.yml):** `drupal:toolbar`, `drupal:context`. Composer also requires `drupal/context:^5.0@RC`.
  Soft dependency: uses `context_ui` (if enabled) to link each context to its edit form.
- **Permission:** `access context active inspector` (`*.permissions.yml`) — gates the entire toolbar item.
- **Provides:** one permission; a toolbar item; a CSS library `context_active_inspector/toolbar`; a hook group
  `context_active_inspector_commands` (via `hook_hook_info`, not invoked by this module).
- **No** Drush commands, plugins, entities, services, or config schema.

## How it works (`context_active_inspector.module`)

- `context_active_inspector_toolbar()` — `hook_toolbar`. Returns early (cache context `user.permissions`) unless the
  current user has `access context active inspector`; otherwise builds a `toolbar_item` whose tray is an `item_list`
  of active contexts and attaches the `toolbar` library.
- `context_active_get_context_list()` — calls `\Drupal::service('context.manager')->getActiveContexts()` and builds a
  link per context; link target is the context edit URL when `context_ui` exists, else `<nolink>`.
- `context_active_inspector_hook_info()` — declares the `context_active_inspector_commands` hook group.

## Solution docs

- [agent/api/toolbar.md](api/toolbar.md) — install/enable, the permission, the two functions, the library, extension point.
