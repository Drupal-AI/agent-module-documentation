<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Community Tasks — agent index

info.yml name: **Community Tasks** (`community_tasks`), version **2.0.0-beta3** (beta), core `^9 || ^10 || ^11`.
Depends on core `comment`, `datetime`, `options`, `text`, `views`. No config UI / settings form; no Drush;
no services beyond a migration event subscriber. License GPL-2.0-or-later.

A volunteer-coordination feature built entirely on a **node type**. The module installs a `community_task`
content type with a three-state workflow and surfaces per-user activity on the user profile. There is no custom
entity, controller, or route — all state changes go through **embedded forms rendered inside the node view**.

## What it installs

- **Node type** `community_task` (config `node.type.community_task`). Fields: `title`, `body` (relabelled
  "Details", added in `hook_install()` reusing existing `body` storage), `ctask_date` (datetime), `node_comments`
  (core comment field, added in `hook_install()`), and `ctask_state`.
- **`ctask_state`** — a required `list_string` field (`config/install/field.storage.node.ctask_state.yml`) with
  allowed values `open` / `committed` / `completed`, default `open`. **Hidden on the node edit form**
  (`hidden: ctask_state: true` in the form display) — it is never editable via the node form; it changes only
  through the workflow forms below. On the node view it is rendered by the custom **`ctask_state` formatter**
  (`src/Plugin/Field/FieldFormatter/CTaskStateFormatter.php`).
- **`uid`** (node author) is repurposed as the **"Responsible person"** — relabelled by
  `community_tasks_form_node_community_task_edit_form_alter()`. Whoever commits becomes the owner.
- **Views** `community_tasks` (`config/install/views.view.community_tasks.yml`): page `page_1` at path
  `/community-tasks` ("All tasks", auth-only access), block `block_1` ("Can you volunteer?", open tasks), plus a
  `my_community_tasks` view is referenced by the profile embed (see below). An "Add task" action link points at
  the tasks page (`community_tasks.links.action.yml`).

## Workflow (the core mechanism)

The transition UI is the **`community_task_state` render element** (`src/Element/TaskState.php`,
`@FormElement("community_task_state")`). Its `preRender()` loads the node, prints a state description, and — via
`getFormClass()` — embeds exactly one context-sensitive transition form (`\Drupal::formBuilder()->getForm($class, $node)`):

| Current state | Who sees a form | Form | Effect |
|---|---|---|---|
| `open` | user with permission `commit to tasks` | `CommitToTask` | sets owner = current user, state → `committed` |
| `committed` | the **owner** (`owner_uid == current uid`) | `UncommitToTask` | state → `open` |
| `committed` | user with permission `edit any community_task content` | `SignTask` | state → `completed`; owner keeps credit |
| `completed` | — | none | terminal |

- All three forms extend `CTaskActionBaseForm` (`src/Form/`). The base `submitForm()` sets `ctask_state`, invalidates
  the owner's user cache tag, and dispatches a `GenericEvent` on `community_tasks.<committotask|signtask|uncommittotask>`
  (extension point for other modules).
- Gating (`permission` + owner check) lives in `getFormClass()` and re-runs on every request/POST, since the form is
  rebuilt through the node render path. Forms are standard Form API forms (CSRF token enforced by core). There are
  **no module-defined routes** and no `_access` declarations.

## Profile integration

`community_tasks_user_view()` (in `.module`) adds two extra display components (`hook_entity_extra_field_info`),
shown when enabled on the user view display:
- **`community_tasks_completed`** — an entity query counting nodes of type `community_task` owned by the account with
  `ctask_state == completed`, themed via `community-tasks-completed.html.twig` ("N tasks completed.").
- **`community_tasks_committed`** — embeds the `my_community_tasks` view (display `embed_1`) with the uid as argument.

## Migration

D7 → D8+ support: `MigrationSubscriber` (`migrate.pre_row_save`) derives `ctask_state` from the legacy row
(uid==1 → open, promote → completed, else committed); `hook_migrate_prepare_row` hooks fix the menu path and skip a
duplicate node-type row. Config `migrations/state/community_tasks.migrate_drupal.yml`.

## Key facts / caveats (beta)

- Permission `commit to tasks` is declared in **`community_tasks.permission.yml`** — note the **non-standard filename**
  (Drupal discovers `MODULE.permissions.yml`), so as shipped this permission is **not registered**; the only
  workflow-relevant permission that resolves is core's node grant `edit any community_task content`. Grant task
  creation/editing via the usual `create/edit/delete community_task content` node permissions.
- `action_button` appears as a component in the form and view displays but corresponds to no field/formatter — dead config.
- `CommitToTask::submitForm()` and `UncommitToTask::submitForm()` reference undefined `$node`/`$nid` in their
  post-save redirect/log lines; the state/owner save happens first. `UncommitToTask` does not reset the owner despite
  its docblock.
- No `usage.md`-facing settings form; configuration is permissions + Views + the user view display.

See `../usage.md` and `../human-docs/` for prose/manual guidance.
