<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Share (views_share) — agent index

**Share/embed/oEmbed/preview endpoints + a "Share" Views area handler for embedding any View display externally.**

- **Version:** 2.0.x (2.0.0) · **Core:** ^10 || ^11 · **Depends:** views
- **Routes (all `_permission: 'access content'`):** `/view/{view_id}/{display_id}/share` (modal), `/embed`, `/oembed`, `/preview`.
- **Controller:** `ViewsShareController`; helper `ViewsShareHelper` (embed URL/HTML); area plugin `ShareArea`.
- **Permissions:** none of its own.
