<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ReadRemaining — agent index

**Scroll-driven remaining-reading-time gauge for nodes.** Version **2.3.1** (`2.3.x`). Core `^11 || ^12`.

Loads the aerolab/readremaining.js library on node pages of selected content types (via
`hook_page_attachments`) and passes tuning options through `drupalSettings`. Requires the
JS library at `/libraries/readremaining` (Composer dep `aerolab/readremaining`).

- **Configure the gauge** — content types, look/feel, JS behavior settings: [configure/settings.md](configure/settings.md)
- **Permissions** — who can reach the settings form: [permissions/permissions.md](permissions/permissions.md)
