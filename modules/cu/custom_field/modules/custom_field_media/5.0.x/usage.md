<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom Field - Media adds a **Media library** widget (`media_library_widget`) so an `entity_reference` column of a Custom Field that targets media entities can be filled from Drupal's core Media Library UI.

---

The submodule contributes a single `custom_field_widget` plugin, `media_library_widget` (label "Media library", category "Media"), extending `EntityReferenceWidgetBase`. It is only applicable to a Custom Field `entity_reference` subfield **column whose `target_type` is `media`** (`isApplicable()` checks `getTargetType() === 'media'`). On the Custom Field's *Manage form display*, that column's widget can then be set to Media library, opening the standard core media-library modal (via a `MediaLibraryOpener` service, `custom_field_media.opener.form_element`) to browse and select media items. A widget setting `media_types` (added to the `custom_field.field.*` config schema by a `hook_config_schema_info_alter()` in `ConfigSchemaHooks`) restricts and orders which media bundles are selectable; when empty, all target bundles allowed by the reference are shown. It stores nothing new on the field itself beyond the per-column widget config — the referenced media IDs live in the parent Custom Field's `entity_reference` column. It requires the parent `custom_field` module and core `media_library`.

---

- Add an "image" column to a Custom Field and let editors pick it from the Media Library.
- Build a compound "hero" field with a media reference column plus a headline string column.
- Reference a document/PDF media item from a Custom Field column via the media modal.
- Restrict a media column to only the `image` media type using the `media_types` widget setting.
- Allow several media bundles (image, video) on one column and control their display order.
- Replace a separate media reference field with a single Custom Field that bundles media + metadata.
- Let content authors upload/select media inline while filling other Custom Field columns.
- Attach a "logo" media reference alongside "name" and "url" columns in a partner Custom Field.
- Use the media library modal instead of an autocomplete for media entity_reference columns.
- Configure the widget per form mode (e.g. media library on default, hidden on a teaser form).
- Curate a gallery-style Custom Field where each row references a media image.
- Reference a remote/oEmbed video media item from a Custom Field column.
- Keep media selection consistent with the rest of the site by reusing core Media Library.
- Migrate a Paragraph "media + caption" pattern into one Custom Field with a media column.
- Set allowed media types so editors can only choose brand-approved media bundles.
- Show a thumbnail preview of the selected media in the Custom Field widget.
- Combine a media reference column with a link column for "media + call-to-action" blocks.
- Deploy the media column + widget purely via exported field storage and form-display config.
- Provide an author-friendly picker for an entity_reference(media) column without custom code.
- Reference audio media in a Custom Field for a podcast-episode content model.
