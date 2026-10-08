<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Magnific Popup formatter

There is **no configure route and no settings form**. You enable Magnific Popup by choosing it
as a field's *format* on the entity's **Manage display** page (or directly in the
`entity_view_display` config).

## The two formatters

| Formatter id | Field type | Notes |
|---|---|---|
| `magnific_popup` | `image` | The main formatter (extends core `ImageFormatterBase`). |
| `video_embed_field_magnific_popup` | `video_embed_field` | Only available when the Video Embed Field contrib module is installed. |

## Image formatter settings

Stored under the field's component `settings` in
`core.entity_view_display.<entity_type>.<bundle>.<view_mode>`:

| Setting | Values / default | Meaning |
|---|---|---|
| `thumbnail_image_style` | image style machine name, or `''` (default) | Style for the clickable thumbnail; empty = original image. |
| `popup_image_style` | image style machine name, or `''` (default) | Style for the large image shown in the popup; empty = original. |
| `gallery_type` | `all_items` (default), `first_item`, `separate_items` | `all_items` = all thumbnails, one gallery. `first_item` = only the first thumbnail is visible but the popup galleries through all. `separate_items` = each item is its own popup (no gallery). |
| `vertical_fit` | `'true'` (default), `'false'` | `'true'` fits image vertically; `'false'` horizontally (for very tall images). Stored as a string. |

Note the config schema (`field.formatter.settings.magnific_popup`) only declares
`thumbnail_image_style`, `popup_image_style`, `gallery_type`; `vertical_fit` is a plugin
default that is still saved on the component.

## Via drush php:eval (scriptable)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_gallery', [
  'type' => 'magnific_popup',
  'region' => 'content',
  'label' => 'hidden',
  'settings' => [
    'thumbnail_image_style' => 'thumbnail',
    'popup_image_style' => 'large',
    'gallery_type' => 'all_items',
    'vertical_fit' => 'true',
  ],
])->save();
```

## Read it back

```bash
drush cget core.entity_view_display.node.article.default content.field_gallery
# component 'type' should be magnific_popup, with the settings above
```

Requirement: the Magnific Popup JS/CSS library must be installed at `web/libraries/magnific-popup`
(see [api/library.md](../api/library.md)) or the popup will not initialize in the browser.
