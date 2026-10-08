<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Library Media Modify lets editors store per-instance ("contextual") overrides of a referenced media item's fields directly from the media library widget, so the same media entity can render differently on each piece of content that references it, without changing the media entity itself.

---

The module ships three things. (1) A field type `entity_reference_entity_modify` ("Media with contextual modifications") — an entity-reference field (defaulting to `target_type: media`) with an extra `overwritten_property_map` text column holding a JSON map of field overrides; when the referenced entity is loaded through this field, the field type's `__get()` clones it and applies the overrides for display only. (2) A field widget `media_library_media_modify_widget` ("Media library extra") that extends core's Media Library widget and adds an "Override … in context of this …" button per selected item plus widget settings (`form_mode`, `multi_edit_on_create`, `no_edit_on_create`, `check_selected`, `replace_checkbox_by_order_indicator`); it also works on plain `entity_reference` media fields to add a simple per-item edit link. (3) A Views field `media_library_media_modify_edit_link` ("Edit link for the Media Library") that adds an edit button inside a media-library view. A Drush command `media_library_media_modify:migrate` converts an existing `entity_reference` field to `entity_reference_entity_modify`. Overrides never mutate the source media: a `hook_entity_presave` throws `ReadOnlyEntityException` if an override-loaded entity is saved, and the override form's access is the referenced entity's `view` access. The experimental `entity_reference_entity_modify` submodule adds an autocomplete override widget so the same contextual-override mechanism works for non-media entity references too.

---

- Give a hero image a different alt text or caption on each article that references it, without duplicating the media item.
- Override a media item's title only in the context of one specific page.
- Show the same reusable image cropped/described differently per landing page.
- Add a "Media with contextual modifications" field to a content type for context-aware media references.
- Select media from the library and immediately open an override form to tweak fields for that placement.
- Choose which form mode the override form uses (per widget, via the `form_mode` setting).
- Configure the widget to skip the edit form after creating a new media item (`no_edit_on_create`).
- Show a single combined edit form for all newly created media items at once (`multi_edit_on_create`).
- Pre-check already-selected items in the media library when reopening the widget (`check_selected`).
- Replace the media-library selection checkbox with an order indicator for ordered galleries (`replace_checkbox_by_order_indicator`).
- Add an "Edit link for the Media Library" Views field so editors can edit media inline from the library modal.
- Add a simple per-item edit link to a plain `entity_reference` media field via the "Media library extra" widget.
- Migrate an existing entity_reference media field to support contextual overrides with `drush media_library_media_modify:migrate`.
- Keep the canonical media entity untouched while letting each usage present its own overrides (source stays read-only).
- Store overrides as a JSON property map on the referencing entity, so they travel with that entity's revision.
- Use content translation with contextual overrides by making the modify field translatable (per-language overrides).
- Present per-context video oEmbed overrides (e.g. a different display title) using the media library.
- Let editors override file/image media source display without granting them edit access to the media entity.
- Build ordered media galleries where selection order is captured via the order indicator.
- Apply the same override to multiple new uploads in one form to speed up bulk media entry.
- Compare original vs overridden field values with the optional `diff` integration.
- Extend contextual overrides to any entity reference (not just media) with the `entity_reference_entity_modify` submodule's autocomplete widget.
- Programmatically read/apply overrides via the `media_library_media_modify` (EntityReferenceOverrideService) service.
