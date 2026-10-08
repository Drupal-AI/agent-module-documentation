<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dialog render route + controller

## Route (`entity_dialog_formatter.routing.yml`)

- **`entity_dialog_formatter.dialog_renderer`**
  - path: `/entity-dialog-formatter/{type}/{view_mode}/{id}/{theme}/{title}`
  - `_controller`: `EntityDialogFormatterController::render`
  - `_title_callback`: `EntityDialogFormatterController::getTitle`
  - requirement: `_permission: 'render entity dialog'`

The formatter's links point here; core's `use-ajax` + `data-dialog-type` wrap the response in a
dialog. It is a normal HTML route, so it also works as a plain page.

## Permission (`entity_dialog_formatter.permissions.yml`)

- **`render entity dialog`** — "Render entity dialog": *Allows to use the renderer for the entity
  dialog formatter.* Grant to roles that should be able to open dialog content.

## Controller (`src/Controller/EntityDialogFormatterController.php`)

`EntityDialogFormatterController extends ControllerBase`, injects
`entity_type.manager` and `current_user` (via `create()`).

- `render(Request $request, $type, $view_mode, $id, $theme, $title)`:
  - `$storage = $this->entityTypeManager->getStorage($type)`;
  - `$ids = Json::decode($id)` then `$storage->loadMultiple($ids)`;
  - builds `['#theme' => $theme, '#entities' => []]`;
  - for each loaded entity, **only if `$entity->access('view', $this->currentUser)`**, appends
    `$view_builder->view($entity, $view_mode)` to `#entities`;
  - returns the build. Entities the current user cannot view are silently omitted.
- `getTitle(...)` — returns the `$title` path segment as the dialog/page title.

## Rendering the list

`#theme` defaults to the `entity_dialog_formatter_list` hook (from the formatter's `list_theme`
setting), declared in `entity_dialog_formatter_theme()` (`.module`) with an `entities` variable and
rendered by `templates/entity-dialog-formatter-list.html.twig`, which just loops and prints each
built entity.

## Access model (operational)

Two gates apply together: the route permission `render entity dialog`, **and** the per-entity
`access('view')` check inside `render()`. A role therefore needs both the permission and normal view
access to the target entities to see them in the dialog (as the README instructs). Referenced-entity
listing on the page likewise goes through core `getEntitiesToView()` in the formatter.
