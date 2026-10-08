<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Exif Manipulate strips EXIF metadata from JPEG and TIFF images on upload using the pure-PHP fileeye/pel library, while preserving the orientation tag.

---

Exif Manipulate is a privacy hardening module that removes EXIF metadata (GPS coordinates, camera model,
timestamps and similar embedded data) from uploaded images before they are stored and served. It hooks
into `hook_file_insert()` so every newly created `file` entity whose MIME type is `image/jpeg` or
`image/tiff` is opened with the `fileeye/pel` PHP library, has its EXIF block cleared, and is saved back
in place — no external binary (exiftool/ImageMagick) and no shell command are involved. The single EXIF
tag it deliberately keeps is the orientation value, so images still display the right way up and the
companion `exif_orientation` module keeps working. An optional confirm form at
`/admin/config/media/exif_manipulate` (permission `administer exif manipulate`) lets an administrator
queue images already stored under a public-files directory so the same cleaning is applied retroactively
via cron (QueueWorker `exif_manipulate_clean_exif_data`, `time = 60`). The module has no config object,
no fields and no formatters; it processes files transparently and its only state is the retroactive
queue plus a progress counter in Drupal state.

---

- Automatically clean EXIF metadata from every image users upload.
- Strip GPS location coordinates from photos before they are published.
- Remove camera and device model information from uploaded images.
- Remove capture timestamps embedded in image files.
- Protect the privacy of the people and places in user-submitted photos.
- Prevent leaking the location where a photo was taken through public galleries.
- Sanitize avatars, gallery images and form submissions on upload.
- Apply a positive privacy control to any image upload flow (fields, media, Webform).
- Keep the EXIF orientation tag intact so images stay correctly rotated.
- Pair with the `exif_orientation` module without conflict (orientation is preserved).
- Clean JPEG (`image/jpeg`) uploads.
- Clean TIFF (`image/tiff`) uploads.
- Retroactively clean images that were uploaded before the module was enabled.
- Queue an existing public-files directory for background EXIF cleaning via cron.
- Watch clean-up progress on the confirm form (X of Y files cleaned).
- Strip metadata without invoking any external binary or shell command (pure PHP via PEL).
- Meet GDPR / privacy requirements for photo metadata on public sites.
- Harden image handling on sites that accept anonymous or member photo uploads.
- Log a warning (module logger channel) when an image's EXIF block cannot be processed.
- Restrict retroactive cleaning to trusted administrators via the `administer exif manipulate` permission.
- Run cleaning as a background QueueWorker so large directories do not block a request.
- Extend the processor service (`FileExifProcessorInterface`) toward inserting metadata, not only stripping it.
