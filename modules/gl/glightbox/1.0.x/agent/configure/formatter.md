<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GLightbox image field formatters

GLightbox provides two field formatters for **`image`** fields. Set them on an entity's
*Manage display*.

| Formatter id | Class | Use |
|---|---|---|
| `glightbox` | `GLightboxFormatter` | thumbnail (image style) that opens the image in a GLightbox popup |
| `glightbox_responsive` | `GLightboxResponsiveFormatter` | same, but the opened image uses a **responsive image style** |

## Per-formatter settings

Schema `field.formatter.settings.glightbox`:

```yaml
glightbox_node_style: ''                 # image style for the thumbnail link
glightbox_node_style_first: ''           # optional distinct style for the first item
glightbox_image_style: ''                # image style used for the opened (lightbox) image
glightbox_gallery: ''                    # gallery grouping mode (e.g. post / page / field)
glightbox_gallery_custom: ''             # custom gallery id token
glightbox_caption: ''                    # caption source (title / alt / custom …)
glightbox_caption_custom: ''
glightbox_caption_description: ''         # longer description source
glightbox_caption_description_custom: ''
```

## Set it in the UI

1. *Manage display* for the bundle (e.g. `/admin/structure/types/manage/article/display`).
2. Choose **GLightbox** (or **GLightbox Responsive**) as the format for the image field.
3. Click the cog to pick the thumbnail image style, the lightbox image style, gallery grouping,
   and caption/description sources. **Update**, then **Save**.

## Set it in code

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_image', [
  'type' => 'glightbox',
  'label' => 'hidden',
  'settings' => [
    'glightbox_node_style' => 'thumbnail',
    'glightbox_image_style' => 'large',
    'glightbox_gallery' => 'post',
  ],
])->save();
// read back: drush cget core.entity_view_display.node.article.default content.field_image
```

## Galleries

Items sharing a gallery id navigate together inside one lightbox. `GalleryIdHelper` (service
`glightbox.gallery_id_generator`) builds the id from the chosen grouping mode and an optional token;
enable `advanced.unique_token` in the global settings to keep each entity's gallery separate.
