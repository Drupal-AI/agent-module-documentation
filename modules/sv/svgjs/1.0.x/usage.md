<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SVG.js integrates the lightweight SVG.js JavaScript library into Drupal so developers can create, manipulate and animate SVG elements from their own front-end code.
---
On every page (outside the installer, and unless the optional `svgjs_ui` module is present), `svgjs_page_attachments()` attaches the SVG.js library: it uses a local copy at `/libraries/svgjs/svg.min.js` when `svgjs_check_installed()` finds one, otherwise it falls back to the `svgjs.cdn` library from jsDelivr (`@svgdotjs/svg.js@3.2.0`). The module itself renders no markup and defines no routes — it only makes the `SVG()` global available to your theme/module JavaScript. It also exposes small PHP option-list helpers (element types, easing, transform, fill-rule) intended for building SVG-related admin UIs.

Setup is minimal: enable the module and it works out of the box via CDN; for production, download SVG.js into `/libraries/svgjs/` to serve it locally. Because the library is loaded globally, use `Drupal.behaviors` + `once()` to attach your drawing code. The module does not accept or render user-supplied SVG, so it introduces no SVG-sanitisation surface of its own.
---
- Load the SVG.js library on all site pages.
- Serve SVG.js from a local `/libraries/svgjs/` copy for production.
- Fall back to the jsDelivr CDN when no local library exists.
- Create SVG shapes (rect, circle, path, etc.) from JS.
- Animate SVG elements with easing and chaining.
- Attach interactive SVG behaviors via `Drupal.behaviors`.
- Manipulate an existing inline `<svg>` by id.
- Build data visualisations in a custom module.
- Add hover/click handlers to SVG shapes.
- Apply transforms (translate/rotate/scale/skew/matrix).
- Use gradients, patterns, masks and clips from SVG.js.
- Programmatically attach the library from `hook_page_attachments()`.
- Reuse the PHP option helpers when building an SVG admin form.
- Defer to a companion `svgjs_ui` module when installed.
- Pin the SVG.js version by managing the local library file.
- Draw responsive SVG that scales to its container.
- Prototype animations quickly with CDN loading.
- Integrate SVG micro-interactions into a theme.
- Avoid jQuery for SVG DOM work.
- Keep SVG scripting dependency-free and lightweight.
