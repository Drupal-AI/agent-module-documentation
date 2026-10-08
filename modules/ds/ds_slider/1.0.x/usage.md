<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
## What it does

- Adds a responsive slider/carousel that can be placed as a block or viewed at a dedicated page.
- Ships a bundled slider JS library and templates for rendering slides.
- Provides an admin settings form to configure the slider.

---

## Install & configure

- Enable the module.
- Configure at `ds_slider.settings` (linked from the admin menu).
- Place the `DsSliderBlock` block, or visit the `/ds-slider` page (route `ds_slider.ds_slider_url`, permission `access content`).

---

## Usage & behaviour

- Route `/ds-slider` is served by `DsSliderController::content()` and is gated by the core `access content` permission (i.e. readable by anonymous visitors) — this is a public display page, not a mutation endpoint, so the open gate is appropriate.
- The `DsSliderBlock` block plugin lets you drop the slider into any region.
- Slides are rendered through Twig templates under `templates/` with normal autoescaping.
- The slider behaviour is driven by the bundled library in `libraries/`/`js/` and styled from `css/`.
- A `permissions.yml` is present; review any custom permission it defines for managing slides.
- Configuration is stored via config factory and exportable through CMI.
- Use it for homepage hero carousels, promotional banners, or featured-content rotators.
- Because the page route is anonymous-readable, do not use it to display access-restricted content.
- The bundled front-end slider library should be audited/updated for known JS vulnerabilities like any vendored asset.
- Responsive behaviour adapts slide sizing to viewport width.
- No external services or server-side URL fetching are involved.
- Multiple block placements can show the slider in different regions.
- Disabling the module removes the block, page route and library.
- Combine with block visibility conditions to scope the slider to specific pages.
- Package `DotSquares` indicates a vendor-authored utility module.
- Test keyboard and screen-reader accessibility of the carousel before production use.
