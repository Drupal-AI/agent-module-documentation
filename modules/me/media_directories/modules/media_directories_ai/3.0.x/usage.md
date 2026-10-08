<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Directories AI adds AI-generated alt text and AI-translated media metadata to the Media Directories browser, using the contrib `ai` module's provider abstraction.

---

The submodule hangs three JSON routes off the browser's API prefix — `ai/alt-text` (by media UUID), `ai/alt-text-from-file` (raw binary, used during upload before the media exists) and `ai/translate` — all POST-only and all gated by the browser's `access media directories browser` permission. Two services do the work. `AiAltTextService` requires `enable_ai_alt_text` to be on **and** a default provider for the `chat_with_image_vision` operation type; it downscales the image to at most `MAX_IMAGE_DIMENSION` (1280 px), sends `alt_text_prompt` (falling back to a built-in `DEFAULT_PROMPT` that asks for 1–2 concise sentences without "Image of"/"Photo of" prefixes) with a language instruction appended, and returns the text. `AiTranslationService` translates a set of field values into a target language, using `translation_prompt` or its own `DEFAULT_PROMPT` ("Translate text accurately while preserving the original meaning, tone, and formatting."). Both take the `ai.provider` plugin manager as an **optional** (`@?`) dependency, so the module degrades instead of fataling. Its settings form lives at `/admin/config/media/media_directories/ai` (route `media_directories_ai.config_form`, local task **AI**, weight 20, permission `administer site configuration`) and writes `media_directories_ai.settings`: `enable_ai_alt_text`, `alt_text_prompt`, `ai_translation_types`, `translation_prompt`, plus two per-bundle field maps — `ai_fillable_fields` (which fields get an AI-fill button) and `ai_translatable_fields` (which fields are included in AI translation), both seeded from sensible defaults by `media_directories_ai_update_11001()`. A single hook, `hook_page_attachments_alter()`, flips `drupalSettings.mediaDirectoriesBrowser.enableAiAltText` and the per-type `enableAiTranslations` flags that the browser module deliberately publishes as `FALSE`, so the Vue app only shows AI controls when the feature is genuinely available. There are no permissions, plugin types or Drush commands of its own.

---

- Generate alt text for an uploaded image with one click in the media browser.
- Generate alt text during upload, before the media entity is even saved.
- Fill missing alt text across an existing image library.
- Enforce a house style for alt text through a custom `alt_text_prompt`.
- Ask for alt text in the media item's own language (the language instruction is appended automatically).
- Keep AI features hidden until a vision-capable provider is actually configured.
- Translate media labels and descriptions into the site's other languages from the edit modal.
- Restrict AI translation to specific media types with `ai_translation_types`.
- Control which fields get an AI fill button per bundle (`ai_fillable_fields`).
- Control which fields are sent for AI translation per bundle (`ai_translatable_fields`).
- Set a house translation prompt preserving tone and formatting (`translation_prompt`).
- Swap AI providers without touching this module (it uses `ai.provider`'s default for the operation type).
- Cap upload cost/latency by relying on the 1280 px downscale before sending an image.
- Turn every AI feature off site-wide with a single `enable_ai_alt_text` toggle.
- Improve accessibility scores on an image-heavy site quickly.
- Give editors a first draft of alt text they can edit rather than a blank field.
- Combine with `content_translation` so AI-filled translations land in the right language tabs.
- Call `/api/media-directories-browser/ai/alt-text` from a custom script for bulk backfills.
- Send a raw image binary to `ai/alt-text-from-file` for previewing alt text pre-save.
- Audit AI usage by checking which media types have `ai_translation_types` enabled.
- Keep AI off for legal/regulated media types while enabling it elsewhere.
- Verify availability programmatically with `AiAltTextService::isAvailable()`.
- Debug "no AI buttons" by checking `drupalSettings.mediaDirectoriesBrowser.enableAiAltText`.
- Roll AI out gradually, bundle by bundle, through the two per-bundle field maps.
