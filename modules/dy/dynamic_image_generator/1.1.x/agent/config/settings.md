<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & configuration

## Install / enable

`drush en dynamic_image_generator` (pulls core file/image/media/node/user/views/field). Optional:
enable the bundled submodule `image_creating_engine` for local rendering, and `token` for the
in-form token browser. `hook_install` (`dynamic_image_generator.install`) creates the storage
directories (`public://dynamic_image_generator/{generated,backgrounds}`), the `dynamic_image`
media type and its fields, and (on the next cache flush) the gallery View.

## Config object `dynamic_image_generator.settings`

Install defaults (`config/install/dynamic_image_generator.settings.yml`), schema in
`config/schema/dynamic_image_generator.schema.yml`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `api_provider` | string | `htmlcsstoimage` | `htmlcsstoimage` (external API) or `inbuilt` (local wkhtml engine, only if `image_creating_engine` enabled). |
| `api_user_id` | string | `''` | External-API user ID (HTTP basic-auth username). |
| `api_key` | string | `''` | External-API key (basic-auth password) — stored plaintext in config. |
| `api_endpoint` | uri | `https://hcti.io/v1/image` | External-API endpoint. |
| `default_width` | integer | `1200` | Default image width (px). |
| `default_height` | integer | `630` | Default image height (px). |
| `image_format` | string | `png` | `png` / `jpg` / `jpeg` / `webp` (webp only via external API). |
| `quality` | integer | `90` | JPEG/WebP quality. |
| `debug_mode` | boolean | `false` | Logs API request/response detail to the `dynamic_image_generator` channel. |
| `custom_tokens` | sequence | `[]` | Custom Dynamic Token definitions (see below). |

Note: the width/height/format/quality generation-settings fields are commented out in the
settings form (`DynamicImageGeneratorSettingsForm`), so in 1.1.2 those keys are typically left at
their install defaults and overridden per call via the service `$options`.

## Settings form — `DynamicImageGeneratorSettingsForm`

Route `dynamic_image_generator.settings` at
`/admin/config/content/dynamic-image-generator/settings`, permission
`administer dynamic image generator`, form id `dynamic_image_generator_api_settings_form`.

- **API Configuration**: radio provider selector (external vs. built-in, AJAX-toggled), user ID,
  key (password field; blank keeps the current key; status line shows the last 8 chars),
  endpoint. "Test API Connection" / "Test Built-in Generator" buttons render a test image inline.
- **Custom Dynamic Tokens**: add/delete rows, each persisted immediately to config. A row =
  `token_name` (lowercase `[a-z0-9_]+`, used as `[token_name]`), `content_type`, `field_name`,
  optional `reference_field` (a sub-field of an entity-reference target), and `random` (pick a
  random delta of a multi-value field). Resolved at generation time by
  `DynamicImageGeneratorService::resolveCustomTokensForNode()`.
- **Advanced**: Debug Mode checkbox.

## Other admin routes

- `dynamic_image_generator.admin` — overview page (`DynamicImageGeneratorAdminController::overview`).
- `dynamic_image_generator.example` — usage examples page.
- `dynamic_image_generator.test_chrome` / `.test_chrome_direct` / `.test_wkhtml` — server
  diagnostics for Chromium / Browsershot / wkhtmltoimage availability.
- Gallery View `generated_dynamic_images` (page `/admin/content/generated-dynamic-images`,
  permission `view generated dynamic images` on the route; the View's own access is `access
  content`).
