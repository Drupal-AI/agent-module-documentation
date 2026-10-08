<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Version adds an `entity_version` field type that stores a structured **major.minor.patch** version number on content entities, with a three-number widget, a configurable formatter, per-bundle "main field" settings, and `increase()` / `decrease()` / `reset()` methods that other code and its workflow sub-module use to change the numbers.

---

The module's core is one field type, `EntityVersionItem` (plugin id `entity_version`), whose storage schema is three **unsigned integer** columns — `major`, `minor`, `patch` — declared in `schema()`. The `EntityVersionWidget` renders them as three `#type => number` inputs (min 0, step 1) inside a "Version" details element; new fields default to `0.0.0` (`applyDefaultValue()`), and the field is considered empty only when any of the three parts is null/empty (`isEmpty()`). The `EntityVersionFormatter` (label "Version") joins the parts with dots down to a configurable `minimum_category` setting (`major`, `minor` or `patch`) so a display can show `2`, `2.1` or `2.1.4`. The item interface adds `increase($category)`, `decrease($category)` (never below zero) and `reset($category)` so third-party code — notably the `entity_version_workflows` sub-module — can mutate a single category. Which field is the "main" version field is recorded per entity-type + bundle by the `entity_version_settings` **config entity** (`EntityVersionSettings`, config prefix `entity_version.settings`, exporting `target_entity_type_id`, `target_bundle`, `target_field`); its id is `{entity_type}.{bundle}`. Site builders manage these mappings at **`/admin/config/entity-version/settings`** (`EntityVersionSettingsForm`, permission **`administer entity version`**), which lists every entity type/bundle that has at least one `entity_version` field and lets you pick the main field per bundle (auto-selected and disabled when a bundle has only one). Saving invalidates entity-type and route caches (`EntityVersionSettingsStorage::doPostSave()`) because the sub-modules alter routes/link templates from these configs. The `EntityVersionInstaller` service (`entity_version.entity_version_installer`) can create the field storage and per-bundle field programmatically. The project also ships `entity_version_history` (a per-entity History tab listing distinct versions across revisions) and `entity_version_workflows` (bump/reset version numbers on Content Moderation transitions), plus an `entity_version_workflows_example` demo. Uninstalling the module deletes all `entity_version_settings` config (`hook_uninstall`).

---

- Store an explicit editorial version number (`1.4.2`) on nodes, media, taxonomy terms or any content entity, separate from Drupal's revision ids.
- Add a `major.minor.patch` field to a content type and let editors set the three parts with a compact number widget.
- Display a version as just `2`, `2.1`, or `2.1.4` by choosing the formatter's minimum category per view display.
- Mark one field as the "main" version field per bundle so the history and workflow sub-modules know which field to act on.
- Programmatically attach the version field to an entity type/bundle from an install hook using the `EntityVersionInstaller` service.
- Increment a version category from custom code with `$item->increase('minor')`.
- Decrement a category safely (never below zero) with `$item->decrease('patch')`.
- Reset a category to zero with `$item->reset('patch')` when a major bump should clear lower numbers.
- Default every new entity to `0.0.0` automatically.
- Restrict who can configure the module with the `administer entity version` permission.
- Track document or policy versions on content that must show a formal version to editors and reviewers.
- Give compliance/QA workflows a human-readable version stamp on each revision.
- Show a "History" tab of distinct versions across an entity's revisions (via `entity_version_history`).
- Bump `patch` on "Create new draft", `minor` on "Validate", `major` on "Publish" automatically (via `entity_version_workflows`).
- Only bump a version when the entity's field values actually changed during a transition ("Check values changed").
- Prevent a version bump for a specific save by setting `$entity->entity_version_no_update = TRUE`.
- Keep the version unchanged when reverting a node revision (the workflows sub-module overrides the revert form to do this).
- Model semantic-versioning-style content lifecycles inside a Content Moderation workflow.
- Export the per-bundle version-field mappings as configuration and deploy them across environments.
- Add version metadata to translated content (the field itself is language-neutral unless configured otherwise).
- Present a version alongside other fields on the node display without custom theming.
- Let a single bundle carry more than one version field and choose which one is authoritative.
- Give editors a predictable, policy-driven version number instead of asking them to type one by hand.
- Build a release/change log view keyed on the stored version numbers.
