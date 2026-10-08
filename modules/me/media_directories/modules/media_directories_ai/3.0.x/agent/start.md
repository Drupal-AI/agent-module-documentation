<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Directories AI — agent index

Adds AI alt-text generation and AI translation to the Media Directories browser, on top of
the contrib `ai` module. No permissions of its own (it reuses the browser's), no plugin
types, no Drush commands.

- **All settings keys, the settings form and drush recipes** →
  [configure/settings.md](configure/settings.md)
- **The three API routes, the two services, and the one hook** →
  [api/services-and-routes.md](api/services-and-routes.md)

Key facts:
- Config object **`media_directories_ai.settings`**; form at
  **`/admin/config/media/media_directories/ai`** (route `media_directories_ai.config_form`,
  local task **AI** weight 20, permission `administer site configuration`). `.info.yml` has
  **no `configure` key**.
- Hard dependencies: `media_directories:media_directories_browser` and `ai:ai`.
- Routes (POST, permission `access media directories browser`):
  `/api/media-directories-browser/ai/alt-text`,
  `/api/media-directories-browser/ai/alt-text-from-file`,
  `/api/media-directories-browser/ai/translate`.
- Services: `media_directories_ai.alt_text` (`AiAltTextService`) and
  `media_directories_ai.translation` (`AiTranslationService`); both take `@?ai.provider`,
  so they degrade rather than fail when the manager is absent.
- Alt text needs a default provider for the **`chat_with_image_vision`** operation type;
  `AiAltTextService::isAvailable()` returns FALSE otherwise, which is what hides the UI.
- `AiAltTextService::MAX_IMAGE_DIMENSION === 1280`.
