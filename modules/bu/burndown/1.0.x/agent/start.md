<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Burndown (burndown) — agent index

Native Drupal **agile / Kanban project management**. Projects own Tasks, Columns (swimlanes) and
Sprints as entities; drag-and-drop boards, backlog, completed board, work logs, comments, task
relationships, watchlists, email notifications and burndown charts. Package `Burndown`, version
1.0.x, `^9 || ^10 || ^11`, GPL-2.0-or-later. Depends on core `datetime`, `field`, `image`, `link`,
`options`, `taxonomy`, `views`. No external services. Ships a submodule `burndown_time_tracker`.

## Solution docs

- **Entities, bundles, routes, blocks, hooks** → [entities/model.md](entities/model.md)
- **Permissions & the per-project permission model** → [config/permissions.md](config/permissions.md)
- **Global settings config object + schema** → [config/settings.md](config/settings.md)
- **AJAX / board API endpoints** → [api/endpoints.md](api/endpoints.md)
- **Drush commands** → [drush/commands.md](drush/commands.md)
- **Submodule: Time Tracker** → [../modules/burndown_time_tracker/1.0.x/agent/start.md](../modules/burndown_time_tracker/1.0.x/agent/start.md)

## What it provides (from source)

- **Content entities** (revisionable, translatable, fieldable): `burndown_project` (bundle
  `burndown_project_type`), `burndown_task` (bundle `burndown_task_type`), `burndown_sprint`
  (single bundle). **Config entities**: `burndown_swimlane` (per-project column), `default_swimlane`
  (template columns), plus the two bundle config entities. See `src/Entity/*`.
- **Project** is keyed by a short `shortcode` (e.g. `PROJ`) and a `board_type` of `kanban` or
  `sprint`; `Project::loadFromShortcode()` resolves URLs. Tasks get sequential `ticket_id`s from
  `TaskIdService` (`burndown_service.next_id`, transactional counter on the project row).
- **Controllers** (`src/Controller/`): `BacklogController`, `BoardController`, `CompletedController`,
  `TaskController`, `SwimlaneController`, `ProjectController`, `SprintController` — render the
  backlog/board/completed pages and serve the drag-drop/comment/relationship AJAX API.
- **Services** (`burndown.services.yml`): `burndown_service.next_id` (TaskIdService),
  `burndown_service.project_cloud` (ProjectCloudService), `burndown_service.change_diff_service`
  (ChangeDiffService); event subscribers `TaskNotificationsSubscriber` (emails) and
  `MyTasksRouteSubscriber`.
- **Events** (`src/Event/`): `TaskCreatedEvent::ADDED`, `TaskCommentEvent::COMMENTED`,
  `TaskWorkEvent::WORKED`, `TaskChangedEvent::CHANGED`, `TaskClosedEvent::CLOSED`.
- **Field plugins** (`src/Plugin/Field/`): field types `burndown_log`, `burndown_task_relationship`
  with matching widgets/formatters. **Validation constraint** `ShortcodeUnique`. **Blocks**
  `burndown_project_cloud_block`, `burndown_project_nav_block`.
- **Access handlers**: `TaskAccessControlHandler`, `ProjectAccessControlHandler`,
  `SprintAccessControlHandler`, `SwimlaneAccessControlHandler` (standard entity access honoring the
  per-project permissions from `ProjectPermissions`/`TaskPermissions`).
- **Drush**: `BurndownDrushCommands` (`drush.services.yml`) — ~20 `burndown:*` commands.
- **Config schema**: `config/schema/*` for the settings object and the config entities. Default
  install config: 6 `default_swimlane` templates (backlog, todo, in_progress, testing, completed,
  deployed), a project type, a task type, and views `my_tasks` / `burndown_task_by_ticket_id`.
