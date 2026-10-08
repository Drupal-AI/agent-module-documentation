<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Range Slider field widget

Widget plugin `Drupal\range_slider\Plugin\Field\FieldWidget\RangeSliderWidget`, id **`range_slider`**,
label "Range Slider". Field types it supports: **`integer`, `decimal`, `float`** (core numeric fields).

## Settings (per form-display component)

Schema: `field.widget.settings.range_slider`.

| Key | Values | Default | Effect |
|---|---|---|---|
| `orientation` | `horizontal`, `vertical` | `horizontal` | sets the element's `#data-orientation`. |
| `output` | `_none_`, `below`, `above`, `left`, `right` | `_none_` | where the live value is shown; `_none_` = no output. |

`_none_` is the class constant `RangeSliderWidget::OPTION_NONE`. The widget copies the field's
`min`/`max` storage settings onto the element (`#min`, `#max`).

## Enable it on a field (UI)

1. Go to the bundle's *Manage form display* (e.g. `/admin/structure/types/manage/article/form-display`).
2. On an integer/decimal/float field row, choose widget **Range Slider**.
3. Click the cog, set **Orientation** and **Output**, **Update**, then **Save**.

## Enable it via config (drush)

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('field_my_number', [
  'type' => 'range_slider',
  'region' => 'content',
  'settings' => ['orientation' => 'vertical', 'output' => 'above'],
])->save();
```

Read it back:

```bash
drush cget core.entity_form_display.node.article.default content.field_my_number
# look for type: range_slider and settings.orientation / settings.output
```

The settings summary shows e.g. "Orientation: Vertical" and "Output: Above" (or "No output").
