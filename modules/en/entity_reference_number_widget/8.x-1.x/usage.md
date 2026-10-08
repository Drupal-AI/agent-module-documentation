<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Number Widget replaces an entity-reference field's edit control with a plain numeric input where the editor types the target entity's ID directly.

---

Entity Reference Number Widget adds one field widget (plugin id `entity_reference_number`, label "Entity ID") that applies to any core `entity_reference` field. Instead of the default autocomplete or select-list, the field is edited as a single HTML `number` input (minimum 0) into which the editor enters the numeric ID of the target entity. When the entity is already referenced, the widget pre-fills the input with that entity's ID; an empty input clears the reference. It is a thin `WidgetBase` implementation with no settings, no configuration, no permissions, and no dependencies beyond Drupal core's Field API. The reference is still validated by core's entity-reference field constraint and rendered through core's normal access-aware display, so this module only changes the data-entry control. It suits workflows where target IDs are already known — bulk data entry, migrations, or admin forms — and where autocomplete is slow or impractical. Supports Drupal 8, 9, 10, and 11.

---

- Enter an entity reference by typing the target entity's numeric ID directly.
- Replace the autocomplete widget on a node reference field for a data-entry team that already knows node IDs.
- Set the widget on a `field_ui`-managed entity-reference field via Manage form display.
- Populate a taxonomy-term reference field by term ID during bulk content entry.
- Reference a user by user ID on a custom entity form.
- Reference media entities by media ID when the autocomplete is too slow on a large media library.
- Speed up repetitive reference entry where typing an ID is faster than searching by label.
- Support back-office/admin forms where editors work from spreadsheets of IDs.
- Fill reference fields during manual data migration from an old system that exposes numeric IDs.
- Pre-fill the input with the current target's ID when editing an existing referenced entity.
- Clear a reference by emptying the number input (submitted empty values are dropped).
- Provide an ID-based fallback when a referenceable target has no meaningful label to autocomplete on.
- Reference paragraphs or other content entities by ID in a scripted/QA workflow.
- Use on multi-value entity-reference fields, entering one ID per delta.
- Constrain input to non-negative integers via the widget's `#min = 0` number element.
- Keep reference entry keyboard-only, avoiding the mouse-driven select or autocomplete dropdown.
- Reduce page weight on forms with many reference fields by avoiding autocomplete requests.
- Wire up reference fields quickly in a development or staging environment where IDs are stable.
- Let integrators map external record IDs to Drupal entity IDs by hand.
- Configure per field, per form display, mixing this widget with default widgets on other fields.
- Apply to any entity type's reference field, since the widget targets the generic `entity_reference` field type.
- Serve content models where editors reference a small, well-known set of entities by memorized ID.
