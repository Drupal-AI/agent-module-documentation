<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Prevents loss of inline images in rich-text fields by validating them and optionally downloading external images into local file entities on entity save.

Authors frequently paste `<img>` tags pointing at external URLs (or temporary editor URLs) into WYSIWYG content; those links later break. Inline Image Saver hooks `hook_entity_presave()` and `hook_field_info_alter()` to process configured text formats. It can (1) **validate** inline images and reject external ones (with options to allow data-URIs, allow images that are downloadable, check the file exists, check MIME type, and validate the image URL against the file entity), (2) **download** external images via the Guzzle HTTP client and save them as local file entities (optionally reusing an existing file by hash with File Hash support), and (3) **replace** still-broken images with configurable admin-filtered fallback markup. It can create a new revision with a custom log message when images are replaced, and skips processing during config/content sync.

The admin form lives at `/admin/config/content/inline-image-saver/settings` (route `inline_image_saver.settings`, permission `administer site configuration`). Defaults: validation, download, and revision creation on; replace off. MIME detection uses a tagged `inline_image_mime_guesser` service collector (fileinfo/binary resolvers). When download is enabled, saving an entity fetches the `<img src>` URL in the content (`InlineImageSaver::downloadImage()`).
---
Downloads and validates externally-hosted inline images so they don't break, storing them locally.
---
- Select which text formats are processed under Processable formats.
- Reject external inline images by enabling validation.
- Automatically download external `<img>` images to local files on save.
- Replace unrecoverable broken images with fallback markup.
- Allow inline base64 `data:` URI images to pass validation.
- Allow external images only when they can be downloaded and stored.
- Verify the referenced image file actually exists on disk.
- Check that a stored image has a valid, supported MIME type.
- Validate that an image URL matches its file entity URL.
- Include or exclude query parameters in URL validation.
- Reuse an existing file by content hash to avoid duplicates.
- Integrate File Hash module for better duplicate matching.
- Create a new revision when images are replaced, with a log message.
- Customize the revision log message for image replacements.
- Skip processing during programmatic entity synchronization.
- Configure admin-filtered fallback markup with `@src`/`@alt` placeholders.
- Fix broken editor image links migrated from another site.
- Localize hotlinked images to remove third-party dependencies.
- Disable download but keep validation to hard-block external images.
- Add a custom MIME resolver via the `inline_image_mime_guesser` tag.
- Prefer reusing files to save disk space on repeated pastes.
- Audit content integrity by enabling check-file-exists validation.
- Turn the whole feature off per text format by leaving it unprocessed.