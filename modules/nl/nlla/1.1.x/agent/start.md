<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Native Lazy Load Animation (nlla) — agent index

**Attaches CSS/JS that animates (fades/reveals) images and iframes using native `loading="lazy"` once they finish loading.**

- **On-disk dir:** `nlla` — **real machine name:** `native_lazy_load_animation` (info.yml prefix); project `nlla`.
- **Version:** 1.1.x
- **Core:** ^9 || ^10
- **Depends:** none

**Surface:** a single asset library only — no routes, forms, permissions, services, or blocks. Enabling attaches CSS/JS sitewide.

**Security:** no server-side surface, no user input; nothing beyond normal static-asset delivery. Customise by overriding the module's CSS in a theme.
