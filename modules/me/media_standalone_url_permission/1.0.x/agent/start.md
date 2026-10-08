<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media standalone URL permission (media_standalone_url_permission) — agent index

**Requires the `access standalone media url` permission to view the standalone `/media/{id}` canonical page.**

- **Version:** 1.0.x (1.0.0)
- **Core:** ^10 || ^11
- **Depends:** media
- **Permission:** `access standalone media url`.
- **Mechanism:** `EventSubscriber\RouteSubscriber` adds `_permission: 'access standalone media url'` to route `entity.media.canonical`.
- **Security:** tightens (never loosens) access — it adds a permission requirement to the media canonical route, layered on top of normal media entity access; no routes, forms or config of its own; no over-grant.
