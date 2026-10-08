<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lightning Media — agent index

Media authoring layer for core Media. Depends on core `image`, `media_library`, `user` and
on `drupal/lightning_core:^6`. **Defines no plugin type, no permission and no Drush
command.** One settings form: `configure` = `lightning_media.settings` →
`/admin/config/system/lightning/media`.

- **Settings, shipped config (view modes, fields, roles, format, pathauto), how to read it
  off a live site** → [configure/settings.md](configure/settings.md)
- **`lightning.media_helper`, `InputMatchInterface`, `MediaHelper`, `Override`, the
  hooks it implements** → [api/media-helper.md](api/media-helper.md)
- **The plugins it *implements*: Entity Browser widgets, the `media_image` Entity Embed
  display, the `upload` / `interactive_upload` / `ajax_upload` form elements, image widget
  third-party settings** → [plugins/implemented-plugins.md](plugins/implemented-plugins.md)
- **`media_creator` / `media_manager` roles and what they grant** →
  [permissions/roles.md](permissions/roles.md)

Submodules (each has its own doc tree under `modules/`):
`lightning_media_audio`, `lightning_media_bulk_upload`, `lightning_media_document`,
`lightning_media_image`, `lightning_media_instagram`, `lightning_media_slideshow`,
`lightning_media_twitter`, `lightning_media_video`.

Two facts that explain most of the module:

1. **Input matching.** A media source plugin implementing
   `Drupal\lightning_media\InputMatchInterface::appliesTo($value, $media_type)` can claim an
   arbitrary file / URL / embed code. Every submodule's job is to subclass the core source
   plugin, mix in that interface, and register the subclass via
   `hook_media_source_info_alter()` + `Override::pluginClass()`.
2. **`field_media_in_library`.** Every media type created while this module is enabled gets
   a boolean `field_media_in_library` (default TRUE) plus a checkbox on the media form;
   `hook_views_pre_view()` filters the `media_library` widget displays to items where it is
   `1`.
