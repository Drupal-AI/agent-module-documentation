<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Base Field Override UI adds a "Base fields Override" tab to every Field-UI-enabled entity type's *Manage fields* page, letting you change the label and description of code-defined base fields (like a node's Title) per bundle through the admin UI, without writing code.

---

Drupal core lets modules define base fields with `BaseFieldDefinition`, but the admin UI normally exposes almost none of them for per-bundle customization (you can only rename the node Title). This module surfaces them: for each entity type that has a `field_ui_base_route`, a `RouteSubscriber` adds routes under `<manage-fields-path>/fields/base-field-override` and a local-task deriver adds a **Base fields Override** secondary tab beside the normal *Fields* tab. From there a list builder shows the entity type's base fields and you can add, edit, or delete an override that changes that base field's **label** and **description** for a specific bundle. Under the hood it edits core's own `base_field_override` config entity (`core.base_field_override.<entity_type>.<bundle>.<field_name>`) via a custom edit/delete form and controller — it defines no config entity or storage of its own; it re-uses core's `BaseFieldOverride`. Access is governed by core's existing `administer <entity_type> fields` permission (and the field must be display-configurable on the form). It also wires config-translation support so overridden labels/descriptions can be translated. The module depends on `field_ui`.

---

- Rename the node **Title** base field to "Headline" on the Article content type only.
- Change the description/help text of a base field shown to editors on a bundle.
- Relabel the base **Name** field on a taxonomy vocabulary through the UI.
- Override a base field label on a custom entity type without a code deployment.
- Give a media type's base field a clearer, editor-friendly label.
- Adjust the base field label per bundle so different content types read naturally.
- Translate an overridden base field label/description via config translation.
- Provide a non-developer site builder a UI to tweak base field labels safely.
- Add a bundle-specific description to core's base fields that ship with none.
- Delete a base field override to revert to the code-defined default label.
- Standardise base field wording across bundles from one admin screen.
- Override the label of the User entity's base fields per (single) bundle.
- Customize base field labels on a block content type.
- Expose otherwise-uneditable base fields for label/description tuning.
- Edit `core.base_field_override.*` config through a form instead of by hand.
- Keep base field overrides in exported configuration for deployment.
- Fix an awkward default base field label reported by content editors.
- Localize base field labels differently per language on a multilingual site.
- Audit which base fields have been overridden on an entity type via the list page.
- Apply a consistent labeling convention to base fields site-wide.
