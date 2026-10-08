<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Vivus integrates the dependency-free Vivus.js library so SVGs can be animated to look as if they are being drawn, and ships an optional Vivus UI submodule for configuring named animations from the admin interface.
---
The base `vivus` module registers the Vivus.js library (v0.4.6) and, via `hook_page_attachments`, automatically attaches it site-wide when the Vivus UI submodule is not enabled — using the locally installed copy under `/libraries/vivus/dist/vivus.min.js` if present, otherwise falling back to a jsDelivr CDN copy. It also exposes helper option lists (animation type, start trigger, timing function, animation switch) used when building animations. There is no configuration or routing in the base module itself.

The `vivus_ui` submodule adds a management UI under `/admin/structure/vivus` (add/edit/delete/duplicate animations) and a settings form at `/admin/config/user-interface/vivus`, all gated by the single `administer vivus` permission and marked as admin routes. `VivusManager` handles storage of the configured animations. Because every UI route requires `administer vivus`, the animation management surface is restricted to trusted administrators; the base module only attaches a front-end JS library and reads SVGs the site already renders.

Setup: install the Vivus.js library to `/libraries/vivus` (or rely on the CDN fallback), enable `vivus`, and optionally enable `vivus_ui` to define reusable animations through the admin UI.
---
- Animate an inline SVG so it appears to be drawn.
- Attach Vivus.js automatically across the site.
- Fall back to a CDN copy when the local library is missing.
- Use a locally installed Vivus.js library for offline sites.
- Choose an animation type (delayed, sync, oneByOne, scenario).
- Set the animation start trigger (in viewport, manual, autostart).
- Pick a timing function (linear, ease, ease-out-bounce, …).
- Apply an animation switch effect (erase, fade out).
- Manage named animations via the Vivus UI submodule.
- Add a new animation at `/admin/structure/vivus/add`.
- Edit an existing animation configuration.
- Duplicate an animation as a starting point.
- Delete an unused animation.
- Configure global Vivus settings.
- Restrict animation management to `administer vivus`.
- Animate a dynamically loaded SVG object element.
- Draw an SVG referenced by file URL via Vivus options.
- Present help/usage guidance on the module help page.