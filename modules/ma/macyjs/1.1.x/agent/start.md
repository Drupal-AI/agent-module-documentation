<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Macy.js (macyjs) — agent index

**A Views style plugin that lays rows out as a responsive Masonry-style multi-column grid using Macy.js.**

- **Version:** 1.1.x  •  core: `^9.2 || ^10 || ^11`  •  depends on `drupal:views`  •  package: Views
- **Plugin:** `@ViewsStyle id=macyjs` (`MacyJs`, `usesRowPlugin`, theme `views_view_macyjs` based on `views_view_unformatted`).
- **Options:** `macyjs_columns`, `margin_x`/`margin_y`, `trueOrder`, `waitForImages`, `useOwnImageLoader`, `mobileFirst`, `breakAt` (regex-parsed responsive breakpoints).
- **Render:** `macyjs_preprocess_views_view_macyjs` assigns a random container id (`Crypt::randomBytesBase64`) and passes options via `drupalSettings.macyjs[<id>]`.
- **Library:** `macyjs/macyjs` is a **remote CDN asset** (`https://cdn.jsdelivr.net/npm/macy@2`, v2.5.1 MIT) + local `js/macyjs.js` bridge.

**Security:** no routes, permissions or config entities — purely a Views display plugin gated by Views admin access. Numeric options are cast to `(int)` before reaching JS; no server-side fetch or mutating endpoint. Note the library loads from jsDelivr's CDN — self-host it for strict-CSP/offline sites.
