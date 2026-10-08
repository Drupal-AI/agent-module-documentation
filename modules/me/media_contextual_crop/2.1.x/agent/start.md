<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Contextual Cropping API (media_contextual_crop) — agent index

Version **2.1.9**, core `^10 || ^11`, depends on `crop:crop` + `drupal:field`.
An **API-only** base module: it lets the *same* image carry a *different crop per usage
context* (per referencing field/delta or per embed) by generating a **context-specific crop
entity** and a **context-specific image derivative URL** — working around core's rule of one
derivative per (image, image style). It renders nothing on its own; a companion "adapter" +
"use-case" module must supply the crop UI and the context source.

No settings page (`configure: null`), no permissions, no config object/schema. It defines
**two plugin types**, one **service**, **two field formatters**, a **Drush** command, its own
**derivative-delivery route + controller + path processor**, and preprocess hooks that hijack
the core image/responsive formatters.

- **Add a crop-widget adapter (Focal Point, Image Widget Crop)** → [plugins/crop-mechanisms.md](plugins/crop-mechanisms.md)
- **Add a context source (embed filter, reference-field formatter)** → [plugins/use-cases.md](plugins/use-cases.md)
- **Generate/flush a contextual derivative from code; how URLs are built & served** → [api/services.md](api/services.md)
- **Output a contextual image/URL on an image field** → [fields/formatters.md](fields/formatters.md)
- **Understand the formatter/theme interception (integrators)** → [hooks/preprocess.md](hooks/preprocess.md)
- **Migrate deprecated `contextual_image` displays** → [drush/commands.md](drush/commands.md)

## Key facts

- Service: `media_contextual_crop.service` → `Drupal\media_contextual_crop\MediaContextualCropService`
- Plugin managers: `plugin.manager.media_contextual_crop`, `plugin.manager.media_contextual_crop_use_case`
- Path processor: `path_processor.media_contextual_crop` (inbound, priority 350)
- Plugin type A — crop mechanism: dir `Plugin/MediaContextualCrop`, annotation `@MediaContextualCrop`, interface `MediaContextualCropInterface`, alter hook `contextual_crop_info`
- Plugin type B — use case/context: dir `Plugin/MediaContextualCropUseCase`, annotation `@MediaContextualCropUseCase`, interface `MediaContextualCropUseCaseInterface`, alter hook `media_contextual_crop_use_case_info`
- Field formatters (image): `image_contextual_url` (functional), `contextual_image` (DEPRECATED no-op subclass)
- Themes: `image_contextual`, `image_contextual_formatter`
- Routes: `media_contextual_crop.style_private` (`/system/files/contextual/styles/{image_style}/{context}/{scheme}`), `media_contextual_crop.style_public` (added by `Routing\ImageStyleRoutes::routes`, under the public files dir); controller `ContextualImageStyleDownloadController::process`
- Derivative URI: `{scheme}://contextual/styles/{style}/{source_scheme}/{target_with_dots_as_underscores}/{crop_id}.{ext}`
- Context string: `{entity_type}:{bundle}:{entity_id}.{field_name}.{delta}`
- Drush: `media_contextual_crop:migrateToImageFormatter` (service `media_contextual_crop.migrate`)
- Install/update: `update_10202`, `update_10210` flush legacy public derivative folders
- Requires composer patches: core `2685905` (refactor `ImageStyleDownloadController`) and crop `2617818` (contextual crop capability)
- Companion projects: crop adapters `media_contextual_crop_fp_adapter`, `media_contextual_crop_iwc_adapter`; use cases `media_contextual_crop_embed`, `media_contextual_crop_field_formatter`
