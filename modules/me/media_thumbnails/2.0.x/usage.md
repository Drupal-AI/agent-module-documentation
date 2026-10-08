<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Thumbnails is a plugin framework that generates real thumbnail images for media entities whose file types core cannot preview — PDF, SVG, ePub, video, Office documents — by dispatching on the source file's MIME type.

---

The module ships **no thumbnail generators of its own**: it provides the `media_thumbnail` plugin type (annotation `@MediaThumbnail`, directory `Plugin/MediaThumbnail`, interface `MediaThumbnailInterface`, base class `MediaThumbnailBase`, manager service `plugin.manager.media_thumbnail`) and the glue that calls them. Each plugin declares an `id`, a `label` and a `mime` array; on construction the manager flattens all definitions into a MIME → plugin-id map, so lookup is a single array access. `hook_ENTITY_TYPE_presave()` on media entities does the routing: on a *new* entity a thumbnail is generated when the media is an `image` bundle or when the thumbnail still points at the source plugin's `default_thumbnail_filename`; on an *update* the thumbnail is regenerated, unless the `no_thumbnail_update` setting is on — in which case it is only rebuilt when the current thumbnail is still a generic media icon. `hook_ENTITY_TYPE_delete()` removes the generated file, but never deletes a thumbnail that is referenced by more than one entity or that lives under `media.settings:icon_base_uri`. A plugin only has to implement `createThumbnail($sourceUri)` and return a managed `File`; the manager handles loading the source file, passing the whole `media_thumbnails.settings` array as plugin configuration, assigning the file to the media entity, and logging failures to the `media thumbnails` channel. Global settings (`width`, `bgcolor_active`, `bgcolor_value`, `no_thumbnail_update`, `allow_thumbnail_edit`) live at `/admin/config/media/thumbnails`; a confirm form at `…/refresh` and the Drush command `thumbnails:refresh` re-save every media entity in a batch to regenerate thumbnails wholesale. Turning on `allow_thumbnail_edit` makes the media `thumbnail` base field display-configurable so editors can upload their own.

---

- Show a real page-1 preview for PDF media instead of a generic file icon.
- Render SVG media as raster thumbnails in the media library.
- Generate poster frames for video media entities.
- Produce thumbnails for ePub covers in a publications library.
- Give Word/Excel/PowerPoint media a recognisable preview image.
- Write a custom `@MediaThumbnail` plugin for an in-house file format.
- Watermark generated thumbnails by post-processing inside a custom plugin.
- Store thumbnails in a public stream even when the source media is private.
- Set a site-wide thumbnail width (height is derived) from one settings page.
- Flatten transparent thumbnails onto a fixed background colour for consistent grids.
- Keep transparency instead, by leaving the background-colour checkbox off.
- Regenerate every thumbnail after changing the width, via the Refresh confirm form.
- Do the same from CI or cron with `drush thumbnails:refresh`.
- Prevent editors' hand-uploaded thumbnails from being overwritten on save (`no_thumbnail_update`).
- Still auto-rebuild thumbnails that are only the generic media icon, while protecting custom ones.
- Let editors upload or replace a thumbnail manually by enabling `allow_thumbnail_edit` and adding the field to the form display.
- Restore core's default thumbnails by uninstalling the plugin modules and re-running the refresh batch.
- Map several MIME types to one plugin by listing them all in the annotation.
- Override which plugin handles a MIME type with `hook_media_thumbnails_media_thumbnail_info_alter()`.
- Restrict who can change thumbnail settings with the `manage media thumbnails settings` permission.
- Diagnose generation failures from the dedicated `media thumbnails` logger channel.
- Skip remote/oEmbed media automatically — only local file sources are processed.
- Combine with image styles so the generated thumbnail feeds normal responsive image handling.
- Bulk-refresh after migrating media files into a new file system.
- Check programmatically whether a media entity has a thumbnail plugin with `hasPlugin()`.
