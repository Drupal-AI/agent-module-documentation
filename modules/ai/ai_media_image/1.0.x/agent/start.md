<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Media Image (ai_media_image) — agent index

Adds a **"Generate Image with AI"** option to Drupal's media image creation forms. An editor
types a text prompt, the module asks the AI module's configured **text-to-image** provider for an
image, previews it, and saves the result as a normal `image` media entity in the Media Library.

- **Dependencies:** `ai:ai` (provider abstraction + the `text_to_image` operation) and
  `drupal:media_library`. Core `^10.2 || ^11`.
- **Configure route:** `ai_media_image.settings_form` → `/admin/config/ai/ai_media_image`
  (permission `administer ai`). The provider/model/API key themselves live in the **`ai`** module,
  not here — set a default `text_to_image` provider at `/admin/config/ai/settings`.
- **Permissions:** yes — one, `generate image with ai`.
- **Drush:** none. **Plugin types:** none. **Config schema:** yes (`ai_media_image.settings`).

## Solution docs
- **Turn on / control the AI generate option on media forms** → [hooks/form_alter.md](hooks/form_alter.md)
- **Configure the settings form + prerequisites** → [configure/settings.md](configure/settings.md)
- **Who may generate images** → [permissions/permissions.md](permissions/permissions.md)

## Key facts (real machine names)
- Config object: `ai_media_image.settings`, single key `provider_configuration_open` (bool, default `true`).
- Settings route: `ai_media_image.settings_form`; admin menu link `ai_media_image.settings` under `ai.admin_settings`.
- Permission: `generate image with ai`.
- Service: `ai_media_image.add_form` → `Drupal\ai_media_image\Form\AiMediaImageAddForm` (extends
  media_library `AddFormBase`; marked `@internal`).
- Altered form ids: `media_image_add_form`, `media_library_add_form_upload`, `media_library_add_form_dropzonejs`.
- Generation goes through `ai.provider` / `ai.form_helper`, operation type `text_to_image`, form key prefix `image_generator`.
- Saved output: `public://ai_generated_image_<uniqid>.jpg`, bundle `image`.
