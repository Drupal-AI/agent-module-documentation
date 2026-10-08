<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Featured Image (ai_featured_image) — agent index

Generates a **featured image for a node via OpenAI DALL-E** when the node is saved
with an empty image field. Package *Artificial Intelligence*. Core `^11`. Depends on
core **`node`** and **`file`** only. License GPL-2.0-or-later. Version 1.0.0.

- **Settings form, config keys, and the presave hook** → [config/settings.md](config/settings.md)
- **The `FeaturedImageGenerator` service (prompt → OpenAI → File)** → [api/generator.md](api/generator.md)

## What it actually is

- **No entities, no plugins, no permissions file, no Drush, no config schema.** The whole
  module is: one `hook_entity_presave()` in `ai_featured_image.module`, one settings form
  `Form\SettingsForm` (route `ai_featured_image.settings` at
  `/admin/config/content/ai-featured-image`, `_permission: 'administer site configuration'`),
  and one service `Service\FeaturedImageGenerator` (id `ai_featured_image.generator`).
- Config object `ai_featured_image.settings` (schema-less — no `config/schema/`): `enabled`
  (bool), `openai_api_key` (string), `enabled_content_types` (array of bundle ids),
  `image_field` (string machine name), `prompt_template` (string).

## Mechanism (from source)

- `ai_featured_image_entity_presave($entity)`: bails unless `$entity` is a node, `enabled` is
  TRUE, the bundle is in `enabled_content_types`, and the configured `image_field` is present
  **and empty**. Then calls `FeaturedImageGenerator::generateImageForNode()` and, on success,
  sets `image_field = ['target_id' => $file->id()]`.
- `FeaturedImageGenerator::generateImageForNode()`: builds the prompt with
  `strtr($prompt_template, ['[title]' => title, '[body]' => body])`, POSTs to
  `https://api.openai.com/v1/images/generations` (Guzzle, `Authorization: Bearer <key>`,
  `size 1024x1024`, `n 1`), reads `data[0].url`, fetches it with `file_get_contents()`, and
  writes it to `public://ai_images/featured-<time>.png` via `file.repository`. Errors are
  caught and logged to the `ai_featured_image` channel; returns `NULL` on any failure.

## Integration notes

- Calls **OpenAI directly** — it does NOT use the `drupal/ai` provider abstraction (unlike the
  sibling `ai_image_filename` / `ai_jsonld_schema_generator` / `ai_metatag_generator` modules).
  Requires an OpenAI account with DALL-E access.
- Runs synchronously inside node save, so saving a node makes a blocking outbound API call.
- The target field must be a normal image/file field (a File-entity reference). Media fields
  are not supported in 1.0.x.
