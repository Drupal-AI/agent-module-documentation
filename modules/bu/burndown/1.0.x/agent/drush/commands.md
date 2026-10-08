<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Burndown — Drush commands

Defined in `src/Commands/BurndownDrushCommands.php` (registered via `drush.services.yml`, service
`burndown.commands`; `composer.json` declares the Drush service for Drush `^9 || ^10`). All commands
are in the `burndown:` namespace and have `burndown-*` plus short aliases.

| Command | Aliases | Purpose |
|---|---|---|
| `burndown:project_list` | `bdpl` | List all projects. |
| `burndown:add_project` | `bdap` | Create a project. Options: `--name`, `--shortcode`, `--username`, `--board_type` (kanban\|sprint), `--estimate_type`. |
| `burndown:edit_project {shortcode}` | `bdep` | Edit an existing project. |
| `burndown:task_list {shortcode}` | `bdtl` | List a project's tasks; flags `--backlog --board --completed`. |
| `burndown:task_details {ticket_id}` | `bdtd` | Show one task; `--show_description --show_comments`. |
| `burndown:add_task` | `bdat` | Create a task. Options: `--shortcode`, `--task_name`, `--assignee`, `--reported_by`, `--priority`, `--estimate`, `--description`. |
| `burndown:edit_task {ticket_id}` | `bdet` | Edit a task interactively. |
| `burndown:close_task {ticket_id}` | `bdct` | Close a task. |
| `burndown:reopen_task {ticket_id}` | `bdrot` | Reopen a closed task. |
| `burndown:change_swimlane {ticket_id}` | `bdcs` | Move a task to another column. |
| `burndown:send_to_board {ticket_id}` | `bdstb` | Send a backlog task to the board. |
| `burndown:send_to_backlog {ticket_id}` | `bdsfb` | Send a board task back to the backlog. |
| `burndown:watch_task {ticket_id} {username}` | `bdwt` | Add a user to a task watchlist. |
| `burndown:unwatch_task {ticket_id} {username}` | `bdut` | Remove a user from a watchlist. |
| `burndown:swimlane_list {shortcode}` | `bdsl`, `bdcl` | List a project's columns. |
| `burndown:sprint_list {shortcode}` | `bdspl` | List a project's sprints. |
| `burndown:task_sprint_assignment {ticket_id}` | `bdtsa` | Assign a task to a sprint. |
| `burndown:search_tasks` | `bdst` | Search tasks interactively. |

These commands drive the same entity APIs as the UI (e.g. `Task::loadFromTicketId`, the swimlane and
sprint helpers) and are the recommended path for headless/scripted project and task management.
