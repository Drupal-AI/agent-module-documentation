<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Sizes (image_sizes) — agent index

Loads the image-style derivative that matches an image's **parent container width** (not the
viewport), chosen **client-side**. This is *not* native `srcset`/`sizes`: the formatter emits an
`<img>` with a `data-src` JSON map of `{derivativeWidth: url}` plus a placeholder `src`, and
`js/image-sizes.es.js` picks the smallest URL wide enough for `parentWidth × devicePixelRatio`.

- Package **Media**. Depends only on core **`image`**. Core `^9 || ^10 || ^11`. GPL-2.0-or-later.
  Installed **3.0.3**. Config route `entity.image_sizes_preset_entity.collection`.
- Submodule **`image_sizes_defaults`** ships Default/Landscape/Portrait presets (docs:
  `../modules/image_sizes_defaults/3.x/agent/start.md`).

## What it provides (from source)

- **Config entity** `image_sizes_preset_entity` (`src/Entity/ImageSizesPresetEntity.php`), a
  "preset": exported keys `id, label, uuid, fallback, styles, preload`. Admin UI under
  `/admin/config/media/image_sizes_preset_entity` (add/edit/delete/collection), admin permission
  **`administer image sizes`** (`image_sizes.permissions.yml`).
- **Field formatter** `image_sizes_preset_formatter` (label "Image sizes presets"),
  `src/Plugin/Field/FieldFormatter/ImageSizesPresetFormatter.php`, `field_types = {image,
  entity_reference}` (entity_reference only applies to media, per `ImageSizesFormatterTrait`).
  Settings: `preset` (required), `load_invisible`.
- **Service** `image_sizes` → `ImageSizesService` (`@file_system`, `@image.factory`,
  `@entity_type.manager`): builds the `data-src` map, fallback URL, and inline base64 placeholder.
- **Theme** `image_sizes` → `templates/image-sizes.html.twig` = `<img {{ attributes }} />`;
  `template_preprocess_image_sizes()` in `image_sizes.module` merges the service attributes and
  attaches library `image_sizes/core` (CSS + `image-sizes.es.js`).
- **Drush** (`drush.services.yml`): `image-sizes:generate`/`isg`
  (`src/Commands/GenerateImageSizeCommand.php`) and `image-sizes:add-format`/`isaf`
  (`src/Commands/AddFormatCommand.php`).
- **Config schema** in `config/schema/` for the preset entity and both formatter settings.

## Solution docs

- The formatter, preset config entity, schema, service and JS mechanism →
  [fields/formatter.md](fields/formatter.md)
- Building presets and the `isg`/`isaf` Drush commands → [config/presets.md](config/presets.md)
