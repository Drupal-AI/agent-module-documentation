<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Responsive Gallery (responsive_gallery) — agent index

A single **image-field formatter** that renders a multi-value image field as a **Masonry grid**
of thumbnails with a **Fancybox lightbox**. Package `Responsive Gallery`. Only dependency: core
**`field`**. Core requirement `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.2.2.
No routes, no permissions, no services, no config objects/schema, no Drush.

- **The formatter, its settings, enabling it, template + library, and known caveats** →
  [fields/formatter.md](fields/formatter.md)

## What it actually is

- One plugin: `ResponsiveGalleryFormatter` in
  `src/Plugin/Field/FieldFormatter/ResponsiveGalleryFormatter.php`, **extending core's
  `ImageFormatter`**. `@FieldFormatter id = "responsive_image"`, label *"Responsive Gallery"*,
  `field_types = {"image"}` — targets **core image fields only**.
- `responsive_gallery.module` implements `hook_help()` and `hook_theme()` (registers the
  `responsive_gallery` theme hook → `templates/responsive-gallery.html.twig`).
- `responsive_gallery.libraries.yml` defines one library `responsive_gallery/responsive_gallery`
  bundling **Fancybox** (`js/fancybox.js` + `css/fancybox.css`), **Masonry**
  (`js/masonry.pkgd.min.js`), **imagesLoaded** (`js/imagesloaded.pkgd.min.js`), the grid CSS
  (`css/responsive-gallery.css`) and the init (`js/custom.js`), with deps `core/jquery`,
  `core/once`, `core/drupal`. All assets are vendored — no external CDN.

## Mechanism (from source)

- `viewElements()` builds a `#theme => 'responsive_gallery'` render array. Each image from
  `getEntitiesToView()` (core file/display access honored) becomes an `#theme => 'image_formatter'`
  child wrapped by `#prefix`/`#suffix` in `<div data-fancybox="gallery" data-src="{url}">…</div>`,
  where `{url}` is the file URL from `fileUrlGenerator->generateString()` (path is
  `UrlHelper::encodePath`-encoded by core). Alt/title render through the core `image_formatter`
  theme.
- Per-breakpoint column counts become CSS classes
  `rg-grid-item-elg-N rg-grid-item-lg-N rg-grid-item-md-N rg-grid-item-sm-N` on each item; the
  optional wrapper class is added on the `rg-grid` container.
- `js/custom.js` (`Drupal.behaviors.responsive_gallery`) runs `imagesLoaded` then `.masonry()`
  on `.rg-grid`. Fancybox picks up the `data-fancybox="gallery"` attributes for the lightbox.

## Settings (formatter, `defaultSettings()`)

`image_style` (''), `wrapper_class` (''), `extra_large_devices` ('5'), `large_devices` ('4'),
`medium_devices` ('3'), `small_devices` ('1'). Selectable per view-display on *Manage display*.
Details, the settings form/summary, config example and caveats in
[fields/formatter.md](fields/formatter.md).

## Caveats worth knowing

- **Plugin-id clash:** the id is `responsive_image` — the **same id core's `responsive_image`
  module uses** for its own formatter. Enabling both can collide (last definition wins).
- `isBackgroundImageDisplay()` compares `getPluginId() == 'responsive_gallery'`, but the id is
  actually `responsive_image`, so it always returns FALSE (dead branch).
- `viewElements()` reads a `thumbnail_image_style` setting that `defaultSettings()` never defines,
  so that branch is effectively dead too.
