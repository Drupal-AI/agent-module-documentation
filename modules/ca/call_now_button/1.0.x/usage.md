<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Call Now Button places a floating click-to-call (`tel:`) button at the bottom of the screen, styled to appear only on narrow/mobile viewports.

---

Call Now Button is a tiny, dependency-free utility module that renders a single fixed-position "call now" button linking to a `tel:` URL built from an admin-configured phone number. A settings form at `/admin/config/user-interface/call-now-button` controls whether the button is enabled, the phone number, an optional label text, and a corner/position preset. The button is attached site-wide via `hook_page_attachments()` (skipping admin routes), rendered from a Twig template into `drupalSettings`, and injected into the page `<body>` by a small jQuery behavior. CSS hides the wrapper by default and only reveals it under a `max-width: 767px` media query, so it is a mobile-first call-to-action. There are no entities, no plugins, no services, and no external integrations — just one config object, one permission, one form, one template, and a CSS/JS library.

---

- Add a floating "call us" button to a mobile site so visitors can phone the business with one tap.
- Expose a business phone number as a `tel:` link without editing theme templates.
- Give a brochure/landing site a persistent mobile call-to-action across all front-end pages.
- Configure the displayed phone number from the admin UI (`/admin/config/user-interface/call-now-button`).
- Set an optional short label (e.g. "Call us") shown next to the phone icon.
- Choose the button position: right corner, left corner, center bottom, or full bottom.
- Toggle the whole button on or off site-wide with a single "Enable" checkbox.
- Restrict who can change the button settings via the `administer call now button` permission.
- Keep the button off administrative pages automatically (admin routes are excluded).
- Provide a one-touch dialing shortcut for restaurants, clinics, salons, or trades sites.
- Reduce friction versus making mobile users find and copy a number from a contact page.
- Ship a mobile CTA on a site that has no core "click to call" feature out of the box.
- Style the button with the module's bundled CSS (fixed position, z-index, phone icon).
- Use it on any Drupal 8, 9, 10, or 11 site — it requires no modules outside core.
- Add a call button to a Views- or block-driven site without touching those layouts.
- Provide accessibility of a large tap target for phone contact on small screens.
- Localize the button label via the config value.
- Deploy the button configuration between environments as a single config object export.
- Hide the button on desktop automatically (CSS media query) while keeping it on phones.
- Offer a lightweight alternative to heavier "contact widget" or chat-bubble modules.
