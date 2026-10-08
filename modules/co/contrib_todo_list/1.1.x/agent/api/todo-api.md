<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Todo manager service & JSON API

Service `contrib_todo_list.todo_manager` = `src/Service/TodoManagerService.php`
(args: `entity_type.manager`, `current_user`, `language_manager`, `logger.factory`).
Controller `src/Controller/TodoController.php`. Routes in `contrib_todo_list.routing.yml`.

## Permission
Everything is gated by the single permission **`manage todo list`** (`restrict access: TRUE`, `contrib_todo_list.permissions.yml`). There is no per-role or admin permission beyond this, and no entity-level access handler.

## Routes → controller methods
| Route | Path | Method | Controller |
|-------|------|--------|-----------|
| `contrib_todo_list.todo_add` | `/todo/add` | POST | `add()` |
| `contrib_todo_list.todo_update_share` | `/todo/{todo}/share` | POST | `updateShare()` |
| `contrib_todo_list.todo_update_state` | `/todo/{todo}/state` | POST | `updateState()` |
| `contrib_todo_list.todo_delete` | `/todo/{todo}` | DELETE | `deleteTodo()` |
| `contrib_todo_list.todo_add_pin` | `/todo/{todo}/pin` | POST | `addPin()` |
| `contrib_todo_list.admin_todo_delete` | `admin/todo/{todo}/delete` | GET | `deleteTodoInAdmin()` |
| `contrib_todo_list.view_my_todos` | `/admin/my-todos` | GET | `listUserTodos()` |

`{todo}` is upcast to a `Todo` entity by id. All JSON endpoints read the body with `json_decode($request->getContent(), TRUE)` and return a `JsonResponse`.

## Controller behaviour
- `add()` — requires `node_id` + `todo_text` in the body; loads the node (400 if not a `NodeInterface`); calls `createTodo()`; returns `{message, todo_id, text}` (echoes the submitted text).
- `updateShare()` — requires `share`; casts to bool; `updateTodoShare()`.
- `updateState()` — requires `state` (a key); `updateTodoState()`.
- `deleteTodo()` — `deleteTodo()`; JSON result.
- `addPin()` — requires `pin`; `addPin()`.
- `deleteTodoInAdmin()` — deletes then redirects to `view_my_todos` with a status message.
- `listUserTodos()` — renders a `#type=table` of the current user's todos with state/share exposed filters (query params `state`, `share`); each row links to the node and a delete operation (the GET `admin_todo_delete` route). Attaches the `contrib_todo_list/contrib_todo_list` library.

## Service methods (`TodoManagerService`)
- `getTodosByNode(NodeInterface)` — todos for the node in the current language where `uid == currentUser` **OR** `share == TRUE` (an `orConditionGroup`); `accessCheck(false)`. Feeds the block.
- `getUserTodos(?state, ?share)` — todos where `uid == currentUser`, optionally filtered by state label / share; `accessCheck(false)`.
- `createTodo(NodeInterface, string $todoText)` — creates a todo owned by the current user, langcode = current language, state = Pending, share = FALSE; logs and returns null on exception.
- `updateTodoShare(Todo, bool)` — sets `share`, saves.
- `updateTodoState(Todo, string $key)` — validates key against `TodoState::getStateKeys()`, stores the mapped label, saves.
- `addPin(Todo, string $pin)` — sets the `pin` selector, saves.
- `deleteTodo(Todo)` — deletes only if the todo's `uid` matches the current user, else returns false.
- `getNodeUrlByTodo(Todo)` — absolute URL of the referenced node (translated to current language).
