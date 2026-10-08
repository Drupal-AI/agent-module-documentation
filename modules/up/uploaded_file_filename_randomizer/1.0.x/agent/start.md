<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Uploaded File Filename Randomizer (uploaded_file_filename_randomizer) — agent index

**Renames every uploaded file to a random 32-character machine name (extension preserved) via the core sanitize-name event.**

- **Version:** 1.0.x  (info.yml `1.0.2`)
- **Core:** ^10 || ^11
- **Service:** `uploaded_file_filename_randomizer.event_subscriber` (`src/EventSubscriber/UploadedFileFilenameRandomizerSubscriber.php`)
- **Listens to:** `Drupal\Core\File\Event\FileUploadSanitizeNameEvent`
- **Config:** none (works immediately on enable)

**Security:** This *is* a security-hardening module (OWASP file-upload guidance). No routes, permissions, or config. It only rewrites the sanitized filename to `Random::machineName(32)` + original extension. Note it keeps the original extension, so it is a naming-hardening measure, not an extension/MIME allow-list. `Random::machineName()` is used for unpredictability of names (not as a security token). No anonymous or mutating endpoints introduced.
