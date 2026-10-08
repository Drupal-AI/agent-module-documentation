<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin Toolbar Entity Version (admin_toolbar_entity_version) — agent index

Adds a **Toolbar tab** showing the **revision/version status** of the entity currently being viewed
(canonical / latest / revision routes), with per-version status, "created … ago" and View links, plus a
version-history link. Package `Administration`. Depends only on core **`toolbar`** (integrates optionally
with **`content_moderation`**). Core `^9.3 || ^10 || ^11`. PHP `>=7.4`. License GPL-2.0-or-later.
Version dir `1.0.x` (release 1.0.3).

- **The `hook_toolbar` lazy builder, the version inspector, the template and the local-task hide** →
  [services/toolbar.md](services/toolbar.md)

## What it actually is

- **No routes, no permissions, no config, no schema, no Drush, no plugins.** Procedural hooks in
  `.module` + two service-ish classes + one theme + one CSS library.
- `hook_toolbar()` — registers a `tab` `entity_version` whose content is a **`#lazy_builder`** calling
  `AdminToolbarEntityVersionBuilder::build` (with `#create_placeholder`), weight 1010, wrapper class
  `admin-toolbar-entity-version-tab`, attaching library `admin_toolbar_entity_version/toolbar.item`
  (`css/admin-toolbar-entity-version.css`).
- `hook_theme()` — theme `admin_toolbar_entity_version` (vars `current_version`, `versions`,
  `version_history_url`), template `templates/admin-toolbar-entity-version.html.twig` (a `<details>` drawer).
- `hook_menu_local_tasks_alter()` — on `entity.node.canonical` / `entity.node.latest_version`, removes the
  core `content_moderation.workflows:node.latest_version_tab` local task **only** on front-end renders
  (kept when the user lacks *access toolbar*, on admin routes, or when the active theme is the admin theme).

## Provided classes

- `AdminToolbarEntityVersionBuilder` (`src/`, `ContainerInjectionInterface` + `TrustedCallbackInterface`;
  `create()`/DI, not a declared service). `build()` resolves the route entity (regex on
  `entity.*.canonical|latest_version|revision`), then returns the `admin_toolbar_entity_version` render
  array with `#current_version`, `#versions`, `#version_history_url` (the last **access-checked** via
  `Url::access()`).
- `EntityVersionInspector` (`src/`, service `admin_toolbar_entity_version.inspector`, injects
  `@entity.repository`, `@?content_moderation.moderation_information`, `@date.formatter`). Computes the
  current-version key (default/latest/revision) and builds the Canonical / Latest revision / Old revision
  entries with label, url, published flag, status, created + "time ago".

## Notes (from source)

- Status label = moderation-state label when the entity is moderated (Content Moderation present), else
  `Published`/`Unpublished` for `EntityPublishedInterface`, else Revision/Latest fallbacks.
- All version labels/status/timestamps render through Twig (autoescaped); URLs are core `Url` objects.
