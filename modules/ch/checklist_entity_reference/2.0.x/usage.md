<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Checklist Entity Reference

Turns an entity-reference field into a checklist and shows a completion progress bar.

---

## Install & configure

- `composer require drupal/checklist_entity_reference` then `drush en checklist_entity_reference -y`.
- No admin settings page, no permissions, no routes — everything is done through the Field UI.
- Add a field of type **Checklist Entity Reference** (`entity_reference_checklist`) to a content type / entity bundle.
- On the field's **Manage form display**, choose the **Check boxes/radio buttons** widget (`entity_reference_checklist_options`).
- To show progress, enable the **Checklist Progress** extra form component (hidden by default) on Manage form display.
- On **Manage display**, pick **Checklist Labels** (`entity_reference_checklist_label`) or **Checklist Progress** (`entity_reference_checklist_progress`) formatter.

---

## Usage & behaviour

- Store a set of references (e.g. a taxonomy term list) that editors tick off like a to-do list.
- Model onboarding / compliance checklists where each reference is a task and completion is tracked.
- Show editors a live progress bar on the entity form as they check items (`checklist_entity_reference_progress` form element).
- Progress percentage is computed as `round(100 / total * selected)` over all `entity_reference_checklist` fields on the entity.
- The widget extends core `OptionsButtonsWidget`, so it behaves like standard checkboxes with the same allowed-values handling.
- The field type extends core's entity-reference item, so referential integrity and target-type settings work as usual.
- Use the **Checklist Labels** formatter to render the selected referenced entities' labels on display.
- Use the **Checklist Progress** formatter to render a progress bar on the entity's display, not just the form.
- Reference any entity type (nodes, terms, users) — target type is chosen when creating the field.
- Combine several checklist fields on one bundle; the progress bar aggregates all of them.
- Good for editorial workflows: "required sections completed", "documents attached", etc.
- The progress bar is themed via `checklist-entity-reference-progress-bar` template and the module's library.
- Works on any entity form that uses form displays (nodes, media, custom entities).
- No JavaScript state machine — progress is recalculated server-side on each form build.
- Multi-value by design (`multiple_values = TRUE`); a single widget renders the whole checklist.
