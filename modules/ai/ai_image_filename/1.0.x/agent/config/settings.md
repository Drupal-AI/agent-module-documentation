<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, subscriber & rename flow

## Install / enable

Requires the **AI module** (`drupal/ai`) with a configured provider that supports **Chat with
Image Vision**, plus core `file`. `drush en ai_image_filename`. Ships default config
(`config/install/ai_image_filename.settings.yml`, `enabled: true`) and a schema
(`config/schema/ai_image_filename.schema.yml`).

## Settings form

Route `ai_image_filename.settings_form` → `/admin/config/ai/ai_image_filename`, permission
**`administer ai`** (from the AI module — this module ships no `*.permissions.yml`). Form
`Form\AiImageFilenameSettingsForm` (id `ai_image_filename_settings`), config object
`ai_image_filename.settings`:

| Key | Widget | Meaning |
|---|---|---|
| `enabled` | checkbox (default TRUE) | Turn AI renaming on/off. |
| `prompt` | textarea (`#required`) | Instruction sent with the image; should ask for only a filename with no extension. |
| `ai_model` | select | An AI "simple option" provider/model string filtered to `ChatWithImageVision`; empty = *Use Default Image Vision Model*. |

If no model is chosen and no default vision model exists, the form shows a warning linking to the
AI settings page. The default prompt (see `config/install`) asks for a 4–8 word,
lowercase-hyphenated, letters/numbers/hyphens-only name with no extension.

## Event subscriber (`EventSubscriber\AiImageFilenameSubscriber`)

Service `ai_image_filename.file_upload_subscriber`, args `@config.factory`, `@ai.provider`,
`@request_stack`, `@logger.factory`. Subscribes to core
`FileUploadSanitizeNameEvent::class => ['onSanitizeFilename', 10]` — **priority 10**, so it runs
before core's default (priority 0) transliteration/sanitizer and the AI-suggested name becomes
the input core then finishes sanitizing.

### `onSanitizeFilename()` steps

1. Return if `enabled` is false.
2. Lowercase the extension; return unless it is one of `IMAGE_EXTENSIONS`
   (`jpg, jpeg, png, gif, webp`).
3. Get the current request; `findUploadedFile()` walks the request files bag recursively and
   matches an `UploadedFile` by `getClientOriginalName() === $filename`. Return if not found.
4. `resolveProvider($config->get('ai_model'))`: use the configured model (only if it advertises
   `AiModelCapability::ChatWithImageVision`) else the default `chat_with_image_vision` provider;
   return NULL (skip) if unavailable.
5. Read the temp file bytes; build an `ImageFile` (binary + mime via `mime_content_type()` +
   original filename).
6. Send `new ChatInput([new ChatMessage('user', $prompt, [$image])])` to
   `provider['instance']->chat($input, provider['model_id'])`, take `getNormalized()->getText()`.
7. `sanitizeFilename()` the response; if non-empty, `$event->setFilename($cleanName . '.' . $ext)`.
8. Any `\Exception` is caught and logged (`ai_image_filename` channel); the upload keeps its
   original name.

### `sanitizeFilename(string $response): string`

`strtolower(trim())` → `pathinfo(..., PATHINFO_FILENAME)` (drops any extension the model added) →
`preg_replace('/[^a-z0-9]+/', '-', ...)` → `trim(substr(..., 0, 248), '-')`. Returns `''` unless
the result matches `^[a-z0-9][a-z0-9-]*[a-z0-9]$`. This is what guarantees the applied stem
contains only `[a-z0-9-]` — no dots, slashes, or path characters survive.

## Operating notes

- Each qualifying image upload makes one synchronous vision-model call, so uploads are as slow as
  the provider round-trip; a failure just falls back to the original name.
- The API key and TLS behavior are owned by the AI provider you configure, not by this module.
- Only the filename stem changes; the extension is preserved and the file bytes are untouched.
