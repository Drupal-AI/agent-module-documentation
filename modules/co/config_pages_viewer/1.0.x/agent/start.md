<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config page viewer (config_pages_viewer) — agent index

info.yml name **"Config page viewer"** (machine name `config_pages_viewer`, package `Custom`).
Installed version **1.0.4** (version dir `1.0.x`). Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.
Hard dependency: **`config_pages:config_pages`** (`drupal/config_pages ^2.2` in composer.json).

## Purpose (from source)

A tiny companion to the **Config Pages** module. Config Pages stores site-wide settings as a fielded
content entity that is normally only *edited* in admin, never *rendered*. This module adds a
front-end **view route + controller** so a Config Pages entity's rendered output (its field values
through the entity view pipeline) can be shown at a URL. The info.yml description notes it is a
stop-gap "waiting config_pages self managing this" (drupal.org issue 2950029).

## Architecture (complete — the whole module is 2 PHP classes + 1 hook)

- **`config_pages_viewer.routing.yml`** declares NO static routes; it points to a `route_callbacks`
  entry `ConfigPagesRoutes::routes`.
- **`src/Routing/ConfigPagesRoutes.php`** — `routes()` loads every `ConfigPagesType` and builds one
  dynamic route **per type**: path `/config_pages_viewer/{type_id}` (the type id is baked into the
  path, one route named `config_pages_viewer.{bundle}` each). Each route:
  - `_controller` → `ConfigPageViewerController::show`
  - `_title_callback` → `ConfigPageViewerController::getTitle`
  - default `config_pages` = the bundle id, upcast via param `type: entity:config_pages`
  - **`_entity_access: config_pages.view`** — access requirement (see below).
- **`src/Controller/ConfigPageViewerController.php`** extends core `EntityViewController`:
  - `show(?ConfigPages $config_pages)` — throws `NotFoundHttpException` if null; if the `metatag`
    module is present, refreshes `metatag_attachments` via `metatag_get_tags_from_route()`; then
    returns `$this->view($config_pages)` (core entity render array — field formatters, no raw markup).
  - `getTitle(?ConfigPages $config_pages)` — returns `$config_pages->get('label')->value` (plain
    string; escaped by the render/title system) or throws NotFound if null.
- **`config_pages_viewer.module`** — one hook: `hook_theme_suggestions_config_pages()` adds theme
  suggestions `config_pages__{view_mode}`, `config_pages__{type}`, and the combined form, for theming.

## Access model (delegated — the module defines NO permission of its own)

The view route's `_entity_access: config_pages.view` delegates to config_pages' own
`ConfigPagesAccessControlHandler`, whose `view` op requires the permission
**`view config_pages entity`** (all types) **or** the per-type **`view {bundle} config page entity`**
(provided by config_pages' permission callbacks). Grant those permissions to the roles that should
read a given config page's values.

## Facts for agents

- No settings form / `configure` link. No config schema. No `.install`. No services. No Drush.
- Provides no permissions and no plugin types of its own.
- One route per Config Pages *type*; the URL is `/config_pages_viewer/{type_machine_name}`.
- Minimally maintained (maintenance fixes only), security-advisory covered.

See `../usage.md` and `../human-docs/` for prose guides.
