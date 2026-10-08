<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Transliterate Existing Files (transliterate_existing_files) — agent index

**Drush command to apply the site's configured filename sanitization/transliteration to already-uploaded files, optionally adding 301 redirects.**

- **Version:** 1.0.x
- **Core:** ^10.2 || ^11
- **Dependencies:** file (optional: redirect, for `--redirect`)
- **Command:** `transliterate:existing-files` (alias `tef`), options `--dry-run`, `--redirect` — `src/Drush/Commands/TransliterateExistingFilesCommands.php`
- **Service:** `transliterate_existing_files` → `TransliterateExistingFiles` (batch: `batchTransliterate` / `transliterateFile`)
- **Logic:** ports core `FileEventSubscriber::sanitizeFilename()`, reads `file.settings.filename_sanitization.*`
- **Routes/permissions:** none.

**Security:** CLI-only; no route/controller/form/permission, so not remotely reachable. `rename()` acts on each file's own stored URI within its scheme; the new name is derived from the existing filename (not request input), so no external path-traversal surface. Entity query uses `accessCheck(FALSE)` — acceptable for a privileged maintenance command. Run `--dry-run` and back up first.

See [drush/transliterate.md](drush/transliterate.md)
