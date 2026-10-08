<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush command: sanitize-filenames

Single command, defined in `ExistingFilenameSanitizerCommands::sanitizeFilenames()`
(`src/Commands/ExistingFilenameSanitizerCommands.php`), registered as service
`filename_sanitizer.commands` in `drush.services.yml` with tag `drush.command`.

- **Command:** `existing-filenames-sanitizer:sanitize-filenames`
- **Alias:** `efssf`
- No arguments; all behavior is controlled by options.

## Install / enable

```bash
drush en existing_filenames_sanitizer -y
drush cr
```

Requires the core File module (dependency), Drush, and Drupal 10/11. There is no admin UI — the module adds only
`hook_help()`.

## Options and defaults

From the `$options` array on `sanitizeFilenames()`:

| Option | Default | Effect |
| --- | --- | --- |
| `--dry-run` | FALSE | Print intended renames only; write nothing. |
| `--transliterate` | FALSE | Run the name through `@transliteration` (ASCII fold). |
| `--replace-whitespace` | FALSE | `preg_replace('/\s+/', $replacement, $name)`. |
| `--replace-non-alphanumeric` | FALSE | `preg_replace('/[^a-zA-Z0-9\-_.]/', $replacement, $name)`. |
| `--deduplicate-separators` | FALSE | Collapse repeated replacement chars and `trim()` them off the ends. |
| `--lowercase` | FALSE | `strtolower($name)`. |
| `--replacement-character` | `_` | Character used by whitespace / non-alphanumeric / dedup rules. |
| `--skip-temporary` | FALSE | Exclude `temporary://` files (adds a `uri NOT LIKE 'temporary://'` query condition and re-checks per file). |
| `--skip-missing` | FALSE | For non-temporary files whose physical file is absent, skip instead of returning an error. |

Each rule option is resolved as `$options[x] ?: $file_settings->get('filename_sanitization')[x]`, i.e. an unset
(FALSE / empty) option **falls back to the stored core setting** in `file.settings.filename_sanitization`. See
[../config/settings.md](../config/settings.md). Because of the `?:`, you cannot force a rule OFF via the CLI when
the stored config has it ON — only ON via the CLI.

## What it processes

- Entity query: file storage, `status = 1` (permanent only), `accessCheck(FALSE)` — appropriate for a trusted CLI
  maintenance task. Temporary files are dropped from the query when `--skip-temporary` is set.
- Per file: `sanitizeFilename()` (see below) computes the new name from the current `$file->getFilename()`.
  Only when `original !== new` does it attempt a rename.

## sanitizeFilename() (pure transform)

`protected sanitizeFilename($filename, $transliterate, $replace_whitespace, $replace_non_alphanumeric,
$deduplicate_separators, $lowercase, $replacement_character)`:

1. `pathinfo()` splits base name and extension; the extension is preserved verbatim and re-appended at the end.
2. Applies, in order and only if enabled: transliterate → replace whitespace → replace non-alphanumeric →
   deduplicate/trim separators → lowercase.
3. Returns `$name . $extension`.

Example transforms (README): `My Document.pdf` → `my_document.pdf`, `Résumé.docx` → `resume.docx`.

## renameFile() (the write path)

`protected renameFile($file, $new_filename, $skip_missing = FALSE)`:

- Computes `$directory = dirname($file->getFileUri())` and target `$new_uri = $directory . '/' . $new_filename`;
  the file stays in its **own scheme/directory**.
- **Physical file present (normal path):** loops `while (file_exists($new_uri))` appending `_1`, `_2`, … to avoid a
  clash, then `file_system->move($uri, $new_uri, FileSystemInterface::EXISTS_RENAME)`. On success, updates the entity
  via `setFilename()` / `setFileUri($result)` / `save()` and returns TRUE; a FALSE move logs an error and returns FALSE.
- **Physical file missing:**
  - `temporary://` — updates only the DB record's filename (finds a unique name via `fileEntityExists()`), saves, returns TRUE.
  - non-temporary + `--skip-missing` — logs and returns FALSE (skips).
  - non-temporary whose URI contains `oembed_thumbnails` / `generated` / `cache` — updates only the DB record, returns TRUE.
  - otherwise — returns FALSE (counts as an error).
- Wrapped in try/catch; a per-file exception is logged and counted, and the loop continues.

`fileEntityExists($directory, $filename, $exclude_fid)` runs a file query on `uri = "$directory/$filename"`
(excluding the current fid) to pick a unique DB filename when the physical file is absent.

## Output / reporting

Prints the resolved settings, a per-file `File @fid: "@old" -> "@new"` line for each change, a progress line every
100 processed files, and a final summary: total processed, files renamed, errors. In `--dry-run` it prints the same
change lines but counts them as "renamed" without writing, and reminds you to re-run without `--dry-run`.

## Usage examples

```bash
# Preview using the site's stored file.settings sanitization rules
drush efssf --dry-run

# Apply stored rules
drush existing-filenames-sanitizer:sanitize-filenames

# Aggressive one-shot with underscore separator
drush efssf --transliterate --replace-whitespace --replace-non-alphanumeric \
  --deduplicate-separators --lowercase --replacement-character=_

# Avoid churn on in-progress uploads and missing files
drush efssf --skip-temporary --skip-missing --dry-run
```

## Operational cautions

- Renames the file and entity but not external/inline references to the old URI — fix those separately.
- Run `--dry-run` first and back up files + database; the action is bulk and irreversible without a backup.
