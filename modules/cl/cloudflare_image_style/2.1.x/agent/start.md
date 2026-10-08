<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloudflare Image Style (cloudflare_image_style) — agent index

**Serves styled images from Cloudflare's `/cdn-cgi/image/` CDN in production; falls back to Drupal image styles locally.**

- **Version:** 2.1.x (2.1.0), core `^9 || ^10 || ^11`, package CDN, depends on `drupal:image`
- **Route:** `cloudflare_image_style.deliver` → `/cdn-cgi/image/{cf_effect}` (`_access: 'TRUE'`, `_disable_route_normalizer`)
- **Controller:** `CloudflareImageStyleDownloadController::deliverFallback` (extends core `ImageStyleDownloadController`)
- **Path processor:** `CloudflarePathProcessorImageStyles` (`path_processor_inbound`, priority 300) — moves file path into `file` query param
- **Config:** per-image-style `serve_from_cf` + `cf_effect` (added to `image.style.*` via form alter); `preprocess_image_style` rewrites the `#uri`
- **Security:** the `_access: 'TRUE'` fallback mirrors core's open image-derivative route; the controller calls `deliver($request, 'public', $style)` with the scheme **hardcoded to `public`**, so the source path is confined to `public://` (no arbitrary path / LFI), and core's derivative-token validation still applies. No API keys.

See [configure/image-style.md](configure/image-style.md)
