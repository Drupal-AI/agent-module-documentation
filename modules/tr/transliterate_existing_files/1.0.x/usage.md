<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Transliterate Existing Files retro-applies Drupal core's configured filename sanitization (transliteration, whitespace/non-alphanumeric replacement, deduplication, lowercasing) to files that were uploaded before those settings were in place.
---
The module is Drush-only: `transliterate:existing-files` (alias `tef`) runs a batch over every file entity, computes the sanitized filename with a port of core's `FileEventSubscriber::sanitizeFilename()` (reading `file.settings` → `filename_sanitization.*`), and for files whose name changes it renames the file on disk (`rename($fileUri, $sanitizedUri)`), updates the file entity's URI/filename, and — with `--redirect` and the Redirect module enabled — creates a 301 from the old URL to the new one. A `--dry-run` option reports what would change without touching anything.

Security posture: there is no route, controller, form, permission or web endpoint — the only trigger is the Drush CLI, which is inherently restricted to shell/deploy operators, so it is not remotely reachable. Renaming operates on each file entity's own stored URI within its existing stream scheme (e.g. `public://`), and the new name is derived from the existing filename via `str_replace`, not from external request input, so there is no request-driven path-traversal surface. Operators should still run `--dry-run` first (renames are on-disk and, without `--redirect`, break old URLs) and take a backup. The entity query uses `accessCheck(FALSE)`, which is acceptable for a privileged maintenance command.
---
- Dry-run to preview which existing files would be renamed: `drush tef --dry-run`.
- Apply configured transliteration to all existing files: `drush tef`.
- Create 301 redirects for renamed files: `drush tef --redirect`.
- Normalize legacy filenames with non-ASCII characters to ASCII.
- Retroactively enforce a new file.settings sanitization policy.
- Lowercase existing filenames per sanitization config.
- Replace whitespace/special characters in old filenames.
- Deduplicate separators in historical filenames.
- Fix files uploaded before transliteration was enabled.
- Avoid broken links by pairing renames with the Redirect module.
- Run as part of a deployment/maintenance script.
- Batch-process large file tables via drush_backend_batch_process.
- Skip files whose sanitized name is unchanged automatically.
- Detect collisions where a sanitized name already exists (logged, skipped).
- Update file entity URI and filename after rename.
- Audit filename changes before committing with dry-run output.
- Keep public:// file names portable across case-insensitive filesystems.
- Report the count of processed files after a run.
- Restrict execution to CLI/deploy operators (no web trigger exists).
