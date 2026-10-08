<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Media (entity_reference_media) — agent index

Provides one custom **field type** `entity_reference_media` ("Media Enhanced") — an entity-reference-to-media
field that also stores **per-reference** metadata: a caption and a video start/end time. The point is that
the *same* media item can be shown with a different caption / start-end each place it is referenced, without
touching the shared media entity. It ships the matching widget (`entity_reference_media_library`, a subclass
of the core Media Library widget) and formatter (`entity_reference_media_entity`, a subclass of the core
Rendered-entity formatter) plus a media-library **opener service** so the modal works with the custom field
type. On display, the formatter writes the per-reference values onto configured fields of the referenced
media entity (in memory only) before rendering it.

- Depends on: `drupal:media`, `drupal:media_library`. No composer libraries; no PHP constraint declared.
- Core: `^8.8 || ^9 || ^10 || ^11`. Package: `Media`. Release **1.0.0-rc7** (release candidate).
- No settings page / `configure` route — all configuration is per field instance (field settings) and per
  form/view display (widget & formatter settings). No permissions, no drush, no config schema of its own,
  no hooks, no routes. Defines **no** plugin *types* (only instances of core field-plugin types).
- One service: `entity_reference_media.opener.field_widget` (tagged `media_library.opener`).

## What you'd do → where

- **Add/configure the field, enable caption & start/end per media bundle, choose which media fields the
  formatter overrides, or wire it up from code** → [fields/reference-media.md](fields/reference-media.md)
- **Understand the media-library opener / access check** → [fields/reference-media.md](fields/reference-media.md)

## Key facts (real machine names)

- Field type: `entity_reference_media` (class `EntityReferenceMedia`, label "Media Enhanced", category
  "Reference"; storage forced to `target_type=media`).
- Field widget: `entity_reference_media_library` (class `EntityReferenceMediaWidget`, `multiple_values=TRUE`).
- Field formatter: `entity_reference_media_entity` (class `EntityReferenceMediaFormatter`, label "Rendered entity").
- Extra field columns/properties: `default_caption` (bool), `custom_caption` (text), `default_start_end`
  (bool), `video_start` (float), `video_end` (float).
- Field-settings keys: `field_caption` (default TRUE), `field_start_end` (default FALSE) — stored as
  per-media-bundle checkbox maps.
- Formatter-settings keys: `custom_caption`, `video_start`, `video_end` — each a per-bundle map to a media
  field to override (plus inherited `view_mode` / `link`).
- Service: `entity_reference_media.opener.field_widget` (`CustomMediaLibraryFieldWidgetOpener`, extends core
  `MediaLibraryFieldWidgetOpener`, arg `@entity_type.manager`).
- Update hook: `entity_reference_media_update_8001` (back-fills start/end columns on existing field tables).
