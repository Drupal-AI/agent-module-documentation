<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ElevateZoom Plus adds hover/click image zoom (magnifier window, lens, or inner zoom) to Blazy-powered image galleries and carousels — Slick, Splide, Blazy Grid, GridStack — driven by reusable "optionset" config entities. It plugs into Blazy as a media switcher / lightbox option; the actual settings UI ships in the `elevatezoomplus_ui` submodule.

---

The module depends on Blazy 3.x and the third-party `elevatezoom-plus` JS library (installed to
`/libraries/elevatezoom-plus` or `/libraries/ez-plus`). It defines a `ConfigEntityType`
`elevatezoomplus` (config prefix `elevatezoomplus.optionset`, e.g. `default`, `inner`, `responsive`)
whose `options.settings` mirror the ez-plus library options (`zoomType` window/lens/inner,
`zoomWindowWidth/Height`, `lensSize`, `scrollZoom`, `easing`, `borderSize`, tint/fade flags, etc.).
Rather than its own formatters, ElevateZoom Plus integrates entirely through Blazy hooks in
`elevatezoomplus.module` — it registers itself as a Blazy lightbox (`hook_blazy_lightboxes_alter`),
adds a settings element to Blazy/formatter forms (`hook_blazy_form_element_alter`,
`hook_form_blazy_settings_form_alter`), and rewrites the render build via
`hook_blazy_build_alter`, `hook_slick/splide/gridstack_build_alter`, and preprocess overrides. The
`ElevateZoomPlusManager` service (`elevatezoomplus.manager`, wraps `blazy.manager`) computes the JS
options and the theme layer (`elevatezoomplus.theme.inc`) encodes them into a `data-elevatezoomplus`
attribute as JSON that the module's JS reads to instantiate ez-plus. Two usage patterns: Slick/Splide
**with** asNavFor pairs a main image with a thumbnail nav and any lightbox; **without** asNavFor (or
Blazy Grid/GridStack) uses the "Image to ElevateZoomPlus" media switcher. The `elevatezoomplus_ui`
submodule provides the optionset list/add/edit/delete UI at `/admin/config/media/elevatezoomplus`
(permission `administer elevatezoomplus`).

---

- Add a magnifier zoom window to product images in a Slick or Splide carousel.
- Zoom e-commerce product galleries on hover for a detailed close-up.
- Use an inner-zoom effect that magnifies within the image bounds.
- Use a lens-style zoom that follows the cursor.
- Pair a main preview image with a thumbnail nav (asNavFor) plus zoom.
- Add zoom to a Blazy Grid or GridStack gallery via the Image-to-ElevateZoomPlus media switcher.
- Create a reusable "default" optionset and apply it across multiple displays.
- Create a "responsive" optionset tuned for smaller screens.
- Configure zoom window size, position, and offset per optionset.
- Enable scroll-wheel zoom for finer magnification control.
- Add fade-in/out and easing to the zoom transition.
- Show a tinted overlay on the source image while zooming.
- Combine zoom with a lightbox for full-screen viewing.
- Fall back to a full-screen video (blazybox) for non-image media items.
- Serve the ez-plus assets from a self-hosted `/libraries` copy.
- Apply zoom to any Blazy-based field formatter without writing a custom formatter.
- Configure the lens size, shape, border, colour, and opacity.
- Manage all zoom optionsets from one admin list (UI submodule).
- Duplicate an existing optionset as a starting point for a new one.
- Provide consistent zoom UX across galleries site-wide by reusing one optionset.
