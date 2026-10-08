<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Map Widget gives Drupal core's `map` field an actual editing UI — a repeatable key/value table on the entity form — because core ships that field type with no widget of its own. It is a developer module; despite the name it has nothing to do with geographic maps.

---

Drupal's typed-data `map` field stores an associative array, which is convenient in code but leaves site builders with nothing to put on a form. This module supplies the missing pieces: a field widget `map_assoc_widget` (`AssociativeArrayWidget`, declared with the modern `#[FieldWidget(field_types: ['map'], multiple_values: TRUE)]` attribute) that renders a set of key/value textfield rows with an AJAX "Add an entry" button, and an underlying reusable form element `#type: map_associative` (`AssociativeArray`, `#[FormElement('map_associative')]`) you can drop into any custom form. Editors get one row per stored pair plus extras on demand; on save the value is collapsed back into a plain `key => value` array (blank values dropped, last duplicate key wins). The widget has three per-instance settings — `size`, `key_placeholder`, `value_placeholder` — declared in `config/schema/map_widget.schema.yml` so they export with the form display, and a small CSS library (`css/associative-element.css`) styles the rows. The core `map` field is not exposed in Field UI, so it is added as a base field in code and this widget selected via `setDisplayOptions('form', ['type' => 'map_assoc_widget', ...])`. There is no settings page, no permission, no service and no Drush; the only install-file code is an update hook (`map_widget_update_8101`) that repairs map data corrupted by an older release.

---

- Give editors a UI for a core `map` base field that would otherwise be uneditable.
- Collect arbitrary key/value settings against an entity without defining a new field type.
- Store per-entity configuration as an associative array on a base `map` field.
- Let a contrib/custom module expose its `map` field for editing on the entity form.
- Capture request/query parameters to attach to an outbound integration (e.g. a form request).
- Store per-item metadata or data attributes as key/value pairs.
- Add a repeatable key/value table with a size and placeholders you control.
- Let editors add more rows on the fly via the AJAX "Add an entry" button.
- Reuse the `map_associative` form element in a custom form needing key/value input.
- Provide key/value metadata for an API-backed entity.
- Pre-fill key and value inputs with helpful placeholder text.
- Export the widget's size/placeholder settings with the form display config.
- Keep arbitrary settings inside one queryable `map` field instead of many fields.
- Drop empty pairs automatically so only meaningful entries are saved.
- Offer a lightweight alternative to Paragraphs for simple key/value data.
- Style the key/value rows with the shipped component CSS.
- Seed a fixed number of empty rows via the element's `#count` property.
- Repair legacy corrupted map values with the module's update hook.
- Set widget size and placeholders per field instance in code or on Manage form display.
- Let developers store serialized configuration on entities with an editor-friendly form.
