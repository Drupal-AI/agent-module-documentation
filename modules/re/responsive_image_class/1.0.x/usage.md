<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Responsive image class

Responsive image class provides a field formatter (`responsive_image_class`) that extends the
core **Responsive Image** formatter with three extra capabilities:

- **Image classes** — add one or more space-separated CSS classes to the `<img>` element.
- **Remove alt tag** — output an empty `alt` attribute for decorative images.
- **Focus point data** — emit a `data-focal-position` attribute (e.g. `top left`) computed from
  a Focal Point crop when the optional [Focal Point](https://www.drupal.org/project/focal_point)
  module is installed, so front-end code can position the image accordingly.

---

## Installation & configuration

- Requires core `responsive_image`. Focal Point integration is optional (services use
  `@?focal_point.manager`, so it degrades gracefully when absent).
- Install with `drush en responsive_image_class`.
- On an image field's *Manage display*, choose the **Responsive image class** formatter and
  configure classes, the remove-alt toggle, and the focal-point toggle.
- The focal position is derived from the image's Focal Point crop; without a crop it defaults to
  `center center`.

---

## Use cases

- Add utility/framework CSS classes (e.g. `img-fluid`, `rounded`) to responsive images.
- Apply theme-specific styling hooks to images per view mode.
- Mark decorative images accessible by emitting an empty alt attribute.
- Provide focal-point data for CSS `object-position` cropping.
- Integrate Focal Point crops into responsive image output.
- Keep art-direction responsive behaviour while adding classes.
- Style hero images differently from inline images via classes.
- Support component libraries that key off class names.
- Avoid template overrides just to add an image class.
- Gracefully work with or without the Focal Point module.
- Add lazy-load or animation classes to responsive images.
- Ensure decorative imagery passes accessibility checks.
- Position images by focal point in card/grid layouts.
- Reuse one formatter across multiple image fields.
- Combine responsive styles with per-display class sets.
- Provide front-end devs a data hook for focal positioning.
