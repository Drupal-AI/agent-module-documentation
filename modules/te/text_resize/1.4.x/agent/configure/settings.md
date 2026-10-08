<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Text Resize + place the block

Two things make Text Resize work: **placing the block** and **the settings config**.

## 1. Place the block

The block plugin id is **`text_resize_block`** (admin label "Text Resize"). Place it in a
region via *Structure → Block Layout* (`/admin/structure/block`), or via config:

```php
\Drupal\block\Entity\Block::create([
  'id' => 'textresize',
  'plugin' => 'text_resize_block',
  'theme' => \Drupal::config('system.theme')->get('default'),
  'region' => 'sidebar_first',
  'settings' => ['id' => 'text_resize_block', 'label' => 'Text Resize', 'label_display' => '0'],
  'visibility' => [],
])->save();
```

The block's `build()` returns `#theme => 'text_resize_block'` and attaches the
`text_resize/text_resize.resize` library. Access is granted to anyone with `access content`.

## 2. Settings config — `text_resize.settings`

Form route **`text_resize_settings`** at `/admin/config/user-interface/text_resize`
(`TextResizeSettingsForm`), permission **`administer text_resize`**.

| Key | Default | Meaning |
|---|---|---|
| `text_resize_scope` | `main` | CSS class / id / tag whose text is resized (e.g. `my-container`, `body`) |
| `text_resize_minimum` | `12` | smallest font size, px (also the default size) |
| `text_resize_maximum` | `25` | largest font size, px |
| `text_resize_reset_button` | `false` | show a reset (`A`) link |
| `text_resize_line_height_allow` | `false` | also adjust line height |
| `text_resize_line_height_min` | `16` | smallest line height, px |
| `text_resize_line_height_max` | `36` | largest line height, px |

Set / read via drush:

```bash
drush config:get text_resize.settings
drush config:set text_resize.settings text_resize_reset_button true -y
drush config:set text_resize.settings text_resize_scope body -y
```

`template_preprocess_text_resize_block()` passes these to the front end as
`drupalSettings.text_resize.{text_resize_scope, text_resize_minimum, text_resize_maximum,
text_resize_line_height_allow, text_resize_line_height_min, text_resize_line_height_max}` and
adds the reset link markup only when `text_resize_reset_button` is on.

## Theming / customisation

- Template: `text-resize-block.html.twig`; theme hook `text_resize_block`.
- Restyle via the link ids `#text_resize_increase`, `#text_resize_decrease`,
  `#text_resize_reset` (reset only when enabled), or override
  `template_preprocess_text_resize_block()` to change the HTML.
- Permission `administer text_resize` gates the settings form only.
