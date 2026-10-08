<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Contextual Crop Reference (media_contextual_crop_field_formatter) — agent index

Lets one media item be cropped **per reference** instead of once per media entity, so the same photo
can be a wide banner in one place and a square thumbnail in another with no duplicate media. Despite
the project name, in 2.0.x this module **provides no field formatter plugin** — the legacy
`media_contextual_crop_image` formatter was removed by `hook_update_10103`, which rewrites any view
display still using it back to core `image`. The actual work is done by (1) a single
`MediaContextualCropUseCase` plugin, id **`references`**, that plugs into the crop pipeline defined by
the parent `media_contextual_crop` module, and (2) a set of entity-lifecycle hooks in the `.module`
that keep `crop` entities in sync with the referencing field.

The mechanism: `media_library_media_modify` stores per-reference overrides on an
`entity_reference_entity_modify` field item (in its `overwritten_property_map`). The `references`
use-case plugin (`References::getCropSettings()`) reads that override off the media's referring item
and turns it into crop settings bound to a **context string** unique to that reference
(`{entity_type}:{bundle}:{id}.{field_name}.{delta}`). The `.module` hooks then delete the matching
`crop` entities when the host entity is updated (delta shifted / media swapped) or deleted, and the
`..._referenced_entity_values_alter` hook lets each registered crop adapter rewrite the override
value on save. Nearly all rendering/storage logic lives in the two parent modules — debug there.

- Depends on: `field`, `media` (core), `media_contextual_crop:media_contextual_crop`,
  `media_library_media_modify:media_library_media_modify`.
- Core: `^10 || ^11`. Package: `Media Contextual Cropping`.
- Composer notably requires `cweagans/composer-patches ^1.7` (install applies a patch to
  `media_library_media_modify`, so that plugin must be in `config.allow-plugins`) and accepts
  `media_library_media_modify` at `^2.0.0@beta`.
- No settings page / `configure` route. No routes, services, permissions, config schema, drush,
  libraries, or templates.
- Does **not** define a plugin type; it provides one instance of a type owned by
  `media_contextual_crop`.

## What you'd do → where

- **Understand or extend the `references` use-case plugin (how a crop is bound to a single
  reference)** → [plugins/use-case.md](plugins/use-case.md)
- **Understand crop cleanup on host-entity edit/delete, the media-library value-alter integration,
  or the 1.x→2.x legacy-formatter update** → [hooks/lifecycle.md](hooks/lifecycle.md)

## Key facts (real machine names)

- Provides one plugin instance (not a type): use-case id **`references`**, plugin type
  `MediaContextualCropUseCase` (manager `plugin.manager.media_contextual_crop_use_case`, defined by
  `media_contextual_crop`). Class
  `Drupal\media_contextual_crop_field_formatter\Plugin\MediaContextualCropUseCase\References`, extends
  `Drupal\media_contextual_crop\MediaContextualCropUseCasePluginBase`. Annotation:
  `id = "references"`, `label = @Translation("References")`, `default_folder = "media_contextual_crop"`.
- Overridden/implemented plugin methods: `isCompetent(ImageItem $item)`, `getCropSettings(ImageItem $item)`
  (plus private `getPluginSetting(array)`). Base also supplies `label()` and
  `getContextualizedImage()`.
- Hooks (`.module`): `hook_help` (`help.page.media_contextual_crop_field_formatter`),
  `hook_media_library_media_modify_referenced_entity_values_alter`, `hook_entity_update`,
  `hook_entity_delete`.
- Private helpers: `_media_contextual_crop_field_formatter_get_media_contextual_fields()`,
  `_media_contextual_crop_field_formatter_get_base_context()`,
  `_media_contextual_crop_field_formatter_get_crops_from_entity_field()`.
- Update hook (`.install`): `media_contextual_crop_field_formatter_update_10103()` — replaces legacy
  formatter `media_contextual_crop_image` with core `image` in every `core.entity_view_display.*`.
- Keys off the field type `entity_reference_entity_modify` (from `media_library_media_modify`).
- Crop `context` string format: `{entity_type}:{bundle}:{id}.{field_name}.{delta}`;
  `base_crop_folder` / `default_folder` = `media_contextual_crop`.
