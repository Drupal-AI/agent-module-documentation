<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Local Tasks (betterlt) — agent index

Restyles Drupal's **local task tabs** (the View / Edit / Delete / Revisions / Translate tab
strip) into a fixed, icon-based slide-out panel. Purely presentational: no routes, forms,
services, entities, or stored config. Machine name **`better_local_tasks`** (project `betterlt`),
this doc covers the legacy **1.x** branch = release **8.x-1.4**, core `^8 || ^9`.

No dependencies. No settings page (`configure` = null). No permissions defined. No drush, no
plugins, no config schema. Everything is done by three hooks in `better_local_tasks.module`
plus a CSS library and two Twig template overrides.

Two important gates (both in the `.module`): the styling is applied **only on non-admin routes**
and **only to users who hold the core `access contextual links` permission** — anonymous users
and admin-theme pages are unaffected.

- **How it restyles the tabs / how to theme it / turn it off** → [theme/local-tasks.md](theme/local-tasks.md)

## Key facts

- Library: `better_local_tasks/local-tasks` (attaches `css/local_tasks.css`, no JS, no deps).
- Hooks implemented: `hook_page_attachments_alter`, `hook_preprocess_menu_local_task`,
  `hook_theme_registry_alter`.
- Template hooks overridden (non-admin routes only): `block__local_tasks_block`
  (`templates/block/block--local-tasks-block.html.twig`) and `menu_local_tasks`
  (`templates/navigation/menu-local-tasks.html.twig`).
- CSS wrapper class added by the templates: `blt-tabs` (on `nav`/`ul`).
- Gate permission (core, not defined here): `access contextual links`.
- Semantic per-tab classes: `view`, `edit`, `delete`, `revisions`, `devel`, `translate`,
  `shortcuts` (+ `managedisplay`, `newdraft`, `clone` icons referenced in CSS).
