<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Entity Modify — agent index

**Experimental** submodule of `media_library_media_modify`. It brings the same contextual
field overrides to plain (non-media) entity reference fields through an **autocomplete
widget**, instead of the media library. No configure route, no permissions, no Drush.

- **The autocomplete-with-override widget and its setting** →
  [configure/widget.md](configure/widget.md)

Key facts:
- Widget `entity_reference_autocomplete_with_override` ("Autocomplete (with override)"),
  `field_types: [entity_reference_entity_modify]`, extends core
  `EntityReferenceAutocompleteWidget`.
- Only extra setting: `form_mode` (config schema
  `field.widget.settings.entity_reference_autocomplete_with_override`).
- The override element + button come from the parent service
  `media_library_media_modify` (`EntityReferenceOverrideService::formElement()`); all storage
  and the read-only guard live in the parent module.
- Depends on `media_library_media_modify`. Marked `experimental: true` in info.yml.
