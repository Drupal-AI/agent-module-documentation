<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pinterest Hover Button

When enabled, the module loads Pinterest's third-party `pinit.js` widget script so a 'Pin It' button appears over images on hover. A single settings form controls the button appearance and where it is loaded. It also patches responsive-image markup so `pinit.js` can find the correct image URL via `data-pin-media`.

---

# Installing & configuring

- Enable the module and visit `/admin/config/pinterest-hover/config` (permission `administer site configuration`).
- Toggle 'load Pinterest JS', choose button size/shape/colour, and optionally restrict to selected content types.
- Optionally provide CSS selectors (one per line) to exclude images from getting the hover button.
- Config stored in `pinterest_hover.settings`.

---

- `hook_page_attachments()` injects `//assets.pinterest.com/js/pinit.js` into the page head when enabled.
- Button data attributes (`data-pin-height`,`data-pin-shape`,`data-pin-color`) come from config.
- If no content types are selected, the script loads on all pages.
- If content types are selected, the script loads only on matching node pages.
- Exclusion selectors are passed to `drupalSettings` and a helper JS library filters them out.
- `hook_preprocess_responsive_image()` adds `data-pin-media` so responsive images can be pinned.
- Absolute URLs are ensured for `data-pin-media` (prepends base_root).
- A cache tag `pinterest_hover` is added for invalidation.
- The settings form is the only route; it requires `administer site configuration`.
- No permissions are defined by the module.
- The Pinterest script is loaded over protocol-relative `//` (inherits page scheme).
- Help page renders `README.md`, using the markdown module parser if available.
- No user input is processed on the front end beyond admin-configured selectors.
- Useful for image-heavy / recipe / gallery sites wanting social pinning.
- Relies on a third-party CDN script; privacy/GDPR review may be warranted for that external call.
- Uninstall removes the settings and the injected script.
