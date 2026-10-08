<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create a slideshow media type

There is no module settings page. You create a Media type that uses the `slideshow` source and
map its `source_field` to a multi-value `entity_reference` field (the slides).

## Via the UI

1. *Structure → Media types → Add media type*.
2. Media source: **Slideshow**.
3. Save — Drupal creates/asks for a source field. Use (or add) a multi-value **entity_reference**
   field, typically targeting **Media**, and set it as the source field.
4. On the type's Manage fields, set the reference field's cardinality to unlimited and restrict the
   target bundles to the slide media types you allow.

## Via config / drush (scriptable)

The source config lives on the `media_type` config entity:

```php
use Drupal\media\Entity\MediaType;
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

// 1. The media type using the slideshow source.
MediaType::create([
  'id' => 'mes_show',
  'label' => 'Slideshow',
  'source' => 'slideshow',
  'source_configuration' => ['source_field' => 'field_mes_slides'],
])->save();

// 2. The entity_reference source field (the slides), referencing media.
FieldStorageConfig::create([
  'field_name' => 'field_mes_slides', 'entity_type' => 'media',
  'type' => 'entity_reference', 'cardinality' => -1,
  'settings' => ['target_type' => 'media'],
])->save();
FieldConfig::create([
  'field_name' => 'field_mes_slides', 'entity_type' => 'media',
  'bundle' => 'mes_show', 'label' => 'Slides',
])->save();
```

Read it back:

```bash
drush cget media.type.mes_show source          # -> slideshow
drush cget media.type.mes_show source_configuration.source_field   # -> field_mes_slides
```

Or in PHP: `MediaType::load('mes_show')->getSource()->getPluginId()` → `slideshow`.

## Config schema

`media.source.slideshow` extends `media.source.field_aware`, i.e. the source configuration accepts
the standard `source_field` key. The `ItemsCount` constraint (≥1 slide) is applied automatically to
media entities of this type.
