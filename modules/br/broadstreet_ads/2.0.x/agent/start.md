<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Broadstreet Ads (broadstreet_ads) — agent index

**Turns configured Broadstreet ad zones into placeable blocks that render the platform's `<broadstreet-zone>` web component.**

- **Version:** 2.0.x (dev checkout; branch 2.0.x) · **Core:** ^8 || ^9 || ^10 || ^11 · **Depends:** core `block` · **Configure:** `/admin/config/services/broadstreet-ads`
- **Route:** `broadstreet_ads.settings` (admin route, perm: *administer broadstreet ads*).
- **Permission:** *administer broadstreet ads*.
- **Config:** `broadstreet_ads.settings` (`zones` = newline `zoneid|Label`).
- **Blocks:** `Plugin/Block/AdBlock` derived per zone by `Plugin/Derivative/AdBlock`; outputs `<broadstreet-zone zone-id=INT>` (allowed tag only, id cast to int). Loader library attached on non-admin pages when zones exist.
- **Security:** settings route permission-gated; no anonymous or mutating server endpoints; ad delivery is client-side via Broadstreet's script (no server-side outbound HTTP, no disabled TLS).
