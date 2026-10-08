<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Required Field Display adds a red required-marker (`*`) next to required fields on the Field UI "Manage fields" and "Manage form display" screens, so a site builder can see a bundle's required fields at a glance instead of opening each field's settings.

---

Field UI lists a bundle's fields with their label, machine name and type — but not whether they are required, which is one of the first things anyone auditing a content type wants to know. Finding out otherwise means opening each field's edit form in turn, which on a twenty-field bundle is twenty page loads to answer a question the listing could answer directly. This module adds the indicator via one procedural file (`required_field_display.module`): `hook_preprocess_table()` marks required fields on the Manage fields listing and `hook_form_..._alter()` marks them on the Manage form display screen, while `css/required_field_display_ui.css` renders a red `*` (or `* ∞` for a required field with unlimited cardinality) after the label. A field counts as required when its definition's `isRequired()` is TRUE, and — if the optional `require_on_publish` module is enabled — also when it carries that module's require-on-publish third-party setting. That is the whole module: no dependencies, no routes, no permissions, no configuration, with a wide core range of `^8.8 || ^9 || ^10 || ^11`. It is a purely administrative display change, so it affects nothing about the fields themselves and is free to add or remove. The obvious use is auditing a content type before a migration or a form redesign, where knowing which fields are mandatory determines what the source data must supply.

---

- See which fields are required at a glance on Manage fields.
- Spot required fields on the Manage form display screen.
- Distinguish a required unlimited-cardinality field by its `* ∞` marker.
- Audit a content type before a migration.
- Check required fields without opening each one.
- Plan a form redesign around mandatory fields.
- Verify a data model against a specification.
- Document a bundle's mandatory fields.
- Spot a field made required by mistake.
- Review required fields with a stakeholder.
- Check what an import must supply.
- Compare two bundles' requirements side by side.
- Speed up a content model review.
- Onboard a developer to a content type.
- Confirm a change to field requirements took effect.
- Reduce clicks in Field UI.
- Prepare a webform equivalent of a bundle.
- Check requirements before bulk editing.
- Review a migrated content type.
- Surface fields made required by the `require_on_publish` module.
- Restyle the required marker from your theme's CSS.
- Support a content audit with a visual cue.
