# Content Kanban configuration

## Routes

- `content_kanban.kanban` — `/admin/content-kanban`; custom access
  `\Drupal\content_kanban\Access\AccessCheck::canAccessContentKanban` (allowed if the user has
  `manage own content with content kanban` OR `manage any content with content kanban`).
- `content_kanban.update_entity_workflow_state` —
  `/admin/content-kanban/update-entity-workflow-state/{entity_type}/{entity}/{state_id}`; same
  custom access. `KanbanController::updateEntityWorkflowState` checks the entity is moderated,
  the target state is valid, and — crucially — that the transition is in
  `state_transition_validation->getValidTransitions($entity, $currentUser)` before setting
  `moderation_state` and saving. Returns a `JsonResponse`.
- `content_kanban.settings` — `/admin/content-kanban/settings` (`SettingsForm`,
  `administer content kanban settings`); config object `content_kanban.settings`
  (e.g. log/statistics date range, default 30 days). No config schema shipped.

## `content_kanban_log` entity

Content entity `content_kanban_log` (base table `content_kanban_log`,
`admin_permission = administer kanban log entities`). Fields include user, entity id/type,
workflow id, and previous/new state. Created automatically on every moderation-state change:
`content_kanban_entity_presave()` → `KanbanWorkflowService::onEntityPresave()`, which computes
the previous state from `content_moderation_state_field_revision` and calls
`KanbanLogService::createLogEntity(...)`. Log admin UI under `/admin/content-kanban/logs`
(list/add/edit/delete via `KanbanLogListBuilder` + route provider); access via
`KanbanLogAccessControlHandler` and the log permissions.

## Dashboard blocks

`Plugin/DashboardBlock/ContentStateStatistic` (per-state counts) and
`.../RecentKanbanActivities` (recent log entries) plug into the Content Planner dashboard.

## Param converter

`content_kanban.entity_params` (`EntityParamConverter`) resolves the generic `{entity}` of the
transition route to a loaded entity of `{entity_type}`.
