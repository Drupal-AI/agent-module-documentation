<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IEF Complex Open is an Inline Entity Form add-on that provides a "complex" widget variant whose "add existing" reference form is already open by default.

---

The module ships a single field-widget plugin, `inline_entity_form_complex_open` (label **"Inline entity form - Complex (Open)"**), which extends Inline Entity Form's standard complex widget and pre-renders its "add existing" autocomplete instead of hiding it behind an **Add existing** button — one fewer click and behaviour closer to core's entity autocomplete. Install it with `composer require drupal/ief_complex_open` and enable it (`drush en ief_complex_open`); it requires the contrib **Inline Entity Form** module (`drupal/inline_entity_form: ^1 || ^3`). To use it, edit an entity type that has an `entity_reference` (or `entity_reference_revisions`) field, go to **Manage form display**, and set that field's widget to **Inline entity form - Complex (Open)**. It inherits all the usual IEF complex settings (allow new / allow existing / allow duplicate, match operator, collapsible, labels, etc.) and adds one extra option — **"Restrict new inline entities to one bundle"** — to limit inline creation to a single target bundle. There is no admin/config page of its own and no permissions; it only changes the widget's initial state and button labels, not what can be referenced or who may edit.

---

- Show the "add existing" autocomplete already open on an entity-reference field.
- Save editors a click when the common action is referencing existing content.
- Make inline referencing feel like the core entity autocomplete widget.
- Apply the widget to an `entity_reference` field via Manage form display.
- Apply the widget to an `entity_reference_revisions` (paragraphs-style) field.
- Restrict inline creation of new entities to a single bundle.
- Keep both "reference existing" and "create new" affordances visible at once.
- Speed up building content that links many existing nodes/terms/media.
- Reference existing taxonomy terms inline without an extra button click.
- Curate a list of existing entities on a landing/section page quickly.
- Attach existing media or file entities to content via inline reference.
- Use per form mode (default vs a custom "quick add" form display).
- Inherit IEF settings for allow-new, allow-existing, and match operator.
- Relabel the create action to "Create new …" for clearer authoring UX.
- Swap in for the standard IEF Complex widget without changing field storage.
- Combine with field_config_cardinality to cap how many can be added.
- Roll back easily by switching the field's widget back to IEF Complex.
- Improve throughput for editors who mostly reference, rarely create.
