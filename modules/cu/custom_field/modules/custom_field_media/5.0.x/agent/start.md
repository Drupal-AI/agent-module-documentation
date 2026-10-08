<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Field - Media — agent index

Adds one Custom Field widget: **`media_library_widget`** ("Media library"), usable on a
Custom Field `entity_reference` **column whose `target_type` is `media`**. No config UI, no
routes, no permissions of its own.

- **Use the media library widget on a media entity_reference column (settings, `media_types`,
  where it's stored)** → [configure/media-widget.md](configure/media-widget.md)

Key facts:
- Widget id `media_library_widget` (class `MediaLibraryWidget extends EntityReferenceWidgetBase`,
  category "Media", `field_types: ['entity_reference']`). `isApplicable()` returns true only when
  the column's `getTargetType() === 'media'`.
- Per-column widget config lives at form-display component
  `settings.fields.<column>.type = 'media_library_widget'`, with optional
  `settings.fields.<column>.media_types` (sequence of allowed media type IDs, in order; empty =
  all allowed). The `media_types` schema key is added to `custom_field.field.*` via
  `hook_config_schema_info_alter()`.
- The column itself is a normal Custom Field `entity_reference` column with
  `target_type: media` in the field storage `columns` setting.
- Depends on `custom_field` + core `media_library`. Modal opener service
  `custom_field_media.opener.form_element`.
