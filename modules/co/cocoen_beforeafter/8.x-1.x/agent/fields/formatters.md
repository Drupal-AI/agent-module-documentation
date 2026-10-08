<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable and configure the Cocoen before/after formatters

No configure route (`configure: null`). You pick the formatter per field, per view mode, on the
bundle's **Manage display** page (or directly in `entity_view_display` config). First download the
Cocoen library (see [start.md](../start.md)) or the slider will not initialise.

## The two formatters

| Formatter id | Applies to | Notes |
|---|---|---|
| `cocoen_before_after_image` | `image` fields | Uses the first two image items. |
| `cocoen_before_after_media` | `entity_reference` fields targeting **media** | Uses the first two referenced media items; reads each media's source image field. |

Both require the field to allow **at least two values** (cardinality ≥ 2 or unlimited). Only the first
two deltas are rendered; extra values are ignored.

## Settings

One setting, shared by both formatters:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `image_style` | string (image style id) | `''` (Original size) | Image style applied to both images. Empty/`default` → absolute original file URL. |

Config schema: `field.formatter.settings.cocoen_before_after_image` (see `config/schema`).

## Where it is stored

Config entity `core.entity_view_display.<entity_type>.<bundle>.<view_mode>`:

```yaml
content:
  field_before_after:
    type: cocoen_before_after_image      # or cocoen_before_after_media
    label: hidden
    settings:
      image_style: large
    third_party_settings: {}
```

## Via the UI

1. Create a multi-value image field (or a media reference field), cardinality **2** or unlimited.
2. Go to the bundle's *Manage display* (e.g. `/admin/structure/types/manage/article/display`).
3. In the field's **Format** column choose **Cocoen Before After Image** (or **Cocoen Before After Media**).
4. Click the gear, pick an **Image style**, **Update**, then **Save**.
5. On a node, upload/reference **two** images (first = before, second = after).

## Via drush php:eval (scriptable)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_before_after', [
  'type' => 'cocoen_before_after_image',
  'label' => 'hidden',
  'settings' => ['image_style' => 'large'],
  'third_party_settings' => [],
])->save();
```

Read it back: `drush cget core.entity_view_display.node.article.default content.field_before_after`.
