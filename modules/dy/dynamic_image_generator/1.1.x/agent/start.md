<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dynamic Image Generator (dynamic_image_generator) — agent index

Renders **HTML/CSS "Image Template" entities into images**, filling them with Drupal tokens,
uploaded-image tokens, custom tokens and Twig, then stores each result as a `dynamic_image`
**media** entity. Two rendering backends: the external **htmlcsstoimage / hcti.io** API, or a
local **wkhtmltoimage** binary via the bundled `image_creating_engine` submodule. Version 1.1.2
(dir `1.1.x`). Core `^10 || ^11`. License GPL-2.0-or-later.

Core deps: `file`, `image`, `media`, `node`, `user`, `views`, `field`, `system`. Suggests
`token` (in-form token browser). `configure` route = `dynamic_image_generator.admin`.

## What it provides

- **Content entity `poster_entity`** ("Image Template"), class `Entity/ImageTemplate.php`,
  admin permission `administer poster entity`, access handler
  `ImageTemplateAccessControlHandler`. Base fields: `title`, `content_type` (list_string, target
  node type), `target_field` (image/media field to write into), `background_image` (image,
  unlimited → `[image_N]` tokens), `html`, `css` (string_long, plain text, Twig-capable),
  `status`, `created`, `changed`. → [entity/image-template.md](entity/image-template.md)
- **Service** `dynamic_image_generator.dynamic_image_generator_service`
  (`Service/DynamicImageGeneratorService.php`): the token → render → image → media pipeline
  (`generatePosterImage`, `generatePreviewImage`, custom-token resolution). → [api/generation-service.md](api/generation-service.md)
- **Media type** `dynamic_image` + fields `field_dynamic_image`, `field_source_entity`,
  `field_template_id`, `field_is_preview_image` — created programmatically in `.install`.
- **Views** gallery `generated_dynamic_images` at `/admin/content/generated-dynamic-images`.
- **Settings** form (API provider/credentials, Custom Dynamic Tokens, debug) at
  `/admin/config/content/dynamic-image-generator/settings`, config object
  `dynamic_image_generator.settings`. → [config/settings.md](config/settings.md)
- **Node-form integration**: `hook_form_node_form_alter` adds an "Auto-generate Image" checkbox
  per qualifying template; submit handler calls the service on save. `hook_cron` deletes expired
  preview images. → [api/generation-service.md](api/generation-service.md)
- **Submodule `image_creating_engine`** (local wkhtmltoimage engine + `inbuilt` ImageGenerator
  plugin). → [../../modules/image_creating_engine/1.1.x/agent/start.md](../../modules/image_creating_engine/1.1.x/agent/start.md)

## Permissions (`.permissions.yml`)

`administer poster entity`, `create poster entity`, `view poster entity`,
`administer dynamic image generator`, `generate dynamic images`,
`view generated dynamic images`, `access dynamic image generator api`.

## Routes (`.routing.yml`), selected

- Entity CRUD `/admin/structure/dynamic-image-templates[...]` — `administer poster entity`.
- `dynamic_image_generator.admin` / `.settings` / `.example` — `administer dynamic image generator`.
- Preview: `.preview_with_data`, `.generate_preview`, `.generate_for_node` — `administer dynamic image generator`.
- Diagnostics: `.test_chrome`, `.test_chrome_direct`, `.test_wkhtml` — `administer dynamic image generator`.
- API stubs `.generate_poster` (`access dynamic image generator api`) and `.generate_poster_api`
  return `not implemented` in 1.1.2 (real generation runs via the node-form submit handler and
  preview routes).
- Gallery `generated_dynamic_images.page_1` — `view generated dynamic images`.

## Docs

- [config/settings.md](config/settings.md) — settings form, config object + schema, custom tokens.
- [entity/image-template.md](entity/image-template.md) — the `poster_entity` entity, fields, routes, permissions, access.
- [api/generation-service.md](api/generation-service.md) — generation service, token pipeline, node-form auto-generate, media, cron.
