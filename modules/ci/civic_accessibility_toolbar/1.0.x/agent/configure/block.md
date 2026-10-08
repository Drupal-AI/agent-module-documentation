<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure & place the toolbar block

There is no global settings page. Configuration is per **block instance**.

## Place the block

`admin/structure/block` → **Place block** → *Accessibility Toolbar* (plugin id
`accessibility_toolbar_block`, admin label "Accessibility Toolbar"), into any region. Use the standard
core **Visibility** conditions (pages, roles, content types) to scope where it appears.

## Block settings (`blockForm`)

| Setting (config key) | Type | Default | Effect |
|---|---|---|---|
| `text_resize` | checkbox | `TRUE` | Show the text-resize button group (A / A / A → 100/125/150%). |
| `text_resize_label` | textfield | `Text` | Label before the resize group; leave empty for no label. |
| `color_contrast` | checkbox | `TRUE` | Show the contrast button group (normal/blue/hivis/soft). |
| `color_contrast_label` | textfield | `Color` | Label before the contrast group; leave empty for no label. |

`build()` passes these to the `block__accessibility_toolbar` theme hook and attaches the
`civic_accessibility_toolbar/civic_accessibility_toolbar.accessibility_toolbar` library.

## Create the block in code (example)

```php
// Place the toolbar into the header region of the default theme.
\Drupal\block\Entity\Block::create([
  'id' => 'accessibility_toolbar',
  'plugin' => 'accessibility_toolbar_block',
  'region' => 'header',
  'theme' => \Drupal::config('system.theme')->get('default'),
  'settings' => [
    'id' => 'accessibility_toolbar_block',
    'label' => 'Accessibility',
    'label_display' => '0',
    'text_resize' => TRUE,
    'color_contrast' => TRUE,
    'text_resize_label' => 'Text size',
    'color_contrast_label' => 'Contrast',
  ],
])->save();
```

For the resize buttons to actually change text size, the active theme's typography must be expressed in
`rem`/`em` units — see [../theming/customize.md](../theming/customize.md).
