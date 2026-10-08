<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File to Media lets you turn an existing managed file into a Media entity. It exposes a Views field ("File to Media links") that renders a per-file "Create <media type>" dropbutton, and a route that opens the media add-form pre-populated with the chosen file.

---

The module adds two things and no configuration of its own. First, `hook_views_data_alter()` registers a Views field `file_to_media` on the `file_managed` table; the `ToMedia` field plugin renders a dropbutton with one "Create <label>" link per **compatible** media type. A media type is compatible when the current user has create access to it and its source field is a file field whose allowed `file_extensions` include the file's extension (checked via `FileToMediaAccessTrait::sourceFieldIsCompatible`). The link is hidden when the file is already used by a media entity (`file.usage` shows a `media` usage) or when the file is not publicly downloadable (`$file->access('download', anonymous)`), so it only offers to convert unused, public files. Second, the route `file_to_media.add_form` at `/file/to-media/{file}/{media_type}` (permission `access files overview`) builds a media entity of that type with the file assigned to the source field and returns its entity add-form, so the editor can fill in remaining fields and save. Access is re-checked in the controller: it throws Access Denied for a private file or a media type the user cannot create, and Not Found if the media type's source field does not accept that extension. There is no admin UI, settings, permission of its own, Drush, or config schema — you use it by adding the `file_to_media` field to a view of files.

---

- Add a "Create media" dropbutton to a view of files so editors can convert files into media items.
- Migrate a site's legacy managed files into proper Media entities one by one.
- Let content editors promote an uploaded file (PDF, image, document) to a reusable media item.
- Build an admin "Files" listing where each unused file offers a one-click media conversion.
- Offer conversion only to the media types whose source field accepts the file's extension.
- Expose the conversion link only for files not yet backed by a media entity.
- Prevent conversion of private files (only public, downloadable files get the link).
- Pre-fill the media add-form's source field with the selected file via the add route.
- Provide separate "Create Image" / "Create Document" actions per file based on compatible types.
- Clean up an "orphaned files" report by turning stray files into managed media.
- Give editors a media-creation path without the standard "upload again" step.
- Restrict who sees the conversion links using core media create permissions and `access files overview`.
- Seed a new Media Library from files that predate the site's move to media.
- Convert files referenced by old file fields into media for a field-to-media migration.
- Present the conversion action in a Views dropbutton alongside other file operations.
- Ensure conversions respect per-media-type create access via the entity access handler.
- Link directly to `/file/to-media/{file}/{media_type}` to start a specific conversion.
- Let a curator review each file's usage before deciding to create media from it.
- Avoid duplicate media by hiding the link once a file already has a media usage.
- Integrate file-to-media conversion into an existing custom Views-based file manager.
