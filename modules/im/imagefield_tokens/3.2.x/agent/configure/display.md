<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Select the token widget & formatter

Image Field Tokens has no settings form — you enable it by choosing its widget/formatter on an
existing core **Image** field.

## Widgets (Manage form display)

| Widget id | Extends | Available when |
|---|---|---|
| `imagefield_tokens` | core `image_image` | always |
| `imagefield_tokens_widget_crop` | `image_widget_crop`'s widget | only if `image_widget_crop` is enabled (`hook_field_widget_info_alter` removes it otherwise) |

Choosing the widget adds a **token-tree link** to the image widget so editors can insert tokens
into the Alt and Title fields. Set on `core.entity_form_display.<entity>.<bundle>.<mode>`:

```php
$fd = \Drupal::service('entity_display.repository')->getFormDisplay('node', 'article', 'default');
$fd->setComponent('field_image', [
  'type' => 'imagefield_tokens',
  'settings' => ['preview_image_style' => 'thumbnail', 'progress_indicator' => 'throbber'],
])->save();
```

## Formatters (Manage display)

| Formatter id | Extends | Available when |
|---|---|---|
| `imagefield_tokens` | core image formatter | always |
| `imagefield_tokens_colorbox` | Colorbox image formatter | only if `colorbox` is enabled (`hook_field_formatter_info_alter` removes it otherwise) |

> **Compatibility caveat (observed on this Drupal 11.4 site):** `ImageFieldTokensFormatter::create()`
> passes the wrong number of arguments to the core `ImageFormatter::__construct()`, which gained an
> 11th `$imageDerivativeUtilities` parameter in Drupal 11.4. Selecting/saving the `imagefield_tokens`
> formatter therefore throws `ArgumentCountError: Too few arguments to
> Drupal\image\Plugin\Field\FieldFormatter\ImageFormatter::__construct()`. The **widget** is
> unaffected; on 11.4+ use the widget for token entry and (until the module is patched) the plain
> core image formatter, or an older core, for display.

The formatter replaces tokens in the stored Alt/Title at render time. Set on
`core.entity_view_display.<entity>.<bundle>.<mode>`:

```php
$vd = \Drupal::service('entity_display.repository')->getViewDisplay('node', 'article', 'default');
$vd->setComponent('field_image', [
  'type' => 'imagefield_tokens',
  'label' => 'hidden',
  'settings' => ['image_style' => 'large', 'image_link' => ''],
])->save();
```

Read back: `drush cget core.entity_view_display.node.article.default content.field_image`.

## Notes

- Alt/Title values that contain tokens (e.g. `[node:title]`) are stored verbatim on the image item;
  they are only expanded on output (formatter) and in the widget preview.
- The module also declares these widgets compatible with FileField Sources
  (`hook_filefield_sources_widgets`) and, when IMCE is present, adds them to IMCE's supported
  widgets (`hook_imce_supported_widgets_alter`).
