<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Clean Filename (clean_filename) — agent index

Reverses Drupal's default file-conflict naming so the **newest upload keeps the clean,
unsuffixed filename** and the **pre-existing file is renamed with a `_N` suffix**. Installed
**1.0.0-rc1** (version dir `1.0.x`). Core `^10 || ^11`. Package `File Management`. License
GPL-2.0-or-later. Configure route `clean_filename.admin_settings`.

> Naming note: "clean" here means *clean/original URL*, **not** sanitized. This module does
> **not** transliterate names, strip diacritics, remove spaces, or alter extensions. It only
> swaps which file owns the un-suffixed name. Any sanitization is still core's job
> (`file_munge_filename`, extension checks) and runs before this module acts.

## Dependencies

- Core modules only: **`file`**, **`field`**, **`system`** (`.info.yml`). No composer/PHP libs.

## Default behavior it changes

Core, on a name collision, suffixes the **new** file: existing `document.pdf` stays, new upload
becomes `document_0.pdf`. This module flips it: the existing file is moved to the next free
`document_N.pdf` and the new upload is renamed back to the clean `document.pdf`. Net effect: the
latest upload always holds the clean URL; older versions get numeric suffixes.

## How it works (from source)

Three hooks in `clean_filename.module` plus one service (`src/Service/CleanFilenameManager.php`,
service id `clean_filename.manager`):

1. **`hook_form_field_config_edit_form_alter`** — adds a **per-field** "Enable Clean Filename"
   checkbox (third-party setting `clean_filename.clean_filename_enabled`) to `file`, `image`, and
   `media` field-config edit forms.
2. **`hook_field_widget_single_element_form_alter`** — when a widget for an enabled field renders,
   stashes field context (`entity_type`, `bundle`, `field_name`) in **private tempstore**
   (`clean_filename` collection) keyed by `form_build_id`, so the presave hook can tell which field
   the upload came from.
3. **`hook_entity_presave`** — for **new `File` entities only**. Bails on temp files
   (`/tmp/`, `temporary://`, or names matching `php[0-9A-Za-z]+`). If
   `shouldApplyCleanFilenameForCurrentContext()` is true, calls `handleFileUpload()`.

`CleanFilenameManager::handleFileUpload()` logic:
- `getOriginalFilename($name)` strips a trailing `_<digits>` before the extension via
  `/^(.+)_(\d+)(\.[^.]+)?$/` (e.g. `q_0.jpg` → `q.jpg`). If the name is unchanged (no numeric
  suffix), it returns early — nothing to do.
- `getConflictingFile()` — entity query for a managed file at `directory/original_filename`
  (`accessCheck(FALSE)`, excluding the new file's fid).
- If found: `getNextAvailableSuffix()` scans both `file_managed` (entity query, `STARTS_WITH`
  directory) and the physical directory (`scandir` on `realpath`) for used `_N` suffixes, excluding
  the suffix Drupal just used; `renameSingleFile()` moves the existing file to `base_N.ext`
  (`FileSystem::move` with `FileExists::Replace`) and updates `file_managed` (`uri`, `filename`);
  `updateNewFileToOriginalName()` moves the new file to the clean name and (since it's still new)
  sets its uri/filename on the entity before core saves it.

### Context resolution (`shouldApplyCleanFilenameForCurrentContext`)
- Settings flag `clean_filename_debug` (settings.php) forces it ON regardless of config.
- Route `ckeditor5.upload_image` → **CKEditor** context: reads `text_format` from the request and
  checks the `filter_clean_filename` filter's `clean_filename_enabled` setting on that format.
- Otherwise **field** context from tempstore (via `form_build_id`) → checks that field's
  `clean_filename_enabled` third-party setting.
- Fallback: `hasAnyFieldWithCleanFilenameEnabled()` (any file/image/media field opted in).

## What it provides

- **Permission** (`.permissions.yml`): `administer clean filename` (`restrict access: true`).
- **Route/form** `clean_filename.admin_settings` → `/admin/config/media/clean-filename`
  (`src/Form/CleanFilenameSettingsForm.php`), gated by `administer clean filename`. Menu link under
  Configuration ▸ Media (`.links.menu.yml`). Fields: `enable_logging` (bool) and
  `max_rename_attempts` (int, 1–1000, default 100). Note: `max_rename_attempts` is stored but
  **not consulted** by the suffix-search loop; `enable_logging` is likewise not gated on — the
  service logs unconditionally via `logger.factory` channel `clean_filename`.
- **Filter plugin** `filter_clean_filename` ("Clean Filename for CKEditor",
  `src/Plugin/Filter/FilterCleanFilename.php`) — a no-op text filter
  (`TYPE_TRANSFORM_IRREVERSIBLE`) whose only job is to carry the `clean_filename_enabled` setting
  that turns the behavior on for CKEditor 5 image uploads in that text format. `process()` returns
  the text untouched.
- **Config object** `clean_filename.settings` (schema in `config/schema/clean_filename.schema.yml`).
- **Install** (`clean_filename.install`): `hook_install` seeds `enable_logging=TRUE`,
  `max_rename_attempts=100`; `hook_requirements` reports how many fields have it enabled
  (WARNING when zero); `hook_uninstall` deletes the config.

## Configuration recap

1. Enable on a field: **Manage fields ▸ [field] ▸ Edit ▸ Clean Filename Settings ▸ Enable**.
2. For CKEditor uploads: **Text formats ▸ [format] ▸** enable the "Clean Filename for CKEditor"
   filter and tick its checkbox (independent of field config).
3. The `/admin/config/media/clean-filename` page is informational (global logging/attempts +
   read-only lists of enabled fields and text formats); per-field/per-format toggles live on their
   own forms.

## Gotchas / caveats

- Suffix detection is purely string-based: a legitimately-named upload like `report_2024.pdf`
  is treated as if Drupal had suffixed `report.pdf`, so if a `report.pdf` already exists in the
  same directory the module will rename that existing file to `report_0.pdf` and give the new
  upload the `report.pdf` name — a rename with no real conflict.
- README references a `FilePriorityManager` service and a `tests/` suite that are **not** in the
  packaged release; the actual service is `CleanFilenameManager` and no tests ship.
