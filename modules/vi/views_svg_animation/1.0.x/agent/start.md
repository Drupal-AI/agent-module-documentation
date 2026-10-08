<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views SVG Animation (views_svg_animation) — agent index

**A Views style extending the core Table style that renders interactive, animatable SVG files attached to rows.**

- **Version:** 1.0.x (1.0.1)
- **Core:** ^10 || ^11 · **PHP:** >=8.1
- **Dependencies:** drupal:media, drupal:views
- **Style plugin:** `@ViewsStyle` id `svg_animation` (`SvgAnimation`, extends core `Table`)
- **Theme hook:** `views_view_svg_animation` (preprocess reuses `template_preprocess_views_view_table`)
- **Library:** `views_svg_animation/generic` (JS reads `drupalSettings.svg_animation`)

**Security:** No routes, permissions, or mutating endpoints — a Views display/theming plugin configured by site builders. SVG assets come from managed Media/File entities via the file URL generator, not request input. No security findings.
