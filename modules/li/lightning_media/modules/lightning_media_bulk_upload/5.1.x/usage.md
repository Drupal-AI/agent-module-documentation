<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bulk Media Upload adds a single admin form at `/admin/content/media/bulk-upload` that uses DropzoneJS to accept many files at once and turns each one into the media entity type that Lightning Media's input matching says it belongs to.

---

The module is one route, one form class and one install hook. `lightning_media_bulk_upload.routing.yml` declares `lightning_media.bulk_upload` at `/admin/content/media/bulk-upload` with the requirement `_permission: 'dropzone upload files,create media'` — note the comma, which in Drupal routing means **both** permissions are required, so a role with only one of them still gets a 403. `lightning_media_bulk_upload.links.action.yml` puts a "Bulk upload" action link on the media collection (`entity.media.collection`) and on the media library page (`view.media_library.page`). `Drupal\lightning_media_bulk_upload\Form\BulkUploadForm` renders a `dropzonejs` element whose accepted extensions come from `MediaHelper::getFileExtensions()` — the union of every media type the current user may create — then, on submit, builds an unsaved media entity per file with `MediaHelper::createFromInput()`, attaches the file with `MediaHelper::useFile()` and steps the editor through the remaining metadata. The module depends on the contrib `dropzonejs` module (and its Dropzone JS library); `hook_install()` grants `dropzone upload files` to the `media_creator` role, and `lightning_media_bulk_upload_update_9001()` will download the Dropzone library into `/libraries` if the libraries directory file finder cannot find it.

---

- Let a photo editor upload 40 images in one drag-and-drop instead of 40 separate forms.
- Migrate a folder of PDFs into the media library in a single pass.
- Onboard a new site's asset library quickly after launch.
- Give editors a "Bulk upload" action link straight from the media overview page.
- Give editors the same action link from the media library page.
- Upload a mixed batch of images, documents and audio and let input matching sort them out.
- Restrict bulk uploading to a role that has both `dropzone upload files` and `create media`.
- Deny bulk upload to a role that has `create media` but not the DropzoneJS permission.
- Constrain what can be uploaded by narrowing each media type's source-field extension list.
- Use a locally hosted Dropzone library instead of a CDN copy for CSP-strict sites.
- Let contractors dump deliverables into the media library without touching content forms.
- Bulk-upload a product photo set before wiring it into a catalogue.
- Speed up editorial workflows where every article needs several new assets.
- Combine with Lightning Media Image so uploaded photos land on the Image media type.
- Combine with Lightning Media Document so uploaded PDFs land on the Document media type.
- Combine with Lightning Media Audio/Video so media files land on the right type by extension.
- Keep bulk-uploaded assets out of the library until reviewed via `field_media_in_library`.
- Give a marketing team a single URL to bookmark for asset ingestion.
- Audit who can bulk upload by checking which roles hold both required permissions.
- Grant the capability to a temporary role during a content migration and remove it after.
- Pre-populate a staging site with realistic assets quickly.
- Avoid writing a custom multi-upload form for every project.
- Use the action link to discover the feature without training editors on a URL.
- Verify route access programmatically with the access manager before exposing the link.
