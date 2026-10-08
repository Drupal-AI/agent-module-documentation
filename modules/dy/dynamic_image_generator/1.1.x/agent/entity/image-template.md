<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Template entity (`poster_entity`)

Class `src/Entity/ImageTemplate.php` (`@ContentEntityType id = "poster_entity"`, label
"Image Template"), interface `ImageTemplateInterface`, base table `poster_entity`,
`admin_permission = administer poster entity`. Handlers: `EntityViewBuilder`,
`ImageTemplateListBuilder`, `EntityViewsData`, forms `ImageTemplateForm` (add/edit) and
`ImageTemplateDeleteForm`, access `ImageTemplateAccessControlHandler`.

## Base fields (`baseFieldDefinitions`)

| Field | Type | Notes |
|---|---|---|
| `title` | string (255) | Template name, required (entity `label` key). |
| `content_type` | list_string | Target node type; options from `dynamic_image_generator_get_content_types()`. Required. |
| `target_field` | string | Machine name of the node image/media field to write the generated image into. Optional. |
| `background_image` | image, cardinality −1 | Uploaded template images → tokens `[image_1]`, `[image_2]`, ... and `[image_random]`. `png jpg jpeg`, stored under `dynamic_image_generator/backgrounds`. |
| `html` | string_long | HTML template. Plain text (`text_processing = 0`). Tokens + Twig. Required. |
| `css` | string_long | CSS template. Plain text. Tokens + Twig. Required. |
| `status` | boolean | Active flag (default TRUE). Only active templates appear on node forms. |
| `created` / `changed` | created/changed | Timestamps. |

Accessors: `getTitle/setTitle`, `getContentType/setContentType`, `getTargetField/setTargetField`,
`getHTML/setHTML`, `getCSS/setCSS`, `getBackgroundImages()` (returns referenced File entities),
`isActive/setActive`.

## Form behaviour (`hook_form_poster_entity_form_alter`, in `.module`)

- AJAX `content_type` change reloads a **Target Field** select
  (`dynamic_image_generator_get_target_fields()` → image fields + `default:media` entity-reference
  fields on that content type). A JS shim syncs the select into the hidden `target_field` value;
  validated by `dynamic_image_generator_image_template_validate`.
- A **token browser** (Token module) lists `[node:*]`, global tokens, and any Custom Dynamic
  Tokens defined for the selected content type.
- A **Template Preview & Testing** section: live preview and preview-with-selected-node buttons
  (see api/generation-service.md).

## Routes (`.routing.yml`)

CRUD under `/admin/structure/dynamic-image-templates`:
`entity.poster_entity.collection` (`_entity_list`), `.add_form`, `.edit_form`, `.delete_form`,
`.canonical` — all require **`administer poster entity`**. Template settings (field UI base route)
`poster_entity.settings` at `.../settings` → `ImageTemplateSettingsForm`, same permission.

Note: the entity annotation's `links` point at `/admin/structure/poster_entity/...` while the
`.routing.yml` collection/CRUD routes use `/admin/structure/dynamic-image-templates/...`; the
routing-file paths are the operational ones.

## Access (`ImageTemplateAccessControlHandler`)

- `view`: inactive templates → `administer poster entity`; active → `view poster entity` OR
  `administer poster entity`.
- `update` / `delete` / create: `administer poster entity`.

All template management is admin-gated; there is no per-owner create/edit path despite the
permission names listed in the README.
