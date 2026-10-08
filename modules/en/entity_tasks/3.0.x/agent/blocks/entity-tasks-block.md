<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity tasks block

Block plugin that shows the current page's local task tabs anywhere you place a block.

## Plugin

- Class `EntityTasksBlock` — `src/Plugin/Block/EntityTasksBlock.php`, extends `BlockBase`,
  implements `ContainerFactoryPluginInterface`.
- Annotation: `id = "entity_tasks_block"`, `admin_label = "Entity tasks block"`.
- Injected services (`create()`): `plugin.manager.menu.local_task` (`LocalTaskManager`),
  `current_route_match`, `current_user`, `extension.list.module`.

## build()

1. Returns `NULL` unless `currentUser->hasPermission('access entity tasks')`.
2. `$localTasks = localTasksManager->getLocalTasks(currentRouteMatch->getRouteName(), 0)` — level-0
   local tasks for the matched route (these are core's own tabs, each with an `#access` result and a
   `#link`).
3. Builds a render array:
   - `#theme => 'entity_tasks_block'` (base id), `#content => $localTasks['tabs']`,
     `#left => (bool) tasks_left` block setting.
   - `#attached` library `entity_tasks/block`, plus `drupalSettings` containing the **inlined SVG**
     for known task types read from `images/*.svg` via `file_get_contents()` (keys
     `entity-tasks-view|add|translations|edit|webform|delete|webform-results|shortcuts`). The paths
     come from `ExtensionList::getPath('entity_tasks')` — not from user input.
   - `#cache` contexts: `user.roles`, `url`, `languages`.

Because `#content` is the raw core tabs array, each tab keeps its own `#access` and is filtered by
the renderer; the block adds no operations of its own.

## Block settings

- `blockForm()` adds one checkbox **`tasks_left`** ("Place tasks left"); `blockSubmit()` stores it
  via `setConfigurationValue('tasks_left', …)`.
- `defaultConfiguration()` sets `label_display => FALSE` (block title hidden by default).

## Template & JS

- `templates/entity-tasks-block.html.twig`: `<nav class="entity-tasks[ entity-tasks--left]">…{{ content }}…</nav>`,
  rendered only `{% if content %}`. Twig autoescapes.
- `js/entity-tasks.tabs-block.js` (`window.EntityTasks.TabControl`): on DOM ready moves the
  container to end of `<body>`, reads the left/right flag from the `entity-tasks--left` class, and
  injects the matching SVG icon per link by matching `a[href*="<type>"]` for the type list
  `view, shortcuts, add, edit, translations, webform, webform-results, delete`.

## Placement

Admin → Structure → Block layout (`/admin/structure/block`), add **Entity tasks block** to a region
(README suggests the content region). Toggle "Place tasks left" in the block config to pin it left;
default is right, fixed position.
