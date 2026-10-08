<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Textimage field formatters

Textimage provides two field formatters. Configure them on an entity's **Manage display**
(`entity_view_display` config). Both need an image style that contains a "Text overlay" effect.

## `textimage_text_field_formatter`

Field types: `text`, `text_long`, `text_with_summary`. The field's text is used as the overlay
text. Settings (schema `field.formatter.settings.textimage_text_field_formatter`):

| Key | Meaning |
|---|---|
| `image_style` | image style (with a Text overlay effect) used to build the image |
| `image_text_values` | for multi-value text fields: single combined image vs one image per value |
| `image_link` | `''`, `content` (link to entity) or `file` (link to image file) |
| `image_alt` | `alt` attribute; tokens allowed; falls back to field's alt |
| `image_title` | `title` attribute; tokens allowed |
| `image_build_deferred` | defer image building to a subsequent request |

## `textimage_image_field_formatter`

Field type: `image`. Overlay text comes from the "Text overlay" effect's Default text; the
uploaded image is available as `file` token context. Settings
(`field.formatter.settings.textimage_image_field_formatter`): `image_style`, `image_link`,
`image_alt`, `image_title`, and `image_loading.attribute` (`lazy` / `eager`).

## Example (drush)

```php
$d = \Drupal::service('entity_display.repository')->getViewDisplay('node','article','default');
$d->setComponent('field_tagline', [
  'type' => 'textimage_text_field_formatter',
  'settings' => ['image_style' => 'my_textimage_style', 'image_link' => 'content'],
])->save();
```

Read it back: `drush cget core.entity_view_display.node.article.default content.field_tagline`.

## Tokens in overlay text

Text formatter resolves tokens against `node` + `user`; image formatter against `node`, `user`,
`file` (the uploaded image). Put `[node:title]` etc. directly in the field text, or use
`[textimage:default]` in a text field to reuse the effect's Default text.
