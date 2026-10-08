Burndown is a native Drupal agile/Kanban project-management tool providing projects, fieldable tasks, sprints, drag-and-drop swimlane boards, a backlog, work logs, and burndown charts.

---

Burndown models software-style project management directly on Drupal entities. A Project (content entity `burndown_project`, identified by a short "shortcode" like `PROJ`) owns Tasks (`burndown_task`), Columns/swimlanes (`burndown_swimlane`), and optionally Sprints (`burndown_sprint`). Each project is either a Kanban board or a Sprint board. Tasks flow across per-project columns via drag-and-drop, can be sent to/from the backlog, moved between sprints, closed with a resolution, reopened, and related to one another (blocked by, blocks, related to, follows up). Tasks carry a work log and comment thread, an assignee, a watchlist, estimates (T-shirt / geometric / dot sizing), tags, links and images. Projects and Tasks are fieldable bundles, so you can add fields like any Drupal content type. Burndown ships a per-project permission model, event subscribers that send email notifications on task changes, two navigation blocks, and a large set of Drush commands for headless/scripted management. The optional `burndown_time_tracker` submodule adds per-user start/stop task timers and an hours report. It depends only on core modules (datetime, field, image, link, options, taxonomy, views).

---

- Run an agile board for a software or content team entirely inside Drupal, no external SaaS.
- Track work as Tasks that move across customizable columns (To Do, In Progress, Testing, Done, etc.).
- Choose Kanban (continuous flow) or Sprint (time-boxed) methodology per project.
- Maintain a prioritized backlog and drag items onto the active board when ready.
- Plan and open/close sprints, pulling backlog tasks into a sprint and burning them down.
- Give each project a short code (e.g. `WEB`) so tasks read like `WEB-42`.
- Estimate task size with T-shirt sizes, geometric (Fibonacci-like) points, or dot voting.
- Record work against a task via its work log, accumulating logged time/effort.
- Discuss a task inline with a comment thread stored on the task.
- Link related tasks: mark one "blocked by" or "blocks" another, or "related to"/"follows up".
- Assign tasks to users and filter a board by assignee.
- Let users watch tasks and receive email when watched tasks change.
- Send email notifications to assignees/watchers on task create, comment, work, change, close.
- Extend Tasks with custom fields (due date, customer, severity) since they are fieldable bundles.
- Create multiple Task types (bug, feature, chore) as separate bundles with their own fields.
- Add the "Projects" cloud block and "Burndown Sidebar" navigation block to a sidebar region.
- Review completed tasks per project on the Completed board.
- Reorder backlog and board columns via drag-and-drop.
- Reorder the swimlane columns themselves for a project.
- Keep an audit trail through entity revisions on Projects, Tasks and Sprints.
- Script project/task management headlessly with Drush (list, add, edit, close, reopen, move tasks).
- Bulk-create or migrate tasks via `drush burndown:add_task` and related commands.
- Track billable/spent hours per task with the Time Tracker submodule's start/stop timer.
- Give managers an hours report across users with the Time Tracker submodule.
- Configure global defaults (estimate scales, resolution statuses, relationship types) centrally.
