<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `references` use-case plugin

File: `src/Plugin/MediaContextualCropUseCase/References.php`.

This module contributes **one** plugin instance to the `MediaContextualCropUseCase` plugin type that
`media_contextual_crop` defines (manager service `plugin.manager.media_contextual_crop_use_case`,
annotation `@MediaContextualCropUseCase`, base
`Drupal\media_contextual_crop\MediaContextualCropUseCasePluginBase`). It does **not** define a plugin
type of its own — writing another use case means adding a class under some module's
`Plugin/MediaContextualCropUseCase/`, not extending anything here.

Annotation:

```php
@MediaContextualCropUseCase(
  id = "references",
  label = @Translation("References"),
  default_folder = "media_contextual_crop"
)
```

## What it is for

A use case answers, for a given `ImageItem` being rendered through the crop pipeline: *is this image
being used in a way I recognise, and if so what crop should apply here?* The `references` use case
recognises an image whose media is referenced through a `media_library_media_modify`
per-reference-modification field, and returns the crop that the editor set on that specific
reference.

## Contract (interface `MediaContextualCropUseCaseInterface`)

- `isCompetent(ImageItem $item): bool` — overridden here (`References.php:24`). Returns TRUE only when
  the image's parent entity is a `MediaInterface`, that media carries an
  `entity_reference_entity_modify` value (`$entity_parent->entity_reference_entity_modify`) **and** a
  `_referringItem`, and the media source field's item class is `ImageItem` (or a subclass). Otherwise
  FALSE, so the use case stays out of the way for ordinary (non-referenced) media.
- `getCropSettings(ImageItem $item): array|null` — the core method (`References.php:56`). Steps:
  1. Bail unless the parent is a `MediaInterface`.
  2. Read the per-reference override from `$entity_parent->_referringItem->getValue()`; the crop data
     is the JSON in `overwritten_property_map`, decoded with `Json::decode()`.
  3. Resolve the media's image source field name via
     `$entity_parent->getSource()->getSourceFieldDefinition(...)` (again requiring an `ImageItem`
     class).
  4. For the override entry keyed by that image field, call the private `getPluginSetting()` to match
     it to a registered crop adapter, then return
     `['plugin_id' => …, 'crop_setting' => …, 'context' => $crop_context_ref, 'base_crop_folder' => 'media_contextual_crop']`.
  Returns `null` when there is no override, no matching field, or no matching adapter.
- `label()` and `getContextualizedImage(...)` are inherited unchanged from the base.

## `getPluginSetting(array $configuration)` (private, `References.php:119`)

Iterates the **crop-adapter** plugin definitions from `$this->mccPluginManager` (the
`plugin.manager.media_contextual_crop` manager injected by the base class). Each adapter definition
declares a `target_field_name`; when the override array contains that key, this returns
`['plugin_id' => <adapter id>, 'crop_setting' => <that value>]`. This is how a raw override map is
turned into "adapter X with these crop values" without the use case knowing about Focal Point,
ImageWidget Crop, etc. directly — the adapter modules
(`media_contextual_crop_fp_adapter`, `media_contextual_crop_iwc_adapter`) supply those definitions.

## Dependencies injected via the base

The base class `create()` injects `plugin.manager.media_contextual_crop` (as `$this->mccPluginManager`)
and `media_contextual_crop.service` (as `$this->mccService`). This plugin uses only
`$this->mccPluginManager`.
