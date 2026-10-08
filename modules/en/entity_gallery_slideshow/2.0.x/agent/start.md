<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entities Gallery To Slideshow (entity_gallery_slideshow) — agent index

An entity-reference **field formatter** that renders referenced entities as a clickable **gallery
grid**, and on click opens a **Swiper (v11) slideshow in an AJAX modal dialog**, synced to the
clicked item. Package `Fields`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 2.0.0.

## What it actually is (from source)

- **One field formatter**: `EntityGalleryFormatter` (id **`entity_gallery_slideshow_view`**, label
  *"Gallery"*), `field_types = { "entity_reference" }`, in
  `src/Plugin/Field/FieldFormatter/EntityGalleryFormatter.php`. Extends core
  `EntityReferenceEntityFormatter`.
- **One controller**: `SlideshowController` (`src/Controller/SlideshowController.php`) serving the
  slideshow modal (AJAX) and a no-JS paginated fallback.
- **No** permissions, `.install`, `.services.yml`, hooks, config forms, config schema, submodules,
  or Drush. **No `dependent_modules`** (info.yml declares no `dependencies`).
- Dependencies are libraries only: **Swiper 11** (jsDelivr CDN), core `once`, core
  `drupal.dialog.ajax`. Config is per view-display, no dedicated settings route (`configure: null`).

## Provides

- Formatter plugin `entity_gallery_slideshow_view` — see [fields/formatter.md](fields/formatter.md).
- Two routes + JS/Swiper library wiring — see [routes/slideshow.md](routes/slideshow.md).
- Libraries (`entity_gallery_slideshow.libraries.yml`): `entity_gallery_slideshow` (CSS),
  `swiper` (CDN JS+CSS), `slideshow` (`js/slideshow.js`, depends on `core/once` + `swiper`).

## Solution docs

- **The Gallery formatter, its settings, and the gallery render path** →
  [fields/formatter.md](fields/formatter.md)
- **Routes, the SlideshowController, the modal/no-JS render paths, Swiper JS** →
  [routes/slideshow.md](routes/slideshow.md)
