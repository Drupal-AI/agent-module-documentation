<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Filesystem AI Smart Image (advanced_filesystem_ai_smart_image) — agent index

Sub-module of **Advanced FileSystem**. Sends an image to a `drupal/ai`
**`chat_with_image_vision`** provider and gets back a lowercase-hyphenated **filename slug**
(e.g. `team-meeting-conference-room`), then stores/applies it. Package `Advanced Filesystem`.
Core `^10 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.0.27.

- **Config, routes, permissions, service API, apply modes, batch, upload hooks** →
  [config/settings.md](config/settings.md)

## Dependencies

`advanced_filesystem`, core `file`, core `views`, and **`drupal/ai`** (with a configured
`chat_with_image_vision` provider). GD (`ext-gd`) is used if present to downscale/re-encode images
before sending. No composer.json of its own.

## What it provides

- **Service** `advanced_filesystem_ai_smart_image.smart_filename_service` →
  `Service\SmartFilenameService`. Key methods: `isAvailable()`/`unavailableReason()`,
  `suggestFilename(File)` (the AI call), `saveSuggestion()`, `getSuggestion()`, `hasSuggestion()`,
  `applyToDisplayName()`, `applyFullRename()`, `getEligibleFids()`, `getStats()`,
  `checkFilenameConflict()`/`resolveFilenameConflict()`. Status constants
  `STATUS_SUGGESTED|APPLIED|SKIPPED|FAILED`.
- **Config object** `advanced_filesystem_ai_smart_image.settings` (schema in `config/schema/`,
  install defaults in `config/install/`): `prompt`, `supported_mimes[]`, `auto_suggest_on_upload`,
  `auto_apply_on_upload`, `apply_mode` (`display_name_only`|`full_rename`), `max_image_side_px`.
- **Database table** `adfs_ai_smart_filename` (`hook_schema` in `.install`): one row per fid —
  `original_filename`, `suggested_name`, `status`, `provider_id`, `created`, `applied`;
  unique key on `fid`.
- **Routes** (`*.routing.yml`):
  - `advanced_filesystem_ai_smart_image.settings` — `/admin/config/media/advanced_filesystem/ai-smart-image` (`SmartFilenameSettingsForm`), perm `administer advanced_filesystem_ai_smart_image`.
  - `advanced_filesystem_ai_smart_image.batch` — `…/ai-smart-image/batch` (`SmartFilenameBatchForm`), same admin perm.
  - `advanced_filesystem_ai_smart_image.file` — `/admin/content/files/{file}/smart-filename` (`SmartFilenameFileForm`, entity:file param), perm `use advanced_filesystem_ai_smart_image`.
- **Permissions** (`*.permissions.yml`): `administer advanced_filesystem_ai_smart_image`
  (`restrict access: true`) and `use advanced_filesystem_ai_smart_image`.
- **Hooks** (`.module`): `hook_entity_operation` adds an "AI Smart Filename" link to every
  `image/*` file for holders of the `use` perm; `hook_file_insert` runs auto-suggest/auto-apply
  when configured.
- **Menu/task links** under *Configuration → Media → Advanced Filesystem*.

## Mechanism (from source)

- `SmartFilenameService::suggestFilename()`: reads the **local managed file** via
  `fileSystem->realpath($file->getFileUri())` + `file_get_contents`, `prepareImage()` downscales to
  `max_image_side_px` and re-encodes JPEG (GD), builds a `ChatMessage('user', $prompt)` with
  `setImageFromBinary()`, and calls `$provider->chat(new ChatInput([$message]), $modelId, [...])` on
  the default `chat_with_image_vision` provider. **All HTTP/TLS/credentials live in `drupal/ai`.**
- `sanitizeSlug()` lowercases the first line and `preg_replace('/[^a-z0-9]+/', '-', …)`, collapses
  hyphens, caps at 80 chars — so the AI response is reduced to `[a-z0-9-]` before it is stored,
  rendered, or used as a filename.
- Apply: `applyToDisplayName()` sets `file_managed.filename` only; `applyFullRename()` also
  `fileSystem->move()`s the file and updates the URI. Both call `resolveFilenameConflict()` first.

## Notes / caveats

- `suggestFilename()` is **synchronous** — the per-file form (AJAX), batch operations, and
  `hook_file_insert` (auto-suggest) each block on one live AI call per image; `auto_apply_on_upload`
  therefore adds an AI round-trip to the upload request. Cost/latency scale with image count.
- `full_rename` changes the URI and can break entities that reference the file by URI; the module
  itself flags it as for freshly-uploaded, not-yet-referenced files.
- Without a configured `chat_with_image_vision` provider, `isAvailable()` is FALSE and the forms
  show a warning instead of calling AI.
