<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Existing Filename Sanitizer (existing_filenames_sanitizer) — agent index

A **CLI-only** module: one Drush command renames existing managed files so their filenames match Drupal core's
filename-sanitization rules. Package `Custom`. Depends on core **`file`** and **`system`**. Core requirement
`^10 || ^11`. License GPL-2.0-or-later. Version 1.0.2.

- **The command, all options, and the rename mechanism** → [drush/commands.md](drush/commands.md)
- **How it reads / is driven by core `file.settings`** → [config/settings.md](config/settings.md)

## What it actually is

- **No routes, no forms, no permissions, no entities, no plugins, no config schema, no hooks** beyond
  `hook_help()` (`existing_filenames_sanitizer.module`). It is a pure Drush maintenance tool.
- One Drush command service, `filename_sanitizer.commands` → class
  `Drupal\existing_filenames_sanitizer\Commands\ExistingFilenameSanitizerCommands`
  (`src/Commands/ExistingFilenameSanitizerCommands.php`), registered via `drush.services.yml`.
- Command id **`existing-filenames-sanitizer:sanitize-filenames`**, alias **`efssf`**
  (`ExistingFilenameSanitizerCommands::sanitizeFilenames()`).
- Injected services (constructor / `drush.services.yml`): `@entity_type.manager`, `@file_system`,
  `@transliteration`, `@config.factory`.

## Mechanism (from source)

- Loads every **permanent** file entity (`storage->getQuery()->condition('status', 1)->accessCheck(FALSE)`),
  optionally excluding `temporary://` when `--skip-temporary` is set.
- For each file, `sanitizeFilename()` splits name/extension with `pathinfo()` and applies the enabled rules
  in order: transliterate (`@transliteration`), replace whitespace (`preg_replace('/\s+/', …)`),
  replace non-alphanumeric (`preg_replace('/[^a-zA-Z0-9\-_.]/', …)`), deduplicate + trim separators,
  lowercase. Extension is re-appended unchanged.
- When the new name differs, `renameFile()` renames the **physical** file with
  `file_system->move($uri, $new_uri, FileSystemInterface::EXISTS_RENAME)` inside the file's **own directory**
  (`dirname($file->getFileUri())`), then `$file->setFilename()` / `$file->setFileUri()` / `$file->save()`.
- Conflict handling: `EXISTS_RENAME` plus a `while (file_exists(...))` / `fileEntityExists()` loop appends
  `_1`, `_2`, … so an existing file is never overwritten.
- `--dry-run` only prints the intended `"old" -> "new"` lines and never writes.
- Missing physical files: hard-fails (return FALSE) unless `--skip-missing`, except `temporary://` and paths
  containing `oembed_thumbnails` / `generated` / `cache`, where only the DB record's filename is updated.

## Options (defaults)

`--dry-run` (FALSE), `--transliterate` (FALSE), `--replace-whitespace` (FALSE), `--replace-non-alphanumeric` (FALSE),
`--deduplicate-separators` (FALSE), `--lowercase` (FALSE), `--replacement-character` (`_`), `--skip-temporary` (FALSE),
`--skip-missing` (FALSE). Any option left unset falls back to the matching key in `file.settings.filename_sanitization`.
Full details in [drush/commands.md](drush/commands.md).

## Notes / caveats

- It renames the physical file and the file entity, but does **not** rewrite inline references to the old URI
  stored elsewhere (e.g. body-field HTML embedding `/sites/default/files/Old Name.pdf`) — those must be fixed
  separately. Back up first and run `--dry-run`.
- Options are combined with `?:` against the stored config, so an explicit falsey option can be re-enabled by
  the stored setting; to be certain of a run's behavior, set the options you care about explicitly.
