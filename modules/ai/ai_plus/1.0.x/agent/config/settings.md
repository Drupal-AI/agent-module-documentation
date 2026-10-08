<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI + — settings & configuration

## Install / enable

`drush en ai_plus`. Requires `navigation_plus`, `ai` (with `ai_chatbot`), `ai_agents`, `entity_blueprint` (+ `entity_blueprint_ai`). Model calls need a configured AI provider in the `ai` module (a chat provider for the assistant, and a `text_to_image` provider if you want image generation). To grant access add the **`use ai assistant`** permission to trusted editor roles; the tool/route side additionally requires navigation_plus's **`use toolbar plus edit mode`**.

## Config object: `ai_plus.settings`

Defined in `config/install/ai_plus.settings.yml`, schema in `config/schema/ai_plus.schema.yml`. Three keys:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `assistant_id` | string | `chatbot` | Machine name of the `ai_assistant` entity that powers the chat panel. Loaded in `ChatSidebar::build()`; if it does not load, the panel renders empty. |
| `placeholder_media_id` | integer (nullable) | `1` | Media entity id shown in an image field while an AI image is generated, and the final value when generation is off. Read by `ImageGenerationHandler::getPlaceholderMediaId()` (falls back to `1`). |
| `image_generation_enabled` | boolean | `true` | Site-wide master switch for AI image generation. |

## Where you configure it

There is **no dedicated ai_plus form**. `configure` points at `navigation_plus.settings`; `src/Hook/SettingsFormAlter.php` implements `hook_form_navigation_plus_settings_alter()` to add an **"AI +"** details group with three fields: **AI Assistant** (select, options = all `ai_assistant` entities), **Enable AI image generation** (checkbox), **Placeholder media ID** (number, min 1). Its `submitForm()` writes them back into `ai_plus.settings` (`placeholder_media_id` cast to int or `NULL`). Navigate: Administration » Configuration » User interface » Navigation Plus.

Config-set example:

```
drush cset ai_plus.settings assistant_id my_page_builder_assistant
drush cset ai_plus.settings image_generation_enabled 1
drush cset ai_plus.settings placeholder_media_id 42
```

## Two-level image-generation gate — `src/ImageGenerationGate.php`

Image generation runs only when **both** levels are on (`ImageGenerationGate::isEnabled()`):

- **Site-wide** — `isSiteEnabled()` reads `ai_plus.settings.image_generation_enabled` (defaults to TRUE if unset).
- **Per-user** — `isUserEnabled()` reads a navigation_plus `EditorSettings` value (`ai_plus.generate_images`, defaults to `'1'` = on). The editor flips this live from the toolbar via `AiPlus::buildSettings()` (checkbox `ai-plus-generate-images`, JS `js/ai-plus-generate-images-setting.js`); the toggle is only exposed when generation is enabled site-wide.

When the gate is off, `ImageGenerationHandler` keeps the placeholder as the final image and emits **no** deferred operation; it returns a `BlueprintWarning` to the AI (`buildDisabledWarning()`) telling the user whether the block was site-wide (admin fix) or a personal toggle (self-fix).

## Chat-panel styling hook

`hook_ai_plus_deepchat_style_alter(array &$params, string &$auxiliary_style)` (documented in `ai_plus.api.php`) runs in `ChatSidebar::getDeepChatStyleAttributes()` after the panel derives its styling from `ai_chatbot`'s `deepchat_styles/toolbar.yml` and before JSON-encoding it onto the `<deep-chat>` element. `$params` is the structured deep-chat style array (`messageStyles`, `textInput`, `submitButtonStyles`, `avatars`, `names`); `$auxiliary_style` is CSS injected into deep-chat's shadow DOM. Use it for site/theme branding without patching contrib.
