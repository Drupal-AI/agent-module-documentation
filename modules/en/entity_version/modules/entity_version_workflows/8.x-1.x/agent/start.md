<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Version Workflows (entity_version_workflows) — agent index

Sub-module of **entity_version**. Lets each Content Moderation **workflow transition** be configured
to increase / decrease / reset / do-nothing on each of the **major/minor/patch** numbers of a
bundle's main version field, applied automatically in `hook_entity_presave`. Depends on
`entity_version` + core `content_moderation`. Core `^10 || ^11`. GPL-2.0-or-later.

- **Configuring per-transition rules, the presave manager, the change check, and the opt-out API** →
  [api/version-transitions.md](api/version-transitions.md)

## What it provides (from source)

- **`hook_form_alter`** (`entity_version_workflows.module`) on `workflow_transition_add_form` /
  `workflow_transition_edit_form` → adds a "Version control" fieldset (per category select of
  *Nothing / Increase / Decrease / Reset* + a "Check values changed" checkbox); an entity builder
  saves the choices as workflow **third-party settings** keyed by transition id.
- **`hook_entity_presave`** → for a content entity whose bundle has an `entity_version_settings`
  mapping, calls `EntityVersionWorkflowManager::updateEntityVersion($entity, $mainField)`.
- **Service** `entity_version_workflows.entity_version_workflow_manager`
  (`EntityVersionWorkflowManager`) — resolves the transition (latest-revision `moderation_state` →
  new state), reads its configured actions, and calls the field item's `increase/decrease/reset` per
  category; optional `check_values_changed` gate via `EntityChangesDetectionTrait`.
- **Event** `CheckEntityChangedEvent` (`entity_version_worfklows.check_entity_changed_event`) — lets
  other modules extend the field blacklist used by the change check.
- **Route subscriber** `RouteSubscriber` (service
  `entity_version_workflows.route_subscriber`) — swaps the node revision-revert form for
  `NodeRevisionRevertForm`, which sets `entity_version_no_update = TRUE` so reverting keeps the
  version.
- **Config schema**: `workflows.workflow.*.third_party.entity_version_workflows` (per-transition
  `major`/`minor`/`patch` string action + `check_values_changed` boolean). **Permissions**: none of
  its own (uses core workflow-admin + moderation-transition permissions). **Drush**: none.

## Opt-out flags (on the entity, before save)

- `$entity->entity_version_no_update = TRUE` → skip the version bump for this save.
- `$entity->entity_version_use_current_revision = TRUE` → resolve the transition from the loaded
  revision instead of the latest revision.
