<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Clean Filename keeps the newest upload's clean, unsuffixed filename by suffixing the older file.

---

Clean Filename reverses Drupal's default file-conflict naming. Normally a new upload that collides
with an existing file gets a numeric suffix (`document_0.pdf`) while the old file keeps the clean
name. This module flips that: the existing file is renamed to the next free `_N` suffix and the new
upload keeps the clean `document.pdf` name, so the latest file always has the clean URL. It does
NOT sanitize, transliterate, or otherwise rewrite characters in filenames — that stays core's job.

Enabled per field (file/image/media) via a field-config checkbox, and per text format for CKEditor
image uploads via the "Clean Filename for CKEditor" filter. Administration is gated by
`administer clean filename`. Depends on core `file`, `field`, and `system`; supports Drupal 10 and 11.

---

- Reverse core's conflict-suffix naming.
- Keep the newest upload's clean filename.
- Rename the pre-existing file to `_N`.
- Give the latest file the clean URL.
- Preserve older files under a suffix.
- Enable per file/image/media field.
- Enable per text format for CKEditor uploads.
- Toggle via a field-config checkbox.
- Toggle via the CKEditor filter.
- Gate admin with `administer clean filename`.
- Depend on core `file`, `field`, `system`.
- Support Drupal 10 and 11.
- Do not alter extensions.
- Do not sanitize characters.
- Manage numeric suffixes automatically.
- Improve clean-URL consistency.
- Handle file, image, media uploads.
- Log operations on channel `clean_filename`.
