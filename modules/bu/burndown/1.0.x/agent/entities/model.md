<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Burndown — entities, routes, blocks, hooks

## Entities (`src/Entity/`)

Content entities (revisionable + translatable, `base_table` = the id):

- **`burndown_project`** (`Project.php`) — a project. Bundle: config entity `burndown_project_type`.
  Base fields: `name`, `shortcode` (unique short code, e.g. `WEB`; validated by `ShortcodeUnique`),
  `board_type` (`kanban`|`sprint`), `estimate_type` (tshirt|geometric|dot), `ticket_id` (the running
  per-project ticket counter), `status`, `user_id`, `created`, `changed`.
  `Project::loadFromShortcode($code)` resolves a project from a URL shortcode.
- **`burndown_task`** (`Task.php`) — a task/ticket. Bundle: config entity `burndown_task_type`.
  Base fields: `name`, `description` (text_long), `ticket_id` (`WEB-42`-style), `project` (ref),
  `swimlane` (current column), `sprint` (ref, nullable), `assigned_to`, `watch_list`, `estimate`,
  `priority`, `status`, `completed`, `resolution`, `backlog_sort`, `board_sort`, `tags` (taxonomy),
  `link`, `images`, `log` (a `burndown_log` field — the work/comment log), `relationships` (a
  `burndown_task_relationship` field), `user_id`. `Task::loadFromTicketId()` resolves by ticket id;
  static query helpers `getBacklogTasks()`, `getTasksForSwimlane()`, `getTasksForBacklogSprint()`.
- **`burndown_sprint`** (`Sprint.php`) — a sprint. Fields: `name`, `project`, `start_date`,
  `end_date`, `status` (`new`|`started`|`completed`), `sort_order`. `Sprint::getCurrentSprintFor()`,
  `getBacklogSprintsFor()`; `startSprint()` / close logic.

Config entities: **`burndown_swimlane`** (`Swimlane.php`, a per-project board column with flags
`show_backlog`, `show_project_board`, `show_completed`, plus sort), **`default_swimlane`**
(`DefaultSwimlane.php`, template columns copied into a new project — 6 shipped in
`config/install/burndown.default_swimlane.*`), and the two bundle types `burndown_project_type` /
`burndown_task_type`.

`burndown_burndown_project_insert()` (in `burndown.module`) seeds a new project's columns from the
`default_swimlane` templates and creates the backlog/board/completed swimlanes.

## Routes (`burndown.routing.yml`)

Page routes (per-project, custom access = general perm OR `{project_id} view project`):

- `/burndown` dashboard, `/burndown/project` project list (`administer project entities`).
- `/burndown/backlog/{shortcode}` → `BacklogController::getBacklog` (`checkAccess`).
- `/burndown/board/{shortcode}` → `BoardController::getBoard` (`checkAccess`).
- `/burndown/completed/{shortcode}` → `CompletedController::getCompleted`.
- `/burndown/close_task/{ticket_id}/{board}` (form, `burndown close task`),
  `/burndown/reopen_task/{ticket_id}` (`burndown close task`),
  `/burndown/close_sprint/{sprint_id}` (`burndown open sprint`).
- `/burndown/reorder_swimlanes/{shortcode}` (`administer burndown`).
- Standard entity canonical/add/edit/delete/revision routes via the `*HtmlRouteProvider` classes.
- Config: `/admin/config/burndown/settings` → `SettingsForm` (`administer site configuration`);
  `/admin/structure/burndown` (`administer burndown`).

The AJAX/API routes under `/burndown/api/*` are documented in [../api/endpoints.md](../api/endpoints.md).

## Blocks (`src/Plugin/Block/`)

- **`burndown_project_cloud_block`** (`ProjectCloudBlock`) — the "Projects" cloud (uses
  `ProjectCloudService`). Optional config in `config/optional/block.block.burndown_project_cloud.yml`.
- **`burndown_project_nav_block`** (`ProjectNavBlock`) — in-project sidebar navigation.

## Hooks & events (`src/Hook/BurndownHooks.php`, `burndown.module`)

- `hook_theme()` registers ~24 `burndown_*` templates (board card, backlog, task, log items, cloud).
- Task lifecycle: `*_task_presave/insert/update` maintain ticket ids, sort and logs; form alters add
  AJAX submit and estimate-value callbacks; `burndown_mail()` builds notification mail.
- Event subscribers: `TaskNotificationsSubscriber` reacts to the `Task*Event`s to email
  assignees/watchers (respecting the `enable_email_notifications` setting);
  `MyTasksRouteSubscriber` alters the `my_tasks` view route.
