<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
iFrame Resizer wires the third-party [iframe-resizer](https://github.com/davidjbradshaw/iframe-resizer) JavaScript library (v4.x) into Drupal so that iframes keep themselves sized to their content, with support for cross-domain frames, in-page links, and nesting. It is driven entirely from one admin settings form; there is no field or block.

---

The module attaches the iframe-resizer library and initialization JS via `hook_page_attachments()` based on config in `iframe_resizer.settings`. Two independent roles are toggled by checkboxes: **host** (this site embeds resizable iframes → loads `iframeResizer.min.js` + `js/iframe_resizer_init.js`, passing options to `drupalSettings.iframeResizer.advanced`) and **hosted** (this site is shown inside someone else's resizable iframe → loads `iframeResizer.contentWindow.min.js` + `js/iframe_resizer_hosted.js`, using `drupalSettings.iframeResizer.advancedHosted`). The host side can target all iframes or a set of jQuery selectors, and (when "override defaults" is on) exposes the full library option set — `heightCalculationMethod`, `widthCalculationMethod`, `autoResize`, `bodyBackground/Margin/Padding`, `checkOrigin`, `inPageLinks`, `interval`, min/max height/width, `resizeFrom`, `scrolling`, `sizeHeight/sizeWidth`, `tolerance`. The hosted side sets `targetOrigin` and calculation-method overrides. The library itself is **not bundled**; you must install `bower-asset/iframe-resizer:^4` into `libraries/iframe-resizer/` (v5.x is commercial and unsupported), and `hook_requirements()` shows an error on the status report until it is found. Config UI is gated by the restricted `administer iframe resizer` permission at `/admin/config/user-interface/iframe_resizer`. Two alter hooks (`hook_iframe_resizer_host_settings_alter`, `hook_iframe_resizer_hosted_settings_alter`) let other modules override the emitted settings.

---

- Make embedded iframes automatically grow/shrink to fit their content height.
- Remove inner scrollbars from an embedded iframe by sizing it to its content.
- Embed a cross-domain iframe and keep it correctly sized.
- Target only specific iframes for resizing using jQuery selectors.
- Resize all iframes on the site with a single global setting.
- Let your own site's pages be resized when hosted inside another site's iframe (hosted mode).
- Restrict which parent domain may embed your site via the `targetOrigin` setting.
- Choose the height calculation method (bodyOffset, lowestElement, taggedElement, etc.) for tricky layouts.
- Choose the width calculation method for horizontally sized frames.
- Set minimum/maximum height and width bounds on resized iframes.
- Enable in-page (anchor) links to work across the iframe boundary.
- Override the iframe body background, margin, or padding CSS.
- Turn on library console logging to debug the parent/child messaging.
- Adjust the resize check interval for browsers without MutationObserver.
- Set a pixel tolerance before a resize is triggered to reduce churn.
- Enable scrollbars inside the iframe when needed.
- Resize width as well as height for a fully fluid frame.
- Programmatically override host settings from a custom module via `hook_iframe_resizer_host_settings_alter()`.
- Programmatically override hosted settings via `hook_iframe_resizer_hosted_settings_alter()`.
- Self-host the iframe-resizer 4.x library (avoiding the commercial 5.x) via Composer bower-asset.
- Keep a dashboard/widget embed responsive across devices without fixed heights.
