<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contribution Todo list (contrib_todo_list) — agent index

Per-node todo list. Defines a `todo` content entity and a node-context block that lets users with `manage todo list` create, state-track, share, pin, and delete todos attached to nodes. Installed 1.1.2; core `^10 || ^11`; package `Custom`.

## Dependencies
- Core modules: `options`, `history` (from `contrib_todo_list.info.yml`).
- JS libraries: `core/jquery`, `core/drupal`, `core/drupalSettings`, `core/once`, `core/drupal.message`.
- No composer requirements beyond core. No settings/config form (`configure` = null).

## What it provides
- Content entity `todo` (`src/Entity/Todo.php`) — base table `todo`; fields `nid` (node ref), `uid` (user ref), `todo` (text_long), `state` (list_string), `share` (boolean), `pin` (text_long), `langcode`. No entity access handler, no forms, no views data.
- Permission `manage todo list` (`restrict access: TRUE`) — gates every route and the block.
- Block plugin `contrib_todo_list_block` (`src/Plugin/Block/ContribTodoListBlock.php`) — needs a `node` context; theme hook `contrib_todo_list` → `templates/contrib-todo-list.html.twig`.
- Service `contrib_todo_list.todo_manager` (`src/Service/TodoManagerService.php`) — all todo CRUD + query logic.
- Twig extension `contrib_todo_list.twig.extension` (`src/TwigExtension/ContribTodoListTwigExtension.php`) — `get_available_todo_state()`, `..._keys()`, `..._labels()`, `get_todo_state_key_by_label()`.
- State value object `src/data/TodoState.php` — constants `pending` / `in-progress` / `completed` and label mapping.
- Config schema for the `todo` entity (`config/schema/contrib_todo_list.schema.yml`).
- Menu link `contrib_todo_list.todos` under `system.admin_content` → `/admin/my-todos`.
- French translation (`translations/contrib_todo_list.fr.po`; `hook_update_10001` seeds locale strings).

## Routes (all require `_permission: manage todo list`)
- `POST /todo/add` → `TodoController::add` (JSON; body `node_id`, `todo_text`).
- `POST /todo/{todo}/share` → `updateShare` (JSON `share`).
- `POST /todo/{todo}/state` → `updateState` (JSON `state`).
- `DELETE /todo/{todo}` → `deleteTodo` (JSON).
- `POST /todo/{todo}/pin` → `addPin` (JSON `pin`).
- `GET admin/todo/{todo}/delete` → `deleteTodoInAdmin` (redirect).
- `GET /admin/my-todos` → `listUserTodos` (render array table + filters).

## Solution docs
- [Todo entity & fields](entities/todo.md)
- [Todo manager service & JSON API](api/todo-api.md)
- [Block, template & JavaScript](plugins/block.md)
