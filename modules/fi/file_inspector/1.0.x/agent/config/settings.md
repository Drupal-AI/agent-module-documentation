<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Inspector — configuration

## Install / enable

`drush en file_inspector` (or via UI). Requires core **Views**; enable core **Media** too if you
want the import-to-media-library feature (import links/operations are hidden without it — see the
service swap in [../api/services.md](../api/services.md)). `hook_requirements` (in
`file_inspector.install`) adds a runtime/install check that the default-scheme files directory is
accessible. `hook_uninstall` deletes `file_inspector.settings`, the optional
`views.view.file_inspector`, the `file_inspector.last_inspection` / `.inspection_in_progress` state
keys, and invalidates the `file_inspector` cache tag. (Table drop is handled by core from
`hook_schema`.)

## Config object: `file_inspector.settings`

Edited at **`/admin/config/media/file-inspector`** (route `file_inspector.settings`, permission
`administer file inspector`) via `SettingsForm` (`src/Form/SettingsForm.php`, extends
`ConfigFormBase`). Schema: `config/schema/file_inspector.schema.yml`. Install defaults:
`config/install/file_inspector.settings.yml`.

Structure (two top-level mappings, `inspection` and `operations`):

- `inspection.stream_wrappers` (sequence of string) — schemes the scan is allowed to walk.
  Default `[public]`. **Not exposed in `SettingsForm`** — change via config import/Drush if you
  need `private` etc. `InspectFiles::filesIterator()` throws `InvalidArgumentException` for any
  wrapper not in this list, and `PathValidator::getStreamWrapper()` rejects paths whose scheme is
  not listed.
- `inspection.excluded_folders` (sequence of string) — folder *segment* names to skip. Default
  `[css, js, styles, php, translations, google_tag, media-icons]`. `InspectFiles::getExcludedPaths()`
  always merges in a hard-coded system set (`styles, css, js, php`) on top of this. Matched as whole
  path segments via a single compiled regex `(?:^|/)(?:…)(?:/|$)` built in `buildExclusionPattern()`.
- `inspection.allowed_mime_types` (sequence of string) — allow-list applied during tracking
  (`InspectFiles::isAllowedMimeType()`). Supports exact types and `type/*` wildcards. **An empty
  list means "allow everything"** in the service, but `SettingsForm::validateMimeTypes()` requires
  at least one entry, so the UI never saves an empty list. Default list covers common
  image/office/text types.
- `inspection.batch_size` (integer, schema `Range` 1–1000, default 50) — files processed per batch
  run. Consumed by `BatchTracker` and `BatchProcessor`.
- `inspection.embedded_web_folders` (sequence of string, default `[]`) — top-level folder names that
  hold embedded web apps. Files under these are excluded from the normal scan; only the entry file
  (depth 1 and depth 2) is recorded as status WEB_EMBEDDED. See
  `InspectFiles::embeddedEntriesIterator()` / `isEmbeddedWebPath()`.
- `inspection.embedded_web_entry_file` (string, default `index.html`) — the entry filename looked
  for inside each embedded root.
- `operations.allow_delete` (boolean, default TRUE).
- `operations.allow_import` (boolean, default TRUE).

## SettingsForm validation (security-relevant input hardening)

`SettingsForm::validateForm()` runs per-field validators before save:

- `validateExcludedFolders()` and `validateEmbeddedWebFolders()` reject any entry containing `..`,
  starting with `/` or a Windows drive (`X:\`), or not matching `^[a-zA-Z0-9_-]+$`.
- `validateEmbeddedWebEntryFile()` rejects blank values, path separators, `..`, and anything not
  matching `^[A-Za-z0-9._-]+$` (bare filename only).
- `validateBatchSize()` enforces numeric 1–1000.
- Textarea fields are split/trimmed/filtered by `textareaToArray()`; arrays are rejoined with
  `arrayToTextarea()` for display.

Note: `operations.allow_delete` / `allow_import` are persisted but the runtime action gating in the
forms and Views handlers is driven by the four *permissions* plus `ManageFiles::canImportMedia()`,
not by re-reading these two booleans.

## Config-export example

```yaml
# file_inspector.settings
inspection:
  stream_wrappers:
    - public
    - private
  excluded_folders:
    - css
    - js
    - styles
  allowed_mime_types:
    - 'image/*'
    - application/pdf
  batch_size: 100
  embedded_web_folders:
    - flipping_books
  embedded_web_entry_file: index.html
operations:
  allow_delete: true
  allow_import: true
```
