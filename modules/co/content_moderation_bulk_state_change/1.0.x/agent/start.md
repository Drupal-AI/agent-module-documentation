<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Moderation Bulk State Change (content_moderation_bulk_state_change) — agent index

Human-readable name (`content_moderation_bulk_state_change.info.yml`): **"Content Moderation
Bulk State Change"** — _"Allows updating the moderation state of entities using bulk action."_

Adds a **bulk action** to move several **nodes** through their content-moderation workflow at
once. On the content admin View an editor ticks multiple nodes, runs the **"Change workflow
stage"** action, and confirms a single target moderation state on a dedicated confirm form
instead of transitioning each node individually. Node-only: the action is declared `type: node`
and the confirm form uses the `node` entity storage throughout.

- **Version** `1.0.0-alpha1` (version dir `1.0.x`). **Package** `Content`.
- **Core** `^10 || ^11` (from `.info.yml`).
- **Dependencies** (`.info.yml`): `drupal:workflows`, `drupal:content_moderation`.
- **License** GPL-2.0-or-later. `security_advisory_coverage: not-covered`. Actively maintained,
  under active development. Project: https://www.drupal.org/project/content_moderation_bulk_state_change
- README.txt is a stub (title only).

## What ships (from source)

**Action plugin** — `src/Plugin/Action/BulkChangeWorkflowStage.php`
- `#[Action(id: 'bulk_change_workflow_stage_action', action_label: 'Change workflow stage',
  confirm_form_route_name: 'content_moderation_bulk_state_change.bulk_change_workflow_stage_form',
  type: 'node')]`, extends `ActionBase`.
- `access()` returns `$object->access('update', $account, $return_as_object)` — the action is
  offered per node according to that node's **update** access.
- `executeMultiple()` stores the selected entities in the **private tempstore**
  (`tempstore.private`, collection `bulk_change_workflow_stage`, keyed by current user id) and
  then the framework redirects to the confirm form. `execute()` wraps a single entity.

**Confirm form** — `src/Form/BulkChangeWorkflowStageForm.php` (`ConfirmFormBase`, `@internal`)
- Route `content_moderation_bulk_state_change.bulk_change_workflow_stage_form` at
  `/admin/bulk-change-workflow-stage`, requirement `_permission: 'update entity moderation
  states in bulk'`.
- `buildForm()` reloads the selected nodes from the tempstore and refuses (adds error messages,
  redirects back) unless: entities exist; the current user has **update** access to every
  selected node (`userHasEditPermissions()`); all selected nodes share the **same workflow**
  (`entitiesAllSameWorkflow()`); and all share the **same current moderation state**
  (`entitiesAllSameWorkflowStage()`).
- It then lists the node titles (`#theme => 'item_list'`), shows the shared current state, and
  offers a required **"Move entity to:"** `select` whose options come from
  `getAvailableToStates()` = the workflow transitions defined **from** the current state
  (`ModerationInformation` → `getTypePlugin()->getTransitionsForState(..., DIRECTION_FROM)`),
  excluding the current state itself.
- `submitForm()` loads each node's latest translation-affected revision
  (`getLatestTranslationAffectedRevisionId`), optionally creates a **new revision** or updates
  the existing one (per the `new_revision` setting), sets `moderation_state` to the chosen
  target, writes a revision log message ("Moderation state changed from … to …"), records the
  current user as revision author, and saves. On success it messages the editor and redirects to
  `view.content.page_1`.

**Settings form** — `src/Form/ContentModerationBulkStateChangeSettingsForm.php` (`ConfigFormBase`)
- Route `content_moderation_bulk_state_change.settings` at
  `/admin/config/workflow/content-moderation-bulk-state-change`, requirement `_permission:
  'administer content moderation bulk state change module'`. `configure:` link in `.info.yml`;
  menu link under `system.admin_config_workflow` (`.links.menu.yml`).
- Single field: **"Create new revision?"** checkbox → config
  `content_moderation_bulk_state_change.settings:new_revision` (schema
  `config/schema/bulk_change_workflow_stage_action.schema.yml`; install default `0`).

**Permissions** (`.permissions.yml`) — two:
- `update entity moderation states in bulk` — "Update entity moderation states in bulk" (gates
  the confirm form / bulk operation).
- `administer content moderation bulk state change module` — "Access content moderation bulk
  state change configuration" (gates the settings form).

**Config install** — `config/install/system.action.bulk_change_workflow_stage_action.yml` ships
the action entity (`type: node`, `plugin: bulk_change_workflow_stage_action`, depends on `node`)
so the "Change workflow stage" operation appears in the node content View's bulk-operations
dropdown out of the box.

## Access model (plain mechanism)

The bulk operation is reached only by users with the `update entity moderation states in bulk`
permission, and the action is offered / the confirm form proceeds only for nodes the user has
**update** access to (checked in both `BulkChangeWorkflowStage::access()` and the form's
`userHasEditPermissions()`). The confirm dropdown lists the transitions defined **from** the
selected nodes' shared current moderation state. Both entry points are standard Drupal action /
confirm forms and carry form tokens. The settings form is gated by the separate `administer
content moderation bulk state change module` permission.

## See also

- [../usage.md](../usage.md) — one-line capability summary + phrasings.
- [../human-docs/](../human-docs/index.md) — human install & configuration guide.
