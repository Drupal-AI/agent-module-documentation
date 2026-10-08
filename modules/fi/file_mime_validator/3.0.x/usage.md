<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File Mime Validator adds a server-side upload check that detects a file's real MIME type from its content and compares the resulting category against the category implied by the filename, so an upload whose bytes do not match its extension can be rejected rather than trusted.

---

Drupal's file field validates the extension, and the extension is chosen by whoever uploads the file, so a payload named `photo.jpg` satisfies an extension check even when its content is something else. This module adds the missing step: it implements `hook_file_validate()` (`file_mime_validator_file_validate()`), which delegates to the `file_mime_validator` service. The service's `checkRealMime()` derives the file's real MIME type from its content with Symfony's `FileinfoMimeTypeGuesser` (PHP `finfo` / libmagic reading the actual bytes), sorts both the filename MIME and the detected MIME into one of five categories — text, image, compression, audio, video — and returns an error when the categories disagree. The five category lists live in the `file_mime_validator.settings` config object (keys `file_mime_validator_text`, `file_mime_validator_image`, `file_mime_validator_compression`, `file_mime_validator_audio`, `file_mime_validator_video`), each a comma-separated MIME list you can extend from the settings form or with drush. Mismatches and unrecognised types are written to the `file_mime_validator` logger channel. The module has no dependencies, targets core `^10 || ^11`, and defines no permissions, drush commands, or plugin types.

---

- Reject a script renamed to `.jpg` whose real content is not an image.
- Validate the true content type of uploaded files, not just the extension.
- Harden a public file or image field as defence-in-depth.
- Stop extension-spoofed uploads on any entity's file field.
- Enforce a category mapping of extension to MIME type.
- Protect an image field from non-image content.
- Complement Drupal's extension allow-list with a content check.
- Add an upload-validation layer without writing custom code.
- Configure which MIME types count as text / image / compression / audio / video.
- Extend the allowed-MIME lists so they stay current with new formats.
- Log uploads whose detected type disagrees with their extension.
- Audit which MIME categories a site accepts.
- Apply the same content check across every file field site-wide.
- Set the MIME category lists via drush in a deployment pipeline.
- Read the current MIME configuration with `drush cget`.
- Detect a document uploaded under a mismatched extension.
- Reject a compressed archive disguised as a media file.
- Catch mismatches introduced by a content migration.
- Support an upload-security remediation item from a review.
- Understand the validation flow by reading the service's `checkRealMime()` method.
