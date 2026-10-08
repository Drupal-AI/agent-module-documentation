<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Burndown — permissions & per-project access model

Defined in `burndown.permissions.yml` plus dynamic callbacks
`ProjectPermissions::generatePermissions()` and `TaskPermissions::generatePermissions()`.

## Static, site-wide permissions

- `administer burndown` (restricted) — full admin; used by the swimlane-reorder pages/API and as a
  master grant in task-log edit access.
- `access burndown` — reach the Burndown dashboard.
- `access burndown backlog`, `access burndown board`, `access completed board` — view those boards.
- `reorder burndown backlog` — drag/reorder tasks (backlog + board reorder API).
- `send tasks to board`, `send tasks to backlog` — move a task between backlog and board.
- `modify sprint tasks` — move tasks between sprints.
- `burndown open sprint` — open/close sprints.
- `burndown close task` — close/reopen tasks.
- `burndown comment on task` — add comments / work-log entries (and edit one's own log entries).
- Standard entity CRUD perms per type: `add|edit|delete|administer|view (un)published … entities`
  and revision perms for project/task/swimlane/sprint (restricted variants marked so).

## Dynamic per-project permissions

For every existing Project, `ProjectPermissions` generates a set keyed by the project entity id
`{id}`: `"{id} view project"`, `"{id} create entities"`, `"{id} edit own entities"`,
`"{id} edit any entities"`, `"{id} delete own entities"`, `"{id} delete any entities"`, plus
`{id} view/revert/delete revisions`. `TaskPermissions` generates the analogous per-task-type set.

This lets you scope a role to a single project: the page/view routes accept the general permission
**OR** the project-specific `"{id} view project"` (see `BacklogController::checkAccess`,
`BoardController::checkAccess`, and the entity access handlers `TaskAccessControlHandler` /
`ProjectAccessControlHandler`, which also honor `%bundle edit own entities`-style ownership perms).

## Access handlers

`TaskAccessControlHandler` / `ProjectAccessControlHandler` implement standard `view/update/delete`
entity access: own-permission first (`checkOwn()` compares `getOwnerId()` to the current user and
checks `%bundle {op} own entities`), then the broad `view published … entities` /
`{project_id} view project` (view) or `edit|delete … entities` (mutations). `checkCreateAccess`
requires `add task|project entities`. Swimlane and Sprint have their own handlers.

## Operating notes

- After creating a Project, revisit the permissions page — new `"{id} …"` permissions appear per
  project and per task type, so per-project roles must be re-granted when projects are added.
- The board/backlog/completed **page** routes correctly accept the per-project view permission; grant
  `"{id} view project"` (not the site-wide `access burndown board`) to limit a role to one project's
  boards.
