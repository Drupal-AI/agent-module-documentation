<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Alerts - Olivero is the Alerts Kit submodule that styles alert banners for the Olivero theme and adds click-to-dismiss JavaScript.

---

Enabling `alerts_olivero` places the `alerts` Views block into Olivero's `header` region (`config/install/block.block.views_block__alerts_block_1.yml`) and, via `alerts_olivero_views_pre_render()`, attaches its `olivero_display` library to the `alerts` view. The library loads `css/olivero-display.css` (full-width header-banner layout tuned for Olivero and the Gin toolbar, plus dismiss-button and add-button styling) and `js/alerts-dismiss.js`. The JavaScript adds a `messages__close` dismiss button to each `div.alert-banner`; clicking it hides the banner and stores its DOM id (`alert-{uuid}`) in the browser's `localStorage` under the key `dismissed`, so dismissed banners stay hidden across pages and later visits. Dismissal is purely client-side — no server route or state change is involved. The submodule depends on `alerts` and requires no configuration.

---
- Enable on an Olivero site to get styled, full-width alert banners in the header.
- Give visitors a dismiss (×) button on each banner.
- Persist dismissals in `localStorage` so a hidden banner stays hidden on later pages/visits.
- Auto-place the alerts Views block in Olivero's header region.
- Keep every alert visible when viewing a single alert node (dismiss pruning is skipped there).
- Use as a reference for the CSS/JS a custom theme needs to reproduce the banner behavior.
- Style the banner block to align with the Gin admin toolbar offset.
- Restyle the dismiss button via the `.messages__close` selectors.
- Disable the submodule to drop the styling/JS while keeping the alert content and view.
