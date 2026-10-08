<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Burndown — AJAX / board API

These endpoints back the drag-and-drop boards and the task detail UI. All are internal Drupal routes
(`burndown.routing.yml`), consumed by the module's JS (`js/burndown.backlog.js`, `burndown.board.js`,
`burndown.task_edit.js`); each returns a `JsonResponse` or rendered partial. Route parameters accept
a **ticket id** (e.g. `WEB-42`) and resolve via `Task::loadFromTicketId()`.

## Backlog (`BacklogController`)

- `POST /burndown/api/backlog_reorder` — `reorderBacklog()`, perm `reorder burndown backlog`. Body
  `sort[]` = ordered ticket ids; sets each task's `backlog_sort`.
- `GET /burndown/api/backlog/send_to_board/{ticket_id}` — `sendToBoard()`, perm `send tasks to board`.
  Moves a task into the project's To-Do column.
- `GET /burndown/api/backlog/sprint_status/{shortcode}` — `sprintStatus()`, perm
  `access burndown backlog`. Returns sprint list + open/close flags.
- `POST /burndown/api/change_sprint` — `changeSprint()`, perm `modify sprint tasks`. Body `task_id`,
  `from_sprint`, `to_sprint`; validates all three belong to the same project.
- `POST /burndown/api/open_sprint` — `openSprint()`, perm `burndown open sprint`. Body `id`.

## Board (`BoardController`)

- `POST /burndown/api/change_swimlane` — `changeSwimlane()`, perm `access burndown board`. Body
  `task_id`, `from_swimlane`, `to_swimlane`; validates same-project and that the task is currently in
  `from_swimlane` before moving it.
- `POST /burndown/api/board_reorder` — `reorderBoard()`, perm `reorder burndown backlog`. Body
  `sort[swimlane_id][]`; sets `board_sort`.
- `GET /burndown/api/board/send_to_backlog/{ticket_id}` — `sendToBacklog()`, perm
  `send tasks to backlog`.

## Swimlanes (`SwimlaneController`)

- `POST /burndown/api/swimlane_reorder` — `reorderBoard()`, perm `administer burndown`. Reorders the
  project's columns (`setSortOrder`).

## Task (`TaskController`)

Custom access callbacks in `TaskController` gate these:
`checkTaskViewAccess` (broad view perms OR `{project} view project`),
`checkTaskAddAccess`, `checkTaskEditAccess` (edit/delete/`modify sprint tasks` perms; falls back to
`from_ticket_id` in the POST body), and `checkTaskLogEditApiAccess` (`administer burndown` OR
`burndown comment on task`).

- `GET  /burndown/api/task_log/{ticket_id}/{type}` — `getTaskLog()` (`checkTaskViewAccess`). Renders
  the work/comment log; each item gets a `can_edit` flag from `canEditTaskLogItem()` (admin, or the
  entry's own author with `burndown comment on task`).
- `POST /burndown/api/task/add_comment` — `addComment()`, perm `burndown comment on task`. Comment is
  `Xss::filter()`-ed, appended to the `log`, dispatches `TaskCommentEvent`.
- `POST /burndown/api/task/add_work` — `addWork()`, perm `burndown comment on task`. Validates `work`
  numeric and `work_increment` in `[m,h,d,w,M,Y]`; dispatches `TaskWorkEvent`.
- `POST /burndown/api/task/edit_log` — `editLog()` (`checkTaskLogEditApiAccess`), then re-checks
  `canEditTaskLogItem()` per entry so a non-admin may only edit their own comment/work entry.
- `GET  /burndown/api/task/add_to_watchlist/{ticket_id}/{user_id}` and `.../remove_from_watchlist/…`
  — (`checkTaskEditAccess`).
- `GET  /burndown/api/task/get_relationships/{ticket_id}` — (`checkTaskEditAccess`), rendered partial.
- `POST /burndown/api/task/add_relationship` — (`checkTaskEditAccess`). Body `from_ticket_id`,
  `to_ticket_id`, `type`; rejects self-relations, duplicates, and unknown types
  (`Task::relationshipTypeExists`).
- `GET  /burndown/api/task/remove_relationship/{from_ticket_id}/{to_ticket_id}` —
  (`checkTaskEditAccess`).
- `GET  /burndown/task_add_multi_bundle/{shortcode}` and `/burndown/add-task/{shortcode}` —
  bundle-select + redirect to the task add form (`checkTaskAddAccess`).

Notes for integrators: the move/reorder/comment endpoints authorize on the site-wide permission
named above, while the board/backlog/completed **page** routes additionally accept the per-project
`"{id} view project"` permission. Grant the per-project `"{id} …"` permissions to scope which
projects a role can see, and grant the site-wide board/backlog/comment/reorder permissions to roles
you intend to act across projects. Prefer the Drush commands
(see [../drush/commands.md](../drush/commands.md)) for scripted/headless changes.
