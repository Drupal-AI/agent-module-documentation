<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Unified Share Button provides a block that shows a floating share icon; on devices that support it the button triggers the native Web Share API, otherwise it opens a dialog of sharing links.
---
The module registers a single block plugin (`unishare`) and a `unishare_button` theme hook. The block builds a render array using the current request's URI as the shared URL, the resolved page title, and the site name as the description, and attaches the `unishare/button` library (CSS plus `js/unishare-button.js`, depending on `core/drupal` and `core/drupal.dialog`). The share URL is always the current page URL derived server-side from the request — it is not taken from user/query input — and the button is output with a `visually-hidden` class that the JS reveals. Sharing-link markup, icons, and CSS are adapted from sharingbuttons.io (MIT) and include a Mastodon "toot" link.

Operation is simple: place the "Unified Share Button" block in a region (typically site-wide) via Block Layout. There is no configuration form, permission, route, or server-side data write — all sharing happens client-side in the visitor's browser. The block is cached per `url.path` so the correct page URL/title is shared.
---
- Add a floating "share this page" button to a site
- Use the device's native share sheet on mobile
- Fall back to a share-links dialog on desktop browsers
- Share the current page URL, title, and site name
- Place the share button site-wide via Block Layout
- Offer Mastodon sharing via the toot service link
- Provide social sharing without third-party tracking scripts
- Keep sharing fully client-side (no server writes)
- Restrict the block to specific pages with core block visibility
- Theme the button by overriding the `unishare_button` template
- Style the icon/dialog with the bundled sharingbuttons.io CSS
- Add share capability to article/blog pages
- Show a consistent share affordance across a campaign site
- Cache the button per URL so each page shares its own link
- Reveal the button progressively via the attached JS
