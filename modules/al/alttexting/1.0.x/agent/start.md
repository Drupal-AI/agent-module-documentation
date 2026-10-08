<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alttext.ing (alttexting) — agent index

Generates image `alt` text for **core Media** entities via the external `api.alttext.ing` AI vision
service (acolono GmbH). Requires a paid API key. Adds a "Generate Alt Text With AI" button to image
media widgets and can auto-generate on media save. Core `^10.1 || ^11 || ^12`; depends on `media`.

## What it provides
- **Config object** `alttexting.settings` (`api_key`, `api_url`, `encode_image`, `autogenerate_on_save`,
  `autogenerate_use_queue`); schema in `config/schema/alttexting.schema.yml`; settings form
  `Form\AltTextSettingsForm` at route `alttexting.settings` (`/admin/config/media/alttexting`).
- **Image style** `alttexting` (config/install/image.style.alttexting.yml): scale to 300px wide → WebP.
  Used to build a lightweight derivative before sending to the service.
- **Permission** `administer alttexting settings` (`restrict access: true`).
- **Service** `alttexting.alttext_generator` = `Service\AltTextGeneratorService` (all HTTP + save logic).
- **Routes/controllers** (see agent/api/endpoints.md): `alttexting.generate_async`,
  `alttexting.try_get_result` (`Controller\AltTextController`), `alttexting.webhook`
  (`Controller\WebhookController`).
- **Queue worker** `alttexting_media_processor` = `Plugin\QueueWorker\AltTextQueueWorker` (cron, 60s).
- **Hooks** in `Hook\AlttextingHooks` (OOP `#[Hook]` + `#[LegacyHook]` shims in `alttexting.module`):
  `theme` (`alttexting_button`), `field_widget_single_element_form_alter` (injects the button + JS),
  `media_insert` / `media_update` (call `alttexting_media_processor()`).
- **Library** `alttexting/alt-text-generator` (`js/alt-text-generator.js`) — AJAX button + polling.
- **Install** (`alttexting.install`): creates/deletes the queue; uninstall deletes `image.style.alttexting`.

## Solution docs
- Configuration & settings: [agent/config/settings.md](config/settings.md)
- Generation flow, routes, service & queue: [agent/api/endpoints.md](api/endpoints.md)
