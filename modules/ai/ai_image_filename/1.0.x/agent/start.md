<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Image Filename (ai_image_filename) — agent index

Renames uploaded images to **descriptive, SEO-friendly filenames** using an AI
**Chat-with-Image-Vision** model, via a core file-upload event subscriber. Package
*AI Tools*. Core `^10 || ^11`. Depends on core **`file`** and **`ai`** (drupal/ai).
License GPL-2.0-or-later. Version 1.0.0.

- **Settings, the event subscriber, and the rename/sanitize flow** →
  [config/settings.md](config/settings.md)

## What it actually is

- **No routes of its own besides the settings form, no entities, no plugins, no permissions
  file.** One event subscriber `EventSubscriber\AiImageFilenameSubscriber` (service
  `ai_image_filename.file_upload_subscriber`) and one settings form
  `Form\AiImageFilenameSettingsForm`.
- Settings form route `ai_image_filename.settings_form` →
  `/admin/config/ai/ai_image_filename`, permission **`administer ai`** (the AI module's
  permission — this module defines none). Menu link under *AI* (`ai.admin_settings`).
- Config object `ai_image_filename.settings` (with `config/schema/`): `enabled` (bool),
  `prompt` (text), `ai_model` (AI simple-option string; empty = site default vision model).

## Mechanism (from source)

- Subscribes to core `FileUploadSanitizeNameEvent` at **priority 10** (before core's default
  priority-0 sanitizer) so the AI name is what core then sanitizes.
- `onSanitizeFilename()`: returns early if disabled or the extension is not in
  `IMAGE_EXTENSIONS` (`jpg, jpeg, png, gif, webp`). Finds the matching `UploadedFile` in the
  request files bag by client original name, reads its bytes, wraps them in an
  `ai\...\GenericType\ImageFile`, and sends a `ChatInput` (user message = configured `prompt`
  + the image) to the resolved provider's `chat()`. The response text is passed through
  `sanitizeFilename()` and, if non-empty, `$event->setFilename($cleanName . '.' . $extension)`.
- `resolveProvider()`: uses the configured `ai_model` (verifying it has the
  `ChatWithImageVision` capability) or falls back to
  `getDefaultProviderForOperationType('chat_with_image_vision')`. Returns `NULL` (skip) if none.
- `sanitizeFilename()`: lowercases, strips any extension, `preg_replace('/[^a-z0-9]+/','-')`,
  trims hyphens, caps to 248 chars, and requires the final stem to match
  `^[a-z0-9][a-z0-9-]*[a-z0-9]$` (else returns `''` → no rename).

## Integration notes

- Uses the **drupal/ai** provider abstraction; the provider's API key/TLS are the AI module's
  concern, not this module's. No direct external HTTP here.
- Reads the just-uploaded temp file locally (`file_get_contents($tmpFile->getPathname())`); it
  does not fetch any request-supplied URL.
- All failures are caught and logged to the `ai_image_filename` channel; on any problem the file
  keeps its original (core-sanitized) name.
