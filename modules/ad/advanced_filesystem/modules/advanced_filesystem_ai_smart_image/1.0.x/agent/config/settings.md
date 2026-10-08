<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Smart Image — config, routes, service API, apply modes, batch, upload hooks

## Install & enable

```bash
drush en advanced_filesystem_ai_smart_image -y
drush cr
```

Requires the parent `advanced_filesystem`, core `file` + `views`, and **`drupal/ai`**. After
enabling, set a default provider for the **`chat_with_image_vision`** operation at
*Admin → Config → AI → AI Settings* — otherwise `SmartFilenameService::isAvailable()` returns FALSE
and every form shows a warning instead of calling AI. GD (`ext-gd`) is optional but recommended
(image downscaling before send).

`hook_uninstall` (`.install`) drops the `adfs_ai_smart_filename` table and deletes the settings
config object.

## Config object `advanced_filesystem_ai_smart_image.settings`

Schema: `config/schema/advanced_filesystem_ai_smart_image.schema.yml`. Install defaults:
`config/install/advanced_filesystem_ai_smart_image.settings.yml`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `prompt` | text | (built-in slug prompt) | Instruction sent to the vision model. Blank ⇒ `SmartFilenameService::defaultPrompt()`. |
| `supported_mimes` | sequence(string) | jpeg,png,webp,gif,avif | MIME types eligible for suggestion (upload hook + batch + eligibility query). |
| `auto_suggest_on_upload` | boolean | false | Run a suggestion on `hook_file_insert` for new image uploads. |
| `auto_apply_on_upload` | boolean | false | If a suggestion is generated on upload, apply it immediately (needs the above). |
| `apply_mode` | string | `display_name_only` | `display_name_only` or `full_rename`. |
| `max_image_side_px` | integer | 1024 | Max image side before send; `prepareImage()` downscales + re-encodes JPEG via GD. |

Edited on `SmartFilenameSettingsForm` (a `ConfigFormBase`); `submitForm()` trims the prompt and
casts each value.

## Routes & permissions (`*.routing.yml`, `*.permissions.yml`)

| Route | Path | Form | Requirement |
|---|---|---|---|
| `…ai_smart_image.settings` | `/admin/config/media/advanced_filesystem/ai-smart-image` | `SmartFilenameSettingsForm` | `_permission: administer advanced_filesystem_ai_smart_image` |
| `…ai_smart_image.batch` | `…/ai-smart-image/batch` | `SmartFilenameBatchForm` | same admin perm |
| `…ai_smart_image.file` | `/admin/content/files/{file}/smart-filename` | `SmartFilenameFileForm` (param `type: entity:file`, `file: \d+`) | `_permission: use advanced_filesystem_ai_smart_image` |

Permissions: `administer advanced_filesystem_ai_smart_image` (`restrict access: true`) — settings +
batch; `use advanced_filesystem_ai_smart_image` — per-file generate/apply. All three routes are
`_admin_route: true`. There is **no** `_access: 'TRUE'` and no `access content` route here — every
AI-triggering path requires one of these two permissions.

## Service `SmartFilenameService` (`src/Service/SmartFilenameService.php`)

Service id `advanced_filesystem_ai_smart_image.smart_filename_service`; ctor args config.factory,
database, file_system, logger channel.

- `isAvailable()` / `unavailableReason()` — check `ai.provider` service +
  `getDefaultProviderForOperationType('chat_with_image_vision')`.
- `suggestFilename(FileInterface): string` — realpath + `file_get_contents` of the **local** file,
  `prepareImage()` (GD downscale→JPEG), build prompt (config or `defaultPrompt()`),
  `new ChatMessage('user', $prompt)` + `setImageFromBinary()`, then
  `$provider->chat(new ChatInput([$message]), $modelId, ['adfs_ai_smart_image'])`. Result is passed
  through `sanitizeSlug()` (`strtolower` → `preg_replace('/[^a-z0-9]+/','-')` → collapse/trim → cap
  80). Throws `\RuntimeException` on unavailable/unreadable/empty response.
- `saveSuggestion(File, name, status, providerId)` — upsert by `fid` into `adfs_ai_smart_filename`.
- `getSuggestion(int $fid)` / `hasSuggestion(int $fid)` — read the stored row.
- `applyToDisplayName(File, slug)` — `resolveFilenameConflict()`, set `file_managed.filename` only,
  save, mark applied. **URI/disk unchanged** (safe for referenced files).
- `applyFullRename(File, slug)` — `resolveFilenameConflict()`, `fileSystem->move(oldUri, newUri,
  EXISTS_ERROR)` (extra on-disk collision loop), set URI + filename, save. **Changes the URI** —
  may break URI-keyed references.
- `getEligibleFids(includeProcessed, mimes)` — `file_managed` where `status=1` and
  `filemime IN (mimes)`, excluding fids already in `adfs_ai_smart_filename` unless `includeProcessed`.
- `getStats()` — counts per status for the dashboard.
- `checkFilenameConflict()` / `resolveFilenameConflict()` — collision check against
  `file_managed.filename`, appends `-1`, `-2`… All DB access uses the parameterized query builder.

## Per-file form `SmartFilenameFileForm`

At `/admin/content/files/{fid}/smart-filename`. Shows a thumbnail (URL escaped with
`htmlspecialchars(..., ENT_QUOTES)`), the current file row, any existing suggestion with a status
badge, an **AJAX** "Generate suggestion" button (`generateSuggestion()` →
`ajaxGenerateSuggestion()`), an editable `suggested_slug` textfield (`#pattern='[a-z0-9\-]+'`,
`maxlength 80`), a conflict-preview warning, and **Apply**/**Skip** buttons. `validateForm()`
enforces `^[a-z0-9][a-z0-9\-]*[a-z0-9]$` on apply. `applyFilename()` dispatches to the service by
`apply_mode`; `skipFile()` records `STATUS_SKIPPED`.

## Batch form `SmartFilenameBatchForm`

At `…/ai-smart-image/batch` (admin perm). Options: re-process toggle, MIME checkboxes, limit,
chunk size (1–10). `submitForm()` calls `getEligibleFids()`, chunks the fids, and registers a
`batch_set()` whose static `processBatch()` calls `suggestFilename()` + `saveSuggestion()` per file
(one AI call each) and tallies processed/failed/skipped in `batchFinished()`.

## Upload hooks (`.module`)

- `hook_entity_operation` — adds an **AI Smart Filename** operation link to each `image/*` file,
  only for users with `use advanced_filesystem_ai_smart_image`.
- `hook_file_insert` — when `auto_suggest_on_upload` is on and the new file's MIME is in
  `supported_mimes`, calls `suggestFilename()` + `saveSuggestion()` synchronously; if
  `auto_apply_on_upload` is also on, applies per `apply_mode`. Failures are caught and logged as a
  warning (upload still succeeds).

## Operating notes

- The AI call is **synchronous** everywhere (per-file AJAX, batch chunk, upload hook) — one live
  provider round-trip per image. `auto_apply_on_upload` adds that latency to the upload request.
- All AI credentials, endpoint and TLS are owned by `drupal/ai`; this module stores no key and
  performs no direct HTTP request. Swap models by changing the default vision provider in AI
  settings.
- `full_rename` is intended for freshly uploaded, not-yet-referenced files; prefer
  `display_name_only` in production to avoid breaking URI references.
