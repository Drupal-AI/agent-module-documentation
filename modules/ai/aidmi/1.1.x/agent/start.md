<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AIDmi - AI Describe My Image (aidmi) — agent index

A **CKEditor 5 integration** that generates **508-compliant image alt text** and optional visible
**figcaptions** by sending images (and, optionally, the surrounding body text) to a vision-capable
model through the **Drupal AI module**. Works on inline `<img>` uploads and `drupal-media` image
embeds. Package `Custom`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.1.0.

Depends on **`ai:ai`** (provider abstraction; does all provider/model + key handling) and
**`key:key`**. No composer.json ships (no external composer requirements). No Drush, no entities,
no plugin types of its own.

- **Settings form, config object/schema, routes, permission, Test Connection** →
  [config/settings.md](config/settings.md)
- **The CKEditor 5 button, the AJAX controller, the AI service, and the review dialog** →
  [ckeditor/plugin.md](ckeditor/plugin.md)

## What it actually is

- A **CKEditor 5 plugin** (`aidmi.ckeditor5.yml` → plugin `aidmiPlugin.AIDmi`, toolbar item
  **`aidmi`**, label *"AI, describe my image!"*), enabled per text format on
  *Configuration → Content authoring → Text formats and editors*.
- One **service** `aidmi.ai_service` = `Drupal\aidmi\Service\AidmiAiService` — builds the prompt +
  image payload and calls the AI provider's `chat()`.
- One **controller** `Drupal\aidmi\Controller\AidmiController` behind two JSON AJAX routes.
- One **config form** `Drupal\aidmi\Form\AidmiSettingsForm` (config object `aidmi.settings`).
- JS: `js/aidmi.ckeditor.js` (toolbar/sidebar button + AJAX), `js/aidmi.dialog.js` (review dialog),
  built plugin `js/build/aidmiPlugin.js`. Libraries in `aidmi.libraries.yml`.

## Routes (`aidmi.routing.yml`)

| Route | Path | Access | Notes |
|---|---|---|---|
| `aidmi.settings` | `/admin/config/services/aidmi` | `administer site configuration` | Settings form. |
| `aidmi.describe_image_ajax` | `/admin/aidmi/describe-image-ajax/{file_uuid}` | `generate aidmi accessibility` | JSON; single image by file UUID → `AidmiController::analyzeImageAjax`. |
| `aidmi.describe_content_ajax` | `/admin/aidmi/describe-content-ajax` | `generate aidmi accessibility` | JSON; bulk `content` + `imagesJSON` POST → `AidmiController::analyzeContentAjax`. |

Menu link `aidmi.settings` is placed under the AI module's admin menu (`ai.admin_settings`).

## Permission (`aidmi.permissions.yml`)

- **`generate aidmi accessibility`** — required to call either AJAX generation route.
- The settings form uses core **`administer site configuration`**.

## Key facts

- No credentials in this module: provider selection + API keys are owned by the **AI module**
  (Key-backed). AIDmi only stores a model id, prompt text, and two booleans in `aidmi.settings`.
- Every model call is a **paid external egress** via `AiProviderPluginManager` → `provider->chat()`
  with an `ImageFile` attachment (operation type `chat_with_image_vision`).
- Config keys (`aidmi.settings`, schema in `aidmi.schema.yml`): `ai_model`, `api_instructions`,
  `send_context` (bool), `enable_captions` (bool). Install defaults in `config/install/`.
