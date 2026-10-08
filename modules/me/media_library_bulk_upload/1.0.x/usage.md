<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Library Bulk Upload adds a "Multiple upload" screen to Drupal's Media Library so editors can drop many files at once and turn each into a media entity of a chosen type.

---

Unlike the older `media_bulk_upload` module, this module does not ship DropzoneJS. Instead it reuses Drupal core's standard file-upload widget and the Media Library UI itself: it registers a custom Media Library "opener" (`media_library.opener.bulk_upload`) and renders the library's add-form for a single media type with unlimited cardinality, so an editor can upload a whole batch in one pass. A landing page at `/admin/content/media/bulk-upload` lists every media type the current user may bulk-upload; picking one opens `/admin/content/media/bulk-upload/{media_type}`, which is the media library scoped to that type. Access is governed by dynamic per-type permissions of the form `use media {type} bulk upload form`, plus `administer media` as a super-permission. A settings form (`/admin/config/media/media-library-bulk-upload-config`, config object `media_library_bulk_upload.settings`, key `media_types`) optionally limits which media types are offered; leaving it empty offers all of them. The module also hides the media library's row-selection column while on the bulk-upload route (via `hook_ENTITY_TYPE_load` on the `media_library` view) and, when Admin Toolbar Extra Tools is present, nests its menu link under Content → Media. It defines no plugin types, no Drush commands, and no theme templates of its own.

---

- Let editors upload dozens of images into the Media Library in a single operation instead of one entity at a time.
- Bulk-import a folder of documents (PDFs, spreadsheets) as Document media entities.
- Seed a fresh site's Media Library with a batch of stock photography.
- Give a photographer role rights to bulk-upload only the Image media type and nothing else.
- Restrict the bulk-upload feature to a curated subset of media types (e.g. only Image and Document) via the settings form.
- Offer a "Multiple upload" action link directly from the Media admin listing (`/admin/content/media`).
- Add a bulk-upload entry to the Media Library page (`/admin/content/media-library`) for content teams.
- Let a marketing team load a campaign's worth of banner images at once before attaching them to pages.
- Bulk-upload audio files as Audio media for a podcast or music library.
- Bulk-upload video files as Video media without touching the field widget on each node.
- Grant a role access to the bulk-upload landing page purely through per-type permissions, without giving `administer media`.
- Migrate a legacy image directory into media entities by uploading them in a few batches.
- Provide a self-service upload screen for a documentation team to add screenshots as media.
- Keep the familiar Media Library look-and-feel for uploads (no extra JS library to theme or maintain).
- Prepare media assets in advance so authors can later select them through normal media reference fields.
- Limit which roles can even see the bulk-upload option by configuring the dynamic permissions.
- Onboard a new client site by dumping their supplied asset pack into the Media Library quickly.
- Let a translator/localization team upload localized document variants in bulk.
- Add a bulk uploader for a specific custom media type you created (any type is auto-detected).
- Combine with Admin Toolbar Extra Tools so the bulk-upload link appears under Content → Media in the toolbar.
- Reduce clicks for editors who routinely add many assets per publishing cycle.
- Stage a large set of files as unpublished media for later review before use.
- Enforce that only Document and Image types are bulk-uploadable while hiding Video/Audio from the picker.
- Provide different roles different subsets of bulk-uploadable types through granular permissions.
