<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Dialog Formatter (entity_dialog_formatter) — agent index

An entity reference **field formatter** that renders each referenced entity as a `use-ajax` link
which opens the entity in **Drupal core's AJAX dialog** (modal / off-canvas). No third-party JS
library — uses `core/drupal.dialog.ajax`. Package `Fields`. Depends on core **`field`**. Core
`^10 || ^11`. License GPL-2.0-or-later. Version-dir 8.x-1.x (release `8.x-1.1-beta1`).

- **The formatter — id, settings, `viewElements()`, link building** →
  [fields/formatter.md](fields/formatter.md)
- **The dialog render route + controller, permission, access model** →
  [routes/dialog-renderer.md](routes/dialog-renderer.md)

## What it actually is

- One formatter plugin: `EntityReferenceEntityDialogFormatter` (id
  **`entity_reference_dialog_entity_view`**, label *"Dialog rendered entity"*), in
  `src/Plugin/Field/FieldFormatter/EntityReferenceEntityDialogFormatter.php`, extending core's
  `EntityReferenceEntityFormatter`. `field_types = { "entity_reference" }`.
- One route: **`entity_dialog_formatter.dialog_renderer`** →
  `EntityDialogFormatterController::render` (title callback `getTitle`), path
  `/entity-dialog-formatter/{type}/{view_mode}/{id}/{theme}/{title}`, requirement
  `_permission: 'render entity dialog'`.
- One permission: **`render entity dialog`** (`entity_dialog_formatter.permissions.yml`).
- One theme hook + template: `entity_dialog_formatter_list`
  (`templates/entity-dialog-formatter-list.html.twig`, loops `entities`), declared in
  `entity_dialog_formatter_theme()` in `.module`. `hook_help()` renders the README on the help page.
- **No** config entities, **no** config schema, **no** config/install, **no** services file,
  **no** composer.json, **no** Drush, **no** submodules.

## Mechanism (from source)

- Page render: `viewElements()` calls `getEntitiesToView()` (core access filtering), renders each
  entity in the `view_mode` setting, strips `<a>` tags from that markup (`filterLinksFromHtml()`),
  and wraps it in a `#type => link` to the `dialog_renderer` route with `class => use-ajax`,
  `data-dialog-type` and `data-dialog-options` (width/height JSON); attaches
  `core/drupal.dialog.ajax`.
- Dialog render: the controller loads the entity type `{type}`, JSON-decodes `{id}` (one id, or all
  ids when *display_all_dialog* is on), and renders each entity **only if
  `$entity->access('view')`** in the `{view_mode}` via the `{theme}` hook.
