<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform media (webform_media) — agent index

Registers a **media source** plugin (`webform_media`) so a Webform can be stored and reused as a
media entity. You create a "Webform" media type whose source field is a webform entity-reference;
editors then add media that point at a webform and embed/reference them like any other media
(CKEditor Media Library button, media reference fields, media view modes, media usage tracking).

- Dependencies: core `media` and `webform:webform`. The Media Library "quick add" form also needs
  core `media_library` enabled to work.
- No settings page, no routes, no permissions, no drush, no hooks, no services of its own. Setup is
  done entirely through core's Media Type UI — `configure` is null.
- Requirements are tight, check before recommending: `php >= 8.3`, core `^10.5 || ^11.2`, and
  `drupal/webform ^6.2@beta` (a beta constraint — composer will pull a beta Webform to satisfy it).

Solution docs:
- **Set up the Webform media type + read its config** → [configure/media-type.md](configure/media-type.md)
- **How the media source plugin works (id, metadata, add form)** → [plugins/media-source.md](plugins/media-source.md)

Key facts:
- Media source plugin id `webform_media`, class `Drupal\webform_media\Plugin\media\Source\Webform`
  (extends `MediaSourceBase`), `allowed_field_types: ['webform']`,
  `default_thumbnail_filename: no-thumbnail.png`, `thumbnail_alt_metadata_attribute: thumbnail_alt_value`.
- Per-media-type config object: `media.source.webform_media` (schema base type
  `media.source.field_aware`).
- Media Library add form: `Drupal\webform_media\Form\WebformMediaAddForm`, form id
  `webform_media_library_webform_add`, exposes a select `field_media_webform_media`.
- Source-field metadata attribute `default_name` = the referenced webform's `label()`.
