<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloudimage by Scaleflex (cloudimage) — agent index

**Rewrites image URLs through the Cloudimage CDN for resize/compress/optimize.**

- **Version:** 1.0.x (project `cloudimage_by_scaleflex`) · **Core:** ^8 || ^9 || ^10
- **Config:** `cloudimage.admin_settings` → `/admin/config/cloudimage-by-scaleflex` (`administer site configuration`); stores token/CNAME and rendering options.

**Security:** single admin config route, permission-gated. The `custom_function`/`custom_library` settings inject admin-supplied JS/CDN parameters into the front end — trusted-admin only. No anonymous or mutating endpoints.
