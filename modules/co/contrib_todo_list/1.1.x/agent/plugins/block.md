<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block, template & JavaScript

## Block plugin
`src/Plugin/Block/ContribTodoListBlock.php`, id `contrib_todo_list_block`, admin label "Contrib todo list block", category "Blocks".

- Declares a **required node context** (`context_definitions` → `entity:node` "Current Node"), so the block only works where a node is in context (node pages / Layout Builder node display). Place it via Block layout with a node context.
- `blockAccess()` → `AccessResult::allowedIfHasPermission($account, 'manage todo list')`.
- `build()` — gets the node from context; returns render array `#theme => 'contrib_todo_list'` with `#todos` (from `TodoManagerService::getTodosByNode()`) and `#user_id`. Attaches library `contrib_todo_list/contrib_todo_list` and `drupalSettings.contrib_todo_list` = `{ nodeId, todos: [{id, pin}] }`.
- Uncacheable: `getCacheMaxAge()` returns 0; cache contexts `user.permissions`; cache tags `node:<id>`, `todo_list:node:<id>` (the latter is not invalidated anywhere in the module).

Theme hook registered in `contrib_todo_list_theme()` (`.module`): `contrib_todo_list` with variables `todos`, `user_id`, template `contrib-todo-list`.

## Template (`templates/contrib-todo-list.html.twig`)
Renders each todo as `.todo-item`: description (`{{ todo.todo.value }}` — Twig auto-escaped), a state dropdown built from `get_available_todo_state()`, delete action (owner only, `is_owner = todo.uid.value.0.target_id == user_id`), pin/go-to-pin icons, and a share toggle (owner only). Non-owners of a shared todo see the author name (`todo.uid.entity.accountname`). Also includes an add-todo form and inline SVG icons from `images/icons/`.

## Twig extension
`src/TwigExtension/ContribTodoListTwigExtension.php` (service `contrib_todo_list.twig.extension`, tagged `twig.extension`) exposes: `get_available_todo_state()`, `get_available_todo_state_keys()`, `get_available_todo_state_labels()`, `get_todo_state_key_by_label(label)` — all thin wrappers over `TodoState`.

## JavaScript (library `contrib_todo_list/contrib_todo_list`, version 1.x)
Assets: `js/contrib-todo-list.js`, `js/contrib-todo-select.js`, `js/manage-pin.js`, `js/admin-todo.js`, `css/contrib-todo-list.css`. Depends on core jQuery/drupal/drupalSettings/once/drupal.message.

- `contrib-todo-list.js` — `fetch()` calls to the JSON routes for add/state/share/delete. After add, it builds the new row with a template string and injects it with `insertAdjacentHTML` (client-side render of the just-created todo).
- `manage-pin.js` — "pin" mode: clicking `.add-pin` puts the page in selection mode, computes a CSS selector for the clicked element (`getElementPath`), rejects targets whose classes start with `todo-`/`form-`, and POSTs `{pin}` to `/todo/{todo}/pin`. On load, stored pins from `drupalSettings.contrib_todo_list.todos` are re-applied to matching elements (`document.querySelector(pin)`), dropping a 📌 marker.
- `contrib-todo-select.js` — custom state select widget on the block.
- `admin-todo.js` — wires the state/share filters on the `/admin/my-todos` listing (reads/writes query params). Note a hard-coded French label check (`Réinitialiser`) in the reset branch.

## Operate it
1. Enable the module (pulls in core `options`, `history`).
2. Grant `manage todo list` to the relevant roles.
3. Place "Contrib todo list block" in a region with a node context (or on the node display).
4. On a node page, permitted users add/state/share/pin/delete todos; use `/admin/my-todos` (link under Content) to review and filter your own.
