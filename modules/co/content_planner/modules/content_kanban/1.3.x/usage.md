Content Kanban (a Content Planner submodule) shows moderated nodes as cards on a Kanban board, with columns for each Content Moderation workflow state, and logs every state change.

---

The board lives at `/admin/content-kanban` and renders one Kanban per valid Content Moderation workflow, with a column per workflow state and a card per moderated entity. Dragging a card calls `content_kanban.update_entity_workflow_state` (`/admin/content-kanban/update-entity-workflow-state/{entity_type}/{entity}/{state_id}`), which validates the move against the user's allowed transitions (`content_moderation.state_transition_validation`) before saving — so it respects each user's moderation-transition permissions rather than bypassing them. Access to the board itself is a custom check (`AccessCheck::canAccessContentKanban`) requiring `manage own content with content kanban` or `manage any content with content kanban`. A `content_kanban_log` content entity records each transition (user, entity, workflow, from/to state) via `hook_entity_presave`, and those logs are browsable, filterable and shown as recent-activity dashboard widgets. A settings form (`/admin/content-kanban/settings`, `administer content kanban settings`) controls things like the log date range. Depends on `content_planner` and `content_calendar`. The board and its statistics also feed two dashboard blocks (`ContentStateStatistic`, `RecentKanbanActivities`).

---

- See all moderated content as a Kanban board grouped by workflow state.
- Move a card between columns to transition a node's moderation state.
- Enforce per-user moderation-transition permissions on drag-and-drop moves.
- Run a separate board per Content Moderation workflow.
- Filter the board by content type, user or workflow.
- Log every moderation-state change as a `content_kanban_log` entity.
- Audit who moved which content between states and when.
- Show recent Kanban activity as a dashboard widget.
- Chart how much content sits in each workflow state (statistics widget).
- Give editors a visual pipeline from draft to published.
- Restrict board access to roles that manage their own vs any content.
- Configure the date range used for logs and statistics.
- Spot bottlenecks where content piles up in one state.
- Combine with Content Calendar for both board and timeline planning.
- Let reviewers pick up items waiting in a "needs review" column.
- Track editorial throughput across a moderation workflow.
- Provide add-content links directly from board columns.
- Review a single node's workflow state history.
- Surface stalled content that has not moved recently.
- Coordinate a team around a shared moderation board.
