<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Use the Responsive Image Link Formatter

No settings page (`configure: null`). Configure on the entity's **Manage display**, per image field,
per view mode — exactly like the parent module, but the output is a responsive `<picture>`.

## Prerequisites

- Modules enabled: **responsive_image_link_formatter** (which pulls in **image_link_formatter** and
  core **responsive_image**).
- A **responsive image style** exists (e.g. at `/admin/config/media/responsive-image-style`), since
  the core responsive formatter needs one to render.
- The bundle has an **image field** and a **Link field**.

## Via the UI

1. Bundle's *Manage display*, e.g. `/admin/structure/types/manage/article/display`.
2. For the image field, choose formatter **"Responsive image wrapped within link field"**.
3. In its settings: pick the **Responsive image style**, then in **"Link image to"** choose the Link
   field to wrap the image (the module added your Link fields to this dropdown).
4. Update, Save.

## Config location

`core.entity_view_display.<entity_type>.<bundle>.<view_mode>`:

```yaml
content:
  field_banner_image:
    type: responsive_image_link_formatter
    label: hidden
    settings:
      responsive_image_style: wide        # a responsive_image_style id (required to render)
      image_link: field_banner_link       # <-- the Link field whose URL wraps the image
```

Programmatic setup (drush php:eval):

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_banner_image', [
  'type' => 'responsive_image_link_formatter',
  'label' => 'hidden',
  'settings' => ['responsive_image_style' => 'wide', 'image_link' => 'field_banner_link'],
])->save();
```

Read back: `drush cget core.entity_view_display.node.article.default content.field_banner_image`.

## Behaviour

Identical link logic to the parent (`ImageLinkFormatterTrait`): each responsive image's `#url` is
set to the **same-delta** Link field value, empty link items leave that image unwrapped, and Link
Attributes / Link Target settings (target, rel) carry through. The difference from the parent is only
the base formatter — responsive `<picture>`/srcset markup instead of a single image style. See the
parent's [extend doc](../../../../../2.2.x/agent/extend/subclass.md) for subclassing (same trait).
