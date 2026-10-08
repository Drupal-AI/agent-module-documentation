<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reviewer field, widget, autocomplete & AccessChecker

All classes under `src/`. Field machine name = `content_moderation_reviewer` (`CmrConstants::FIELD_NAME`).

## The field (content_moderation_reviewer.module)

- `content_moderation_reviewer_entity_base_field_info($entity_type)` — if
  `\Drupal::service('content_moderation.moderation_information')->isModeratedEntityType($entity_type)`,
  returns a `BaseFieldDefinition::create('entity_reference')`, `target_type = user`, revisionable,
  labelled "Moderation reviewer". So every moderated entity type gets the base field.
- `content_moderation_reviewer_entity_bundle_field_info($entity_type, $bundle, $base_field_definitions)`
  — only when the bundle already has a `moderation_state` field. Re-declares the same field with:
  form widget `ReviewerAutocompleteWidget::PLUGIN_ID` (`content_moderation_reviewer_autocomplete`,
  weight 120, `match_operator CONTAINS`), view display hidden, `->addConstraint('ModerationStateReviewer', [])`.
  `setDisplayConfigurable('form', FALSE)` — the widget placement is not editable on Manage form display.

No config is written; the field exists purely from these hooks. Nothing to configure in the UI.

## AccessChecker service (`AccessChecker.php`, service `content_moderation_reviewer.access_checker`)

- `roleIdsWithAllowedTransition(string $workflow_id, string $to_state_id): array`
  Loads the workflow; `getTypePlugin()->getTransitionsForState($to_state_id)` → the transitions whose
  **from** state is `$to_state_id`. Maps each to permission string `"use {workflow} transition {id}"`.
  Loads all `user_role` entities and keeps a role id if the role `isAdmin()` **or** has any of those
  permissions. Returns the filtered role-id list. (Admin roles are always included.)
- `isValidReviewer(string $workflow_id, UserInterface $reviewer, $to_state_id): bool`
  Returns FALSE if `$to_state` is a **published** state (`ContentModerationState::isPublishedState()`);
  otherwise TRUE only when the reviewer holds at least one role from `roleIdsWithAllowedTransition()`.
  Uses `assert()`s for workflow/state type — asserts are disabled in production, so a bad
  workflow/state id can surface as a normal type error rather than a handled condition.

Semantics: a "valid reviewer" for a to-state is someone who could execute a transition *out of* that
state (i.e. move it forward). Published states cannot have reviewers assigned.

## Autocomplete controller (`Controller/ReviewerAutocompleteController.php`)

- Route `content_moderation_reviewer.autocomplete`,
  path `/content_moderation_reviewer/{workflow_id}/{to_state}`, permission `access content`.
  Invokable (`__invoke(Request, $workflow_id, $to_state)`).
- Calls `roleIdsWithAllowedTransition()`, then a user entity query filtered
  `roles IN (roleIds)` AND `name CONTAINS ?q`, `pager(0, 10)`; returns JSON
  `[{value: "name (uid)", label: name}]` via `ReviewerAutocompleteWidget::userToAutocompleteLabel()`.
  Empty role list → empty result.

## Widget (`Plugin/Field/FieldWidget/ReviewerAutocompleteWidget.php`)

- `formElement()` — only acts when the entity form has a workflow. Reads the **to_state** via
  `getToStateId()` (user input → form value → first option of the moderation_state select). Attaches
  `#process` that moves the reviewer element under `moderation_state` and adds an `#ajax` callback
  (`updateWidget`) to the state select, wrapper id `content_moderation_reviewer-content-moderation-reviewer`.
  If the to-state is a published state, returns just a `value` element (field hidden/empty).
- Default value is only pre-filled when `from_state === to_state` (forces re-picking a reviewer when
  the state changes). Autocomplete points at the route above with `workflow_id`/`to_state` params.
- `elementValidate()` (static, `#element_validate`) — on non-submit rebuilds where the state changed,
  clears the reviewer value in user input and values (so a stale reviewer isn't kept across a state change).
- `massageFormValues()` — extracts the uid from the `"name (uid)"` string via
  `EntityAutocomplete::extractEntityIdFromAutocompleteInput()`.
- `isApplicable()` — widget only offered for the `content_moderation_reviewer` field.

## Constraint (`Plugin/Validation/Constraint/ModerationStateReviewer*`)

- `ModerationStateReviewerConstraint` id `ModerationStateReviewer`, message
  `"Invalid moderation reviewer from %from to %to"`.
- Validator `validate()` returns early (no violation) when: entity is not a moderated entity, entity
  `isNew()`, or the reviewer value is empty. Otherwise loads the workflow, the new state, and the
  reviewer user, and adds the violation unless `AccessChecker::isValidReviewer()` is TRUE. So the
  reviewer's role is validated only for **updates** to existing moderated entities with a set reviewer.

## Operating it

1. Enable the module (pulls in `workflows` + `content_moderation`).
2. Create/apply a Content Moderation workflow to your content types; grant the per-transition
   `use <workflow> transition <id>` permissions to the roles that should be assignable reviewers.
3. Edit moderated content: pick a target Moderation state, then choose a reviewer in the autocomplete
   that appears below it. Save. The reviewer is stored on the revision and available to Views.
