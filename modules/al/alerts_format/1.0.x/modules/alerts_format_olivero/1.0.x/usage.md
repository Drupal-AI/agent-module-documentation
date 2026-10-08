<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Submodule of Alerts Format that gives the Alerts recipe's banners full-width Olivero header styling plus a client-side dismiss button.

---

Alerts Format - Olivero (`alerts_format_olivero`) is the Olivero-specific presentation layer for the Alerts recipe. Its single `hook_views_pre_render()` implementation fires for the View whose id is `alerts` and attaches the `alerts_format_olivero/olivero_display` asset library. That library loads `css/olivero-display.css`, which stretches the alert Views block to the full width of the Olivero site header (with Gin vertical-toolbar offsets handled), and `js/alerts-dismiss.js`, a `Drupal.behaviors.alertsDismiss` behavior that appends a "Dismiss Alert" close button to each `.alert-banner`, hides banners the visitor has closed, and stores dismissed banner ids in the browser's `localStorage` so they stay hidden on later visits. The submodule depends on the parent `alerts_format` module and ships a block config (`block.block.views_block__alerts_block_1`) placing the alerts Views block in Olivero's header region. It adds no routes, permissions, services, or configuration UI.

---

- Render Alerts recipe banners full-width across the Olivero site header.
- Place the alerts Views block in the Olivero header region via shipped block config.
- Add a client-side dismiss ("close") button to each alert banner.
- Hide dismissed banners immediately without a page reload or server request.
- Remember which banners a visitor dismissed using browser `localStorage`.
- Keep dismissed-state per browser/device (nothing is stored server-side).
- Prune stale dismissed ids that no longer correspond to a shown banner.
- Avoid pruning while the visitor is viewing a single alert node (`page-node-type-alert`).
- Localize the dismiss button label through `Drupal.t('Dismiss Alert')`.
- Reuse Olivero's `messages__close` styling for a native-looking close control.
- Handle Gin admin theme's vertical-toolbar width offset in the banner CSS.
- Attach styling/JS only on the `alerts` View, not site-wide.
- Depend on and extend the parent `alerts_format` severity-color styling.
- Provide accessible focus outlines on banner links and the close button.
- Work across Drupal core 10 and 11 with the Olivero theme.
