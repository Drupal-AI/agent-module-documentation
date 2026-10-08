<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VBO Workflow Transition (vbo_workflow_transition) — agent index

A single **Views Bulk Operations action** that transitions Content-Moderation entities through
their workflow in bulk. Version **1.1.0**. Core `^10.2 || ^11 || ^12`. License GPL-2.0-or-later.
Package `Custom`. Depends on core **`content_moderation`**, **`views`**, **`workflows`** and
contrib **`views_bulk_operations`** (composer `require` names only `drupal/views_bulk_operations`).

- **The action plugin — execute, config form, access, batch** →
  [plugins/vbo_workflow_transition.md](plugins/vbo_workflow_transition.md)
- **How to enable and wire it into a View (no settings page)** →
  [config/setup.md](config/setup.md)

## What it actually is

- **One plugin**, no config page, **no permissions of its own**, no Drush, no services, no hooks,
  no config schema, no submodules, no JS/CSS. The whole module is one PHP class.
- `VboWorkflowTransition` (VBO action, id **`vbo_workflow_transition_`** — note the trailing
  underscore; `type: ''` so it applies to **all entity types**; label *"Transition content to a
  new workflow state"*), in
  `src/Plugin/Action/VboWorkflowTransition.php`, extending
  `views_bulk_operations\Action\ViewsBulkOperationsActionBase` and implementing
  `ContainerFactoryPluginInterface`.

## Mechanism (from source)

- **Config form** (`buildConfigurationForm`) expands the VBO selection to a concrete entity list
  (`getAllResultsFromViewAsVboList`, handling "select all pages"/exclude mode, capped at
  `MAX_SCAN_COUNT = 500` rows for the preview only), loads each entity's latest
  translation-affected revision, and asks
  `StateTransitionValidationInterface::getValidTransitions($entity, $currentUser)` which
  transitions the **current user** may make. It renders a `details` group per workflow with a
  submit button per transition (button `#name` = `submit:{transition_id}:{workflow_id}`) plus a
  `revision_log_message` textarea. If nothing is eligible it shows an error and no options.
- **submitConfigurationForm** reads the clicked button key to store `transition_id`, `workflow_id`
  and `revision_log_message` into the action configuration.
- **execute($entity)** re-checks per entity: entity must be `EditorialContentEntityBase`, its
  workflow must equal the configured `workflow_id`, and the configured `transition_id` must be
  among `getValidTransitions($entity, $currentUser)` — otherwise it returns NULL and **does not
  save**. When valid it sets `moderation_state`, forces a **new revision** (log message, revision
  user = current user, revision/changed time = request time, translation-affected TRUE) and saves.
- **access()** returns the entity's `update` access for the account (the per-transition permission
  check is deferred to `execute()`).
- **finished()** overrides VBO's completion message to a single combined status message listing the
  transitioned entity labels and the target state (uses `MESSAGE_SEP = '||||'`).

## Post-install

No configuration route (`configure: null`). Enable the module, then edit a View that lists
moderated entities and add the **"Global: Views bulk operations"** field. See
[config/setup.md](config/setup.md).
