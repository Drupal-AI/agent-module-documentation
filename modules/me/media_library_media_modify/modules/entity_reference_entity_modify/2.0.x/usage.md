<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Entity Modify is an experimental submodule of Media Library Media Modify that extends the same contextual-override mechanism to plain (non-media) entity reference fields via an autocomplete widget.

---

The submodule adds a single field widget, `entity_reference_autocomplete_with_override` ("Autocomplete (with override)"), for `entity_reference_entity_modify` fields. It extends core's `EntityReferenceAutocompleteWidget` and, on top of the normal autocomplete element, calls the parent module's `EntityReferenceOverrideService::formElement()` to add the hidden `overwritten_property_map` element and the "Override … in context of this …" button — so an editor can override the referenced entity's fields per placement, exactly like the media-library widget but without the media library UI. It exposes one extra setting, `form_mode`, choosing the form mode used by the override modal. It also implements `hook_field_widget_info_alter()` to advertise a few core entity-reference widgets for the override field type. All the storage, read-only guard and render-time override logic live in the parent module; this submodule is purely the autocomplete-widget front end and is marked **experimental**.

---

- Add contextual overrides to a non-media entity reference (e.g. a reference to another node or taxonomy term).
- Let editors tweak a referenced entity's fields per placement using a plain autocomplete field instead of the media library.
- Provide per-context overrides on a "related content" node reference field.
- Choose the override form mode used by the autocomplete widget (`form_mode` setting).
- Override a referenced term's label/description only in the context of one host entity.
- Use the same JSON `overwritten_property_map` override storage on non-media references.
- Attach contextual overrides to a paragraph's entity reference field via autocomplete.
- Keep the referenced entity read-only while presenting per-placement overrides (inherited guard).
- Offer contextual overrides where the media library widget is unsuitable (non-media targets).
- Migrate a plain entity_reference field to the modify type (parent Drush command) then use this autocomplete widget for editing.
- Give content editors a lightweight override UI without a modal media browser.
- Apply per-instance overrides to a user or custom-entity reference field.
- Present a different display title for the same referenced entity on different host pages.
- Combine autocomplete selection and contextual override in one widget.
- Prototype contextual-override UX for arbitrary entity references (experimental).
