<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Webform — the Group relation plugin

## Plugin
`\Drupal\group_webform\Plugin\Group\Relation\GroupWebform` (`@GroupRelationType id="group_webform"`).
- `entity_type_id = "webform_submission"`.
- `entity_access = TRUE` — Group installs per-group permissions for the submission entity type and enforces group access on it. **This is the correct secure posture**: viewing/creating/editing/deleting a group's webform submissions is gated by the group role permissions Group generates, not by a custom (potentially over-broad) handler in this module.
- `defaultConfiguration()` pins `entity_cardinality = 1`; `buildConfigurationForm()` disables the cardinality field in the UI.
- `calculateDependencies()` adds a config dependency on `webform.webform.<bundle>`.

## Deriver
`GroupWebformDeriver::getDerivativeDefinitions()` clones the base definition once per `Webform::loadMultiple()` entry, setting `entity_bundle` to the webform id and human labels. `group_webform_webform_insert()` (in the .module) clears cached relation-type definitions so a new webform appears as a relation without a manual cache clear.

## Operating it
1. Enable Webform + Group 3.x + this module.
2. On a group type, install the `group_webform:<webform_id>` relation for each webform to attach.
3. Assign the generated per-group webform-submission permissions to group roles.

## Security review result
Group access on submissions **is correctly enforced** (delegated to Group via `entity_access = TRUE`); no over-grant that would leak submissions across groups. `RouteSubscriber::alterRoutes()` returns before its body — it alters nothing.