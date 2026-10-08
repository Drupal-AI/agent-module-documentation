<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Collapses repeated file extensions in an uploaded filename by dropping any intermediate segment that matches an allowed extension, keeping the base name and the final extension.

---

Filename extension sanitization is a very small module (package Media) that reacts to Drupal core's file-upload name sanitization event. When a file is uploaded through core's managed file upload handler, the module inspects the filename between the base name and the final extension: for every intermediate `.`-separated segment whose lowercase value appears in the field's list of allowed extensions, it removes that segment. A name like `photo.jpg.png.JPEG.gif` (with jpg/png/jpeg/gif all allowed) collapses to `photo.gif`, and a duplicated name like `image.jpeg.jpeg` collapses to `image.jpeg`. When at least one segment is removed the module rewrites the filename and shows the status message "File was renamed due to multiple file extensions." The base name (first segment) and the final extension (last segment) are always preserved. The module registers exactly one service — an event subscriber on `FileUploadSanitizeNameEvent` — and ships no routes, permissions, config, forms, schema, entities, hooks or Drush commands. It runs alongside core's own filename sanitization (transliteration, munging, allowed-extension validation) as defense-in-depth cleanup, and its main practical benefit is avoiding broken image derivatives that repeated extensions can produce (for example with imageapi_optimize_webp).

---

- Clean up uploaded filenames that carry the same extension more than once (`image.jpeg.jpeg` becomes `image.jpeg`).
- Collapse a chain of allowed extensions down to the single final one (`file.jpg.png.gif` becomes `file.gif`).
- Prevent faulty image derivatives caused by duplicated extensions when using imageapi_optimize_webp.
- Avoid broken derivative links where the generated path and the on-disk filename disagree.
- Normalize filenames automatically on upload without any per-field configuration.
- Apply the cleanup consistently across all upload paths that use core's managed file upload handler.
- Add defense-in-depth filename hygiene on top of core's built-in upload sanitization.
- Tidy filenames produced by users who append extensions manually before saving.
- Keep media library and file-field uploads free of redundant extension segments.
- Reduce confusing filenames in the file listing and media admin views.
- Preserve the meaningful base name and the real trailing extension while stripping redundancy.
- Notify the uploading user with a status message whenever a filename was rewritten.
- Handle mixed-case duplicate extensions (`x.JPG.jpg`) by comparing extensions case-insensitively.
- Keep the module dependency-free — it needs only Drupal core (8 through 11).
- Enable it site-wide by simply installing the module; there is nothing to configure.
- Rely on the field's own allowed-extensions list to decide which segments count as extensions.
- Improve interoperability with modules that build filenames from the uploaded extension.
- Reduce the risk of ambiguous multi-extension filenames entering the file system.
- Standardize filename hygiene across multiple sites via a single reusable module.
- Remove the module and clear caches to restore core's default (untouched) upload naming.
