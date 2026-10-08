<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pinterest Hover Button — agent orientation

Attaches Pinterest `pinit.js` to add hover 'Pin It' buttons on images.

- Version 8.x-2.x, core `^9||^10`, no deps. Settings at `/admin/config/pinterest-hover/config` (`administer site configuration`).
- `hook_page_attachments` injects `//assets.pinterest.com/js/pinit.js`; per-content-type targeting + CSS-selector exclusions via drupalSettings.
- Only surface is the admin form. Loads a third-party CDN script (privacy note). Nothing exploitable found.