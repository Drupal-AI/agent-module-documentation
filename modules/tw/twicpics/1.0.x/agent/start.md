<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TwicPics - agent index

Rewrites Drupal image-style derivatives to **TwicPics CDN transformation URLs**. Version **1.0.0**, core `^8.7.7 || ^9 || ^10`.

- Settings form route `twicpics.admin_settings` at `/admin/config/services/twicpics`, permission `administer site configuration`; config `twicpics.admin_settings` (domain, public/private path, max_width/height, api_version).
- Services: `mapping_image_style` (`MappingImageStyle`) maps style effects to TwicPics params, `compute` (`Compute`) builds size fragments.
- Builds URL strings only; the CDN domain is admin-configured. No server-side fetch of request-supplied URLs (no SSRF).