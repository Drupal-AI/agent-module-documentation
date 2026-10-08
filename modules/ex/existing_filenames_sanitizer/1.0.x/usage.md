<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a single Drush command that renames existing managed files so their filenames match Drupal core's filename-sanitization rules.

---

Existing Filename Sanitizer is a CLI-only maintenance module for sites that enabled Drupal core's upload-time filename
sanitization (Configuration → Media → File system) after files were already uploaded, leaving a backlog of legacy files
with spaces, uppercase, accented or special characters. Its one command, `existing-filenames-sanitizer:sanitize-filenames`
(alias `efssf`), walks every permanent file entity, computes a sanitized filename using the same rules core stores in
`file.settings.filename_sanitization` (transliterate, replace whitespace, replace non-alphanumeric, deduplicate separators,
lowercase, and a replacement character), and where the name changes it renames both the physical file and the file entity.
Each rule can be overridden per run with an option, a `--dry-run` mode previews changes without touching anything, physical
renames use the core file_system service with `EXISTS_RENAME` (so an existing target is never overwritten — a numeric suffix
is added instead), and temporary, missing and generated (oEmbed thumbnail / cache) files are handled without aborting the run.
The module ships no routes, forms, permissions, entities or configuration of its own; it reads core's `file.settings` and
depends only on the core File and System modules.

---

- Sanitize legacy filenames after enabling core's filename sanitization so old files match newly uploaded ones.
- Preview exactly which files would be renamed, with old → new names, using `--dry-run` before applying anything.
- Transliterate accented or non-Latin filenames to ASCII (e.g. `Résumé.docx` → `resume.docx`) across an existing file library.
- Replace whitespace in filenames with a consistent separator character in bulk.
- Strip non-alphanumeric / special characters (keeping `- _ .`) from existing filenames.
- Collapse repeated separators and trim leading/trailing separators from filenames.
- Lowercase all existing filenames for consistency across a case-sensitive filesystem.
- Choose the replacement character (`_`, `-`, etc.) used when substituting whitespace or special characters.
- Apply the site's saved `file.settings.filename_sanitization` options to old files without re-specifying them.
- Override individual sanitization rules per run via command options instead of the stored config.
- Clean up filenames migrated in from another CMS or legacy system that never enforced safe names.
- Avoid broken downloads and web-server issues caused by spaces or special characters in served file URLs.
- Run an aggressive one-shot cleanup combining transliterate, whitespace, non-alphanumeric, deduplicate and lowercase.
- Skip temporary files during a run with `--skip-temporary` to avoid churn on in-progress uploads.
- Skip files whose physical file is missing with `--skip-missing` instead of failing on them.
- Rename files safely without overwriting: conflicting targets get an automatic numeric suffix.
- Process large file tables with periodic progress output (every 100 files) and a final summary of processed/renamed/errors.
- Fold this command into a deployment or migration script that normalizes filenames as a post-import step.
- Normalize filenames in a multilingual site where uploads arrived with locale-specific characters.
- Keep filenames consistent when serving files from a CDN or object store that is sensitive to case or special characters.
- Audit the scope of a filename cleanup (how many files, what changes) via dry-run output before scheduling a maintenance window.
