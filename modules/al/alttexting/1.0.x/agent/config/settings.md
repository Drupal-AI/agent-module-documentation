<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alttext.ing configuration

## Install / enable
`composer require drupal/alttexting` then `drush en alttexting -y`. Depends on core `media`.
`hook_install()` (`alttexting.install`) creates the `alttexting_media_processor` queue; uninstall
deletes the queue and the `image.style.alttexting` config entity.

## Config object: `alttexting.settings`
Defaults in `config/install/alttexting.settings.yml`; schema in `config/schema/alttexting.schema.yml`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `api_key` | string | `''` | License key for `api.alttext.ing`. Sent as `apiKey` in the request body. |
| `api_url` | string | `https://api.alttext.ing` | Service base URL. **Not exposed in the settings form** — only settable via config import / drush. Endpoints called: `{api_url}/generate-async`, `{api_url}/try-get-result`. |
| `encode_image` | boolean | `true` | If TRUE, base64-encode the resized image and send it inline (`data:` URI) instead of a URL. Enable for local dev where the service can't reach the site. |
| `autogenerate_on_save` | boolean | `false` | Auto-generate alt text on media insert/update when alt is empty. |
| `autogenerate_use_queue` | boolean | `true` | If TRUE, queue the work for cron; if FALSE, generate synchronously (uses the webhook callback). |

Note the schema defines only `api_key`, `encode_image`, `autogenerate_on_save`,
`autogenerate_use_queue` — `api_url` ships in the install default but has no schema mapping.

## Settings form
`Form\AltTextSettingsForm` (`ConfigFormBase`), route `alttexting.settings`
(`/admin/config/media/alttexting`), permission `administer alttexting settings` (`restrict access: true`),
menu link `alttexting.settings` under `system.admin_config_media`. Exposes four fields:
API Key, Autogenerate on save, Encode image, Autogenerate use queue. (`api_url` is not on the form.)

## Image style `alttexting`
`config/install/image.style.alttexting.yml`: `image_scale` to width 300 (no upscale) then
`image_convert` to `webp`. `AltTextGeneratorService::getImageUrlFromFid()` builds this derivative for
every image before sending it; if the style is missing it logs an error and aborts.

## Permission
`administer alttexting settings` (`alttexting.permissions.yml`) — gates the settings form only.
No permission controls generation itself (see agent/api/endpoints.md for route access).
