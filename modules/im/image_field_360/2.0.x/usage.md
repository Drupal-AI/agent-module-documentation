<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image Field 360 adds a "Image field 360" formatter to core image fields that renders each image as an interactive 360 degree panorama the visitor drags to look around, zoom, and open fullscreen. It requires the third-party Photo Sphere Viewer JavaScript library, which you install by hand into `/libraries/photo-sphere-viewer/`.

---

The module ships exactly one thing: a `FieldFormatter` plugin (id `Image_field_360`, field type `image`) that you pick on **Manage Display** for any image field. For each field item it emits a `<div class="photosphere">` carrying a `data-photosphere` JSON blob of the display settings and an `<img class="image-photosphere">`; the bundled `js/photosphere.js` behavior reads the image `src`, parses the settings, and constructs `new PhotoSphereViewer(...)` per element. The viewer itself — drag-to-rotate, zoom, autorotate, fullscreen — is provided entirely by **Photo Sphere Viewer v2.9 by Jeremy Heleine**, which is **not bundled**: `image_field_360.libraries.yml` references `/libraries/photo-sphere-viewer/three.min.js` and `/libraries/photo-sphere-viewer/photo-sphere-viewer.min.js`, and `hook_requirements()` raises a `REQUIREMENT_ERROR` on the status report until both files exist, so the formatter does nothing on a fresh install until you download the library. The images must be genuine **equirectangular** (360x180) panoramas — a 360 camera or a phone's photosphere mode produces them; an ordinary flat photo will render smeared and warped (the README warns of exactly this). Formatter settings (all per view mode, stored via `field.formatter.settings.Image_field_360` config schema): `loading_msg` (default `Loading...`), `width` (`100%`), `height` (`500px`), and `navbar_enable` (off) which, when on, exposes a large group of navigation-bar styling options — `navbar_backgroundColor`, `navbar_buttonsColor`, `navbar_buttonsBackgroundColor`, `navbar_activeButtonsBackgroundColor`, `navbar_buttonsHeight`, `navbar_autorotateThickness`, `navbar_zoomRangeWidth`, `navbar_zoomRangeThickness`, `navbar_zoomRangeDisk`, `navbar_fullscreenRatio`, `navbar_fullscreenThickness`. A multi-value image field yields one independent viewer per delta. Practical constraints: equirectangular panoramas are large (several thousand px wide, multiple MB), it is a canvas-based drag interaction with no keyboard path and no text alternative of its own (add descriptive alt text), and one large WebGL texture is heavy on mid-range phones, so one panorama per page is a sensible rule and a gallery of them is not.

---

- Let visitors drag to look around a room in full 360 degrees.
- Present a real-estate property listing as a standable panorama.
- Show a hotel suite or room from every angle.
- Offer a museum or gallery immersive view.
- Present a wedding or conference venue's interior space.
- Record and display a construction site at a point in time.
- Show a wide landscape or scenic viewpoint panorama.
- Present a classroom, lab, or campus facility.
- Publish a stop on a self-guided virtual tour.
- Show a car, boat, or aircraft interior in 360.
- Present a restaurant's dining room to prospective diners.
- Show a stadium or theatre view from a specific seat.
- Present a heritage or historical site immersively.
- Offer an immersive product-in-context view.
- Show a workshop, studio, or showroom space.
- Give a retail store an interior walkthrough image.
- Style the viewer's navigation bar to match a site theme (colors, sizes).
- Set a fixed viewer height/width per view mode (e.g. tall on full node, short in a teaser).
- Customize the "Loading..." message shown while a large panorama downloads.
- Enable or hide the autorotate / zoom / fullscreen navigation bar per display.
- Attach multiple panoramas to one entity via a multi-value image field (one viewer each).
- Turn an existing image field into a 360 display without changing the content model.
