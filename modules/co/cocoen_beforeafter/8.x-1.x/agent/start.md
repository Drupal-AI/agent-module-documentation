<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cocoen Before After Image Formatter (cocoen_beforeafter) — agent index

Two **field formatters** that render the first two values of a field as one draggable before/after
image comparison, using the third-party **Cocoen** JS library. Version **8.x-1.3**, core `^10 || ^11`,
depends on core `image`. No configuration route, no permissions, no services, no Drush.

## Mechanism

- **`cocoen_before_after_image`** — for `image` fields. Loads up to the first two items, builds each
  URL from the file URI (via an image style if one is chosen, otherwise an absolute file URL), and
  passes them to the theme hook.
- **`cocoen_before_after_media`** — extends the image formatter, for `entity_reference` fields whose
  target is **media** (`isApplicable()` checks `target_type == 'media'`). For each of the first two
  referenced media items it reads the media source field's image entity and builds its URL the same way.
- Both return a render array with `#theme => 'cocoen_before_after_image'`, `#images => [url, url]`, and
  attach `cocoen_beforeafter/cocoen_beforeafter`.
- Theme hook `cocoen_before_after_image` (in the `.module`) → template
  `templates/cocoen-before-after-image.html.twig`: a `<div class="cocoen-beforeafter-container cocoen">`
  containing one `<img src="{{ image }}">` per image (Twig auto-escapes the `src`).
- `js/cocoen_beforeafter.js`: a `Drupal.behaviors` that uses `once('cocoen', …)` and calls
  `$(element).cocoen()` on each container.

## Settings

Single per-formatter setting `image_style` (config schema
`field.formatter.settings.cocoen_before_after_image`). Default `''` → original size. Set on the
bundle's **Manage display**, or in `core.entity_view_display.*` config. See
[agent/fields/formatters.md](fields/formatters.md).

## The Cocoen library is NOT bundled

`cocoen_beforeafter.libraries.yml` declares a self-hosted third-party library
`cocoen_beforeafter/jquery-cocoen_beforeafter` (koenoe/cocoen **2.0.4**, MIT) whose assets live at
`/libraries/cocoen/dist/js/cocoen.min.js`, `…/cocoen-jquery.min.js`, and `…/css/cocoen.min.css`.
You must download and extract it to the web root manually (Composer does not pull it). Without it the
two images render stacked but the slider never initialises. Cocoen 3.x is not supported by this branch.

## Gotchas

- The field must hold **at least two** values; only the first two are used, the rest are ignored.
- The image-URL builder assumes each item has a loadable file entity — an image field with fewer than
  two populated deltas simply yields a shorter (or empty) comparison.
- Two images that differ in dimensions/alignment produce a misleading slider — an editorial concern the
  module cannot enforce.
- Drag-only interaction: confirm keyboard/screen-reader reachability and meaningful alt text.

## Solution docs

- [agent/fields/formatters.md](fields/formatters.md) — enable and configure both formatters.
