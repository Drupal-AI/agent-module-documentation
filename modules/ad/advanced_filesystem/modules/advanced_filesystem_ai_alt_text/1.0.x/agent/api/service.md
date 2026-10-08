<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AltTextService (advanced_filesystem_ai_alt_text.service)

`src/Service/AltTextService.php`. Constructor: `config.factory`, `entity_type.manager`,
`logger.channel.advanced_filesystem_ai_alt_text`. Also pulls `file_system`, `ai.provider` and
`entity_field.manager` from the container at call time.

## Public methods

- `isAvailable(): bool` — `true` only if the `ai.provider` service exists and a default provider is
  set for `chat_with_image_vision`.
- `unavailableReason(): string` — human reason when unavailable ("drupal/ai … not installed", "No
  default provider …"), else `''`.
- `appliesToFile(FileInterface): bool` — MIME is in `SUPPORTED_MIMES`
  (`image/jpeg|jpg|png|gif|webp|bmp`).
- `generateAltText(FileInterface): string` — the core call (below). Throws
  `InvalidArgumentException` (non-image) or `RuntimeException` (unreadable file / no provider).
- `generateAndSave(FileInterface, bool $overwrite = FALSE): array` — calls `generateAltText()` then
  `writeAltTextToFields()`; returns `['alt_text', 'fields_updated', 'fields_skipped']` and logs a
  summary.

## generateAltText() flow

1. Reject non-image MIME; resolve `file_system->realpath($file->getFileUri())`, require readable.
2. `file_get_contents($realpath)` — reads the **managed file's own path**, never a request/config URL.
3. Resolve provider via `AiProviderPluginManager::getDefaultProviderForOperationType('chat_with_image_vision')`
   → `createInstance($defaults['provider_id'])`, `$defaults['model_id']`.
4. Read `prompt` + `max_length` from config.
5. `prepareImageForApi()` — if GD is loaded, resize to <=1024px and re-encode JPEG (quality 85) to
   shrink the payload; otherwise send the original bytes.
6. Build `ChatMessage('user', $prompt)` + `setImageFromBinary($data, $mime)` + `ChatInput`, call
   `$provider->chat($chatInput, $modelId, ['adfs_ai_alt_text'])`.
7. Trim, strip wrapping quotes, truncate to `max_length` at the last space.

Provider transport (HTTP client, TLS, API-key placement) is entirely drupal/ai's; this service passes
only image bytes + prompt.

## writeAltTextToFields()

Iterates `entity_field.manager->getFieldMapByFieldType('image')`; for each entity type/field/bundle,
`findEntityIdsWithFile()` runs an entity query `condition("$field.target_id", $fid)` (`accessCheck(FALSE)`
— intended for admin/Drush bulk write), loads the entities, and for each delta whose `target_id`
matches sets `$item->set('alt', $altText)` (skipping non-empty alts unless `$overwrite`). Saves each
changed entity. The alt string is stored as a field value → escaped by the image field on render.

## Drush

`Drush\Commands\AltTextCommands` (from `drush.services.yml`, args: the service, `entity_type.manager`,
`entity_field.manager`, `database`) exposes per-file / all-image generation from the CLI, reusing the
same service.
