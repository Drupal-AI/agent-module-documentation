# Content Planner Kanban — agent index

A Content Planner submodule: a Kanban board of moderated nodes at `/admin/content-kanban`,
columns = Content Moderation workflow states. Depends on `content_planner` + `content_calendar`.
No `configure` route in info.yml (settings at `/admin/content-kanban/settings`).

- **Board routes, the drag-to-transition endpoint, settings, the `content_kanban_log` entity** →
  [configure/kanban.md](configure/kanban.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Board `content_kanban.kanban` (custom access `AccessCheck::canAccessContentKanban` → needs
  `manage own`/`manage any content with content kanban`).
- Transition endpoint `content_kanban.update_entity_workflow_state`
  (`/update-entity-workflow-state/{entity_type}/{entity}/{state_id}`) — **validates the move with
  `content_moderation.state_transition_validation` against the current user** before saving, so it
  does not bypass moderation permissions. Returns JSON.
- `content_kanban_log` content entity (`base_table content_kanban_log`) logs each state change via
  `content_kanban_entity_presave` → `KanbanWorkflowService::onEntityPresave`.
- Settings `content_kanban.settings` (`administer content kanban settings`, `restrict access: true`).
- Contributes dashboard blocks `ContentStateStatistic` and `RecentKanbanActivities`.
