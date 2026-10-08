<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Workspaces Extra (wse) — agent index

Extends core **Workspaces**. Adds an open/closed **status** field to workspaces (a workspace
closes when published), a service to **revert** a published (closed) workspace, **move**/**discard**
per-entity changes between workspaces, **clone-on-publish** and **squash-on-publish**, a
safe-forms allowlist, a simplified toolbar switcher, and a "Switch to Live" block. Ships 9
submodules (below). This is the TOP-LEVEL `wse` module only.

- Depends on core `options`, `workspaces`, `workspaces_ui`.
- Configure route: **`wse.settings`** → `/admin/config/workflow/workspaces/settings`
  (permission `administer workspaces`). Config object **`wse.settings`**.
- No permissions.yml (reuses core `administer workspaces` / `view any workspace` etc.).
  No drush commands. Defines config schema. Defines no plugin *types* (only plugin instances:
  one Block, one QueueWorker, validation constraints, and diff-module plugins).

Solution docs:
- **Change the settings (switcher, publishing, safe forms, status field)** → [configure/settings.md](configure/settings.md)
- **Call/extend WSE from code (revert service, published-revision storage, per-workspace publish flags, revert events, `_workspace_status` route check)** → [api/services.md](api/services.md)
- **Understand what WSE does to forms, entities, routes and cron (integration behaviour)** → [hooks/workspace-integration.md](hooks/workspace-integration.md)
- **Offer a "back to Live" link when browsing a workspace** → [blocks/switch-to-live.md](blocks/switch-to-live.md)

Submodules (each its own module, enable only what you need):

| Submodule | Machine name | Provides |
|---|---|---|
| Workspaces Deploy | `wse_deploy` | import/export deployment of workspace content between environments |
| Workspaces Group Access | `wse_group_access` | restrict workspaces to groups of users (NOT the Group module) |
| Workspaces Layout Builder | `wse_lb` | Layout Builder tweaks for workspaces |
| Workspaces Menu | `wse_menu` | stage menu hierarchies inside a workspace |
| Workspaces Scheduler | `wse_scheduler` | schedule workspace publishing |
| Workspaces Task Monitor | `wse_task_monitor` | real-time UI monitoring of workspace operations |
| Workspaces Config *(deprecated)* | `wse_config` | promoted to standalone `workspace_config` |
| Workspaces Preview *(deprecated)* | `wse_preview` | promoted to standalone `workspace_preview` |
| Workspaces Pruner | `wse_prune` | delete/clean up old workspaces |

Key facts:
- Config object: `wse.settings` (schema `wse.schema.yml`). Keys: `simplified_toolbar_switcher`,
  `recent_workspaces_max_age`, `switcher_max_options`, `save_published_revisions`,
  `override_save_published_revisions`, `squash_on_publish`, `squash_on_publish_interval`,
  `clone_on_publish`, `safe_forms`, `entity_workspace_status`, `disable_sub_workspaces`,
  `append_current_workspace_to_url`.
- Services (autowired by class, not `.`-prefixed ids): `Drupal\wse\WorkspaceReverter`,
  `Drupal\wse\PublishedRevisionStorage`. Decorators of `workspaces.manager`
  (`WseWorkspaceManager`) and the lazy-builders.
- Routes: `wse.settings`, `wse.switch_to_live` (`/wse/switch-to-live`),
  `entity.workspace.revert_form`; plus per-entity-type `move_to_workspace`, `discard_changes`,
  `workspace.revisions_diff` added by `RouteSubscriber`.
- Events: `wse.workspace.pre_revert`, `wse.workspace.post_revert`
  (`Drupal\wse\Event\WorkspaceEvents`, `WorkspaceRevertEvent`).
- Route access check: `_workspace_status: open|closed` (`Drupal\wse\Access\WorkspaceStatusAccess`).
- Block: `wse_switch_to_live`. QueueWorker: `wse_revision_cleaner`.
- Extra DB table `workspace_published_revisions` (revert history). Status field constant values
  `open`/`closed` (`WSE_STATUS_OPEN`/`WSE_STATUS_CLOSED`).
- Core requirement `^11.3 || ^12` — no Drupal 10. Newest release on the 3.0.x branch is
  **3.0.0-alpha5** (no stable release exists for this project); not covered by security advisories.
- `require-dev` lists optional integrations (`diff`, `trash`, `s3fs`, `depcalc`,
  `group_content_menu`, `workspace_config`, `workspace_preview`) — not runtime requirements.
