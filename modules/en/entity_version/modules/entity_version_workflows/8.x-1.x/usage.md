<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Version Workflows lets each Content Moderation **workflow transition** be configured to increase, decrease, reset or leave unchanged each of the **major/minor/patch** numbers of a bundle's main version field, applying the rules automatically as content moves through the workflow.

---

This sub-module bridges Entity Version with core **Content Moderation / Workflows**. A `hook_form_alter` on the `workflow_transition_add_form` / `workflow_transition_edit_form` adds a **"Version control"** fieldset where, for each transition, you pick per category (Major, Minor, Patch) one of *Nothing / Increase / Decrease / Reset*, plus a **"Check values changed"** checkbox. These choices are saved as **third-party settings** on the workflow config entity (keyed by transition id; schema `workflows.workflow.*.third_party.entity_version_workflows`). At runtime `hook_entity_presave()` catches any content entity, looks up the bundle's `entity_version_settings` mapping to find the **main version field**, and hands off to `EntityVersionWorkflowManager::updateEntityVersion()`. That manager (service `entity_version_workflows.entity_version_workflow_manager`, built with the Content Moderation information service, entity type manager and event dispatcher) resolves the transition being performed by comparing the latest revision's `moderation_state` with the new one, reads the transition's configured actions, and calls the field item's `increase()` / `decrease()` / `reset()` for each category — so the version bump is a side-effect of an authorised moderation transition. If "Check values changed" is set, it first compares the entity to its latest revision (via `EntityChangesDetectionTrait`, with a blacklist of computed/irrelevant fields that other modules can extend through the `CheckEntityChangedEvent`) and does nothing when nothing changed. Two escape hatches exist: set `$entity->entity_version_no_update = TRUE` to skip the bump for a save, and the module overrides the node revision-revert form (`NodeRevisionRevertForm`) to keep the version unchanged when reverting. New entities are skipped. A bundle with no configured main field is left untouched.

---

- Increase `patch` automatically every time an editor creates a new draft.
- Increase `minor` and reset `patch` when content is validated/approved.
- Increase `major` and reset `minor` when content is published.
- Decrease a version number on a specific "roll back" transition.
- Reset a category to zero on a chosen transition.
- Leave a version number untouched for transitions where it shouldn't change ("Nothing").
- Configure different version rules per workflow and per transition.
- Only bump the version when the entity's field values actually changed ("Check values changed").
- Drive semantic-versioning-style numbering from an editorial moderation workflow.
- Keep version numbers consistent without asking editors to edit them by hand.
- Skip a version bump for a programmatic save with `$entity->entity_version_no_update = TRUE`.
- Preserve the version number when reverting a node revision (handled automatically).
- Extend the "did the entity change" check by adding fields to skip via `CheckEntityChangedEvent`.
- Apply version rules to any content entity type covered by Content Moderation, not just nodes.
- Store per-transition version rules as exportable workflow third-party settings.
- Combine with `entity_version_history` to visualise the versions produced by transitions.
- Ensure the current revision (not just the default) is used when computing the transition, when needed.
- Model an approval pipeline (Draft → Validated → Published) with automatic version stamping.
- Prevent uncontrolled version drift by centralising increment rules in the workflow config.
- Let QA verify that each transition produced the expected version change.
