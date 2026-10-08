<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & the presave trigger

## Install / enable

`drush en ai_featured_image` (or via the UI). Depends only on core `node` and `file`. There is
no `.install`, no config schema, and no default config shipped — the config object is created
the first time you save the settings form.

## Settings form

- Route `ai_featured_image.settings` → `/admin/config/content/ai-featured-image`, permission
  **`administer site configuration`** (defined in `ai_featured_image.routing.yml`; the module
  ships no permissions of its own).
- `Form\SettingsForm` (form id `ai_featured_image_settings`), editable config
  `ai_featured_image.settings`. Fields:

| Key | Widget | Meaning |
|---|---|---|
| `enabled` | checkbox | Master on/off for automatic generation. |
| `openai_api_key` | textfield (maxlength 512, `#required`) | OpenAI API key used as the Bearer token. |
| `enabled_content_types` | checkboxes (`node_type_get_names()`) | Bundles where generation runs; saved via `array_filter()` so only checked ids persist. |
| `image_field` | textfield | Machine name of the image/file field to fill (e.g. `field_image`). |
| `prompt_template` | textfield | Prompt with `[title]` / `[body]` placeholders. Default `Header image about: [title]`. |

There is **no `config/schema/`**, so these keys are stored as schema-less config (they still
export with `drush cex`, but without typed-data validation).

## The presave trigger (`ai_featured_image.module`)

`ai_featured_image_entity_presave(EntityInterface $entity)` runs on every entity save and
returns early unless **all** of:

1. `$entity instanceof NodeInterface`;
2. `ai_featured_image.settings:enabled` is truthy;
3. `$entity->bundle()` is in `enabled_content_types`;
4. the configured `image_field` is set **and** `$entity->get($image_field)->isEmpty()` (an
   existing image is never overwritten).

When it proceeds it calls `ai_featured_image.generator`'s `generateImageForNode($entity)` and,
if a File is returned, sets `$entity->set($image_field, ['target_id' => $file->id()])` before
the node is written. See [../api/generator.md](../api/generator.md) for the generation call.

## Operational notes

- Generation happens **inside node save** and blocks on the OpenAI round-trip; a slow/failed API
  call slows the save (failures are logged and the node saves without an image).
- The field named in `image_field` must exist on the bundle and be an image/file field. A wrong
  or missing name means condition 4 is false and nothing happens.
- Generated files land in `public://ai_images/` (the directory is created on demand) as
  `featured-<unix_time>.png`.
