<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Slideshow j360 (field_slide_show_j360) — agent index

**An image field formatter that renders a multi-image field as a 360-degree rotating slider via a jQuery library.**

- **Version:** 8.x-3.x (8.x-3.1)
- **Core:** ^8 || ^9 || ^10 || ^11 (no module dependencies)
- **Formatter:** `SlideShowJ360` — "Slideshow j360" (ThreesixtyFormatter extends core ImageFormatter); settings: width, height, navigation
- **Theme/template:** `slideShow360` → slideShow360.html.twig
- **Libraries:** `drupal_threesixty_slider` (external, placed at `/libraries/drupal_threesixty_slider/`) + `drupal.threeSixty` (js/trigger.js, css/threesixty.css)
- **Install:** hook_requirements checks the external library is present

**Security:** No routes, permissions, or mutating endpoints — a display formatter. Images come from `getEntitiesToView()` (file access applied); URLs render via Twig auto-escaping and width/height are 4-digit-limited, so no raw/unescaped output.

See [configure/field_slide_show_j360.md](configure/field_slide_show_j360.md)