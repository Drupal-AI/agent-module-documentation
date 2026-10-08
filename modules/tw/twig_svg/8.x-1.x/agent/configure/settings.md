<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Providing the sprite: settings form, config & theme convention

`icon('name')` renders a `<use xlink:href="#name">` reference (see
[../api/twig-function.md](../api/twig-function.md)). For the browser to draw anything, the matching
`<symbol id="name">` must be inlined into the page. `twig_svg_preprocess_html()` does that inlining
from two sources.

## 1. Theme convention (no config needed)

For the active theme and each of its base themes, `twig_svg_preprocess_html()` looks for
`{theme_path}/images/icons.svg`. If the file exists it reads it and appends its contents to
`page_bottom` as a hidden span:

```php
$theme_icon_file = $theme->getPath() . '/images/icons.svg';
if (file_exists($theme_icon_file)) {
  $theme_icons = file_get_contents($theme_icon_file);
  $variables['page_bottom']['icons'][] = [
    '#type' => 'inline_template',
    '#template' => '<span class="hidden">' . $theme_icons . '</span>',
  ];
}
```

So the recommended workflow (README) is to build a combined sprite into your theme at
`your_theme/images/icons.svg`; it is then present on every HTML page automatically.

## 2. Settings form / `icon_locations` config

Route `twig_svg.settings_form` → `/admin/config/twig_svg/config` (menu link *Configuration › System ›
Twig SVG Settings*), form `Drupal\twig_svg\Form\TwigSvgSettingsForm`, gated by the permission
**`administer twig svg configuration`**. The form has a single required textarea, **Icon locations**,
saved verbatim to `twig_svg.settings:icon_locations` (config object `twig_svg.settings`, schema
`config/schema/twig_svg.schema.yml`, key `icon_locations`, type string).

Enter one path per line, relative to the site root, with no leading slash — e.g.
`modules/example/example.svg`. `twig_svg_preprocess_html()` splits the value on `\r\n` and, for each
line, `file_exists()` + `file_get_contents()` the path and appends its contents to `page_bottom` the
same way as the theme file:

```php
$icon_locations = explode("\r\n", $config->get('icon_locations'));
foreach ($icon_locations as $icon_location) {
  if (file_exists($icon_location)) {
    $config_icon_file = file_get_contents($icon_location);
    $variables['page_bottom']['icons'][] = [
      '#type' => 'inline_template',
      '#template' => '<span class="hidden">' . $config_icon_file . '</span>',
    ];
  }
}
```

`page_bottom` is rendered by core's `html.html.twig`, so the injected sprites appear near the end of
`<body>` on every themed HTML page.

## Permission

`administer twig svg configuration` (`twig_svg.permissions.yml`) — title *Administer twig_svg
configuration*. Grants access to the settings form above. It is the only permission the module
defines; there are no drush commands.
