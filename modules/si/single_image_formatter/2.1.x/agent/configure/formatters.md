<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The single-value formatters

Every plugin in this project extends a core formatter and overrides `getEntitiesToView()` to return
only the first delta (`$file = reset($files); return $file ? [$file] : [];`). Unless noted, settings
and config schema are inherited from the parent formatter unchanged.

| Formatter id | Provided by | Field type | Extends core | Enable module |
|---|---|---|---|---|
| `single_image_formatter` | single_image_formatter | `image` | `ImageFormatter` | image (core) |
| `single_responsive_image_formatter` | single_image_formatter_responsive | `image` | `ResponsiveImageFormatter` | responsive_image |
| `single_media_formatter` | single_image_formatter_media | `entity_reference` (media) | `MediaThumbnailFormatter` | media |
| `single_entity_formatter` | single_image_formatter_media | `entity_reference` | `EntityReferenceEntityFormatter` | media |

`single_media_formatter` is the one exception to "settings inherited unchanged": in 2.1.x it adds a
`responsive_image_style` setting that, when set, renders the media's original source image through a
responsive image style instead of the thumbnail. See the media submodule docs. All other formatters
add nothing beyond their parent.

## Select it (UI)

Structure → (entity type / bundle) → **Manage display** (for the target view mode) → set the field's
Format to "Single image formatter" (or "Single responsive image" / "Single media thumbnail" /
"Single rendered entity"), then use the formatter cog to set the inherited options (image/responsive
style, link to content/file, view mode, etc.).

![Manage display formatter select showing "Single image formatter"](../../../../../../../screenshots/single_image_formatter/2.1.x/manage-display-formatter-select.png)

## Set it via config (example)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.teaser');
$vd->setComponent('field_image', [
  'type' => 'single_image_formatter',
  'label' => 'hidden',
  'settings' => ['image_style' => 'medium', 'image_link' => 'content'],
])->save();
```

The formatter changes only *how many* items render (one); every other behavior is core's. Field
cardinality is untouched — all values remain stored and available to other view modes.
