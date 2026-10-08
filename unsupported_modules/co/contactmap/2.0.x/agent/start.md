<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact Map (contactmap) — agent index

**Draggable floating contact widget (Google map + address + click-to-call phone) attached to front-end pages.**

- **Version:** 2.0.x (dev-2.0.x checkout)
- **Core:** ^8 || ^9 || ^10 || ^11
- **Configure:** `/admin/config/user-interface/contact-map` (`contactmap.form`, `administer site configuration`).
- **Config:** `contactmap.settings` — `mapGooglekey`, `mapPhoneNumber`, `mapAddressContact`, `mapLatitude`, `mapLongitude`, `contactmapThemename`.
- **Behaviour:** `hook_preprocess_page` attaches the `contactmap` library and passes settings via `drupalSettings` when the active theme matches.
- **Security:** Only route is the admin settings form, gated by `administer site configuration`. Google Maps JS key is a client-side key exposed via `drupalSettings` (expected). No public/mutating endpoints.
