# Responsive image class — manual setup guide

**Responsive image class** (`responsive_image_class`) is a small, focused field
formatter that extends Drupal core's built‑in **Responsive Image** formatter
with three practical extras you'd otherwise need a Twig override to achieve:

- **Custom CSS classes** — add one or more space‑separated classes (for example
  `img-fluid rounded`) straight onto the rendered `<img>` element, which is handy
  for utility‑class frameworks and component libraries that style by class name.
- **Blank alt for decorative images** — output an empty `alt` attribute so purely
  decorative images pass accessibility checks cleanly.
- **Focal‑point data** — emit a `data-focal-position` attribute (such as
  `top left`) that front‑end code can read to position or crop the image. When
  the optional [Focal Point](https://www.drupal.org/project/focal_point) module
  is installed, the position is derived from the image's focal‑point crop;
  without a crop it defaults to `center center`.

It keeps all of core Responsive Image's art‑direction behavior — you still pick a
responsive image style — and simply layers these options on top. Focal Point is
an *optional* companion: the module degrades gracefully and works fine without
it. There is no global settings page; everything is configured per field on
*Manage display*.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You configure it on an image
field's display, described in "How to use it" below.

## How to use it

1. Go to the **Manage display** of a bundle that has an image field (for example
   **Structure → Content types → *(your type)* → Manage display**).
2. For the image field, choose the **Responsive image class** formatter.
3. Click the gear/settings icon and set:
   - the **responsive image style** to use,
   - one or more **image classes** (space‑separated),
   - the **Remove alt tag** toggle for decorative images, and
   - the **Focus point data** toggle to emit `data-focal-position`.
4. Save. The rendered images now carry your classes (and, if enabled, the empty
   alt or focal‑point data attribute).

> **Tip:** Install [Focal Point](https://www.drupal.org/project/focal_point) and
> set focal points on your images if you want the `data-focal-position` values to
> reflect real crop positions rather than the `center center` default.
