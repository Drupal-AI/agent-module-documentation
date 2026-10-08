<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Imageshop (imageshop) — agent index
**Integrates the Imageshop DAM: editors pick images from an embedded Imageshop iframe browser that flows selections back into Drupal media/upload forms.**

**Version:** 1.1.x  ·  **Core:** ^9.3 || ^10 || ^11  ·  **Depends:** drupal:image
- **Routes:** `imageshop.iframe` `/imageshop/iframe` (`_permission: access imageshop`); `imageshop.settings` `/admin/config/media/imageshop` (`_permission: administer imageshop`).
- **Permissions (imageshop.permissions.yml):** `access imageshop`, `administer imageshop configuration`.
- **Services:** `imageshop.token_service` (exchanges token+private_key for a 24h temp token via `webservices.imageshop.no`, cached in state; refreshed by `hook_cron`).
- **Notes:** credentials (`token`, `private_key`) live in config `imageshop.settings`. Iframe host is hard-coded. Permission-name mismatch: settings route wants `administer imageshop` but only `administer imageshop configuration` is defined (route fails closed).

See [configure/imageshop.md](configure/imageshop.md)
