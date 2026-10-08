<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: transliterate:existing-files

## Command
```
drush transliterate:existing-files [--dry-run] [--redirect]
# alias:
drush tef --dry-run
```

## Options
- `--dry-run` — report changes without renaming or saving anything.
- `--redirect` — create a 301 redirect from old to new file URL (requires the Redirect module; ignored with a warning if not enabled).

## What it does
1. Loads all file entities (`getQuery()->accessCheck(FALSE)`).
2. For each, computes `sanitizeFilename()` from `file.settings.filename_sanitization.*` (transliterate, replace_whitespace, replace_non_alphanumeric, deduplicate_separators, lowercase).
3. Skips files whose name is unchanged, or where the target already exists (logged + error message).
4. `rename($fileUri, $sanitizedUri)`, then updates the file entity's URI and filename and saves.
5. With `--redirect`, creates a 301 `redirect` entity old→new.

## Operational notes
- Renames are on disk and irreversible without redirects — take a backup and run `--dry-run` first.
- Only the CLI can trigger this; there is no web route or permission.
