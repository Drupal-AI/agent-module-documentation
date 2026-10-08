<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Filesystem: AI Alt Text (advanced_filesystem_ai_alt_text) — agent index

Submodule of **Advanced Filesystem**. Generates image **alt text** by calling the **drupal/ai**
`chat_with_image_vision` operation and writing the result into the `alt` sub-field of every image
field that references the file. Package `Advanced Filesystem`. Core `^10 || ^11 || ^12`. Version 1.0.27.

- **Dependencies:** `file`, `field`, `user`, `advanced_filesystem`. drupal/ai is a *soft* dependency
  (checked at runtime via `\Drupal::hasService('ai.provider')`) — no provider means the UI hides itself.
- **No provider/model/API key is stored here.** `AltTextService::isAvailable()` /
  `generateAltText()` resolve the default provider with
  `AiProviderPluginManager::getDefaultProviderForOperationType('chat_with_image_vision')`; TLS and
  credential handling belong to drupal/ai. Configure the vision provider at Config → AI → Providers.

## What it provides

- **Service** `advanced_filesystem_ai_alt_text.service` → `Service\AltTextService`
  (`generateAltText()`, `generateAndSave()`, `appliesToFile()`, `isAvailable()`). See
  [api/service.md](api/service.md).
- **Config** object `advanced_filesystem_ai_alt_text.settings` (`prompt`, `overwrite`, `max_length`,
  `image_field_mappings`) + schema. Settings form `Form\AltTextSettingsForm`. See
  [config/settings.md](config/settings.md).
- **Routes** (all admin): `.settings`, `.batch` (`Form\BatchAltTextForm`), `.file_generate`
  (`Form\SingleFileAltTextForm`, `/admin/content/files/{file}/ai-alt-text`), and the JSON endpoint
  `.generate_inline` (`Controller\AltTextInlineController::generate`,
  `/admin/api/advanced-filesystem/ai-alt-text/{fid}`). See [routes/routes.md](routes/routes.md).
- **Permissions:** `administer advanced_filesystem_ai_alt_text` (restricted; all admin routes) and
  `generate advanced_filesystem_ai_alt_text` (the inline endpoint / widget button also accept this).
- **Widget button:** `hook_field_widget_single_element_form_alter()` + an `#after_build` callback in
  `.module` inject a plain HTML button into image widgets; `js/alt-text-button.js` calls the JSON
  endpoint via `fetch()`. `Ajax\AltTextAjaxHandler` is an alternate AJAX callback.
- **Drush:** `Drush\Commands\AltTextCommands` (per-file / all-image generation).
- **Entity operation:** `hook_entity_operation()` adds "AI Generate Alt Text" to image file rows.

## Mechanism (from source)

`AltTextService::generateAltText()` (`src/Service/AltTextService.php`): reads the managed file's own
`realpath`, `file_get_contents` it (not a request-supplied URL), `prepareImageForApi()` resizes to
<=1024px JPEG via GD, builds a `ChatMessage`+`ChatInput` with `setImageFromBinary()`, calls
`$provider->chat()`, trims quotes and truncates to `max_length` on a word boundary.
`writeAltTextToFields()` uses `entity_field.manager` `getFieldMapByFieldType('image')` + entity
queries to find and update every referencing field; AI text is placeholder-escaped in messages and
stored in the image `alt` attribute (escaped on output).
