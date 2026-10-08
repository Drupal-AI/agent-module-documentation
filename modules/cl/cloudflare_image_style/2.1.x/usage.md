<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cloudflare Image Style serves styled images through Cloudflare's `/cdn-cgi/image/` resizing service in production and transparently falls back to Drupal's own image styles elsewhere.

---

On the image-style edit form the module adds two settings (via `hook_form_..._alter`): **Serve from Cloudflare** and a **Cloudflare Effect** string, stored on the `image.style.*` config. When a style is flagged to serve from Cloudflare, `template_preprocess_image_style` rewrites the rendered image `#uri` to `/cdn-cgi/image/<cf_effect>/<file-target>`, so the CDN produces the derivative. For environments not behind Cloudflare (local/dev), the same `/cdn-cgi/image/{cf_effect}` path is handled by Drupal: an inbound path processor moves the file path into a `file` query parameter, and a fallback controller renders the Drupal image derivative instead.

The fallback route `cloudflare_image_style.deliver` is declared `_access: 'TRUE'`, which is the normal posture for image-style delivery (core's own image derivative route is also open, protected by a derivative token). Its controller extends core's `ImageStyleDownloadController` and calls `deliver($request, 'public', $style)` — the scheme is **hardcoded to `public`**, so the requested file is always resolved as `public://<target>`; it cannot address arbitrary filesystem paths or other stream wrappers, and core's `deliver()` applies its usual derivative-token/validation logic. Confirmed: the source image path is confined to the public files scheme, so there is no arbitrary-path/LFI exposure via this endpoint. It requires only Drupal core plus the image module and needs no API keys.

---
- Enable the module (requires only core + image module)
- Edit an image style and set "Serve from Cloudflare" to Yes
- Enter the Cloudflare Effect string for that style
- Serve production image derivatives from Cloudflare's CDN
- Fall back to Drupal image styles on local/dev environments
- Offload image resizing cost/CPU to Cloudflare
- Control CDN usage/cost per image style
- Keep the same image markup working with and without the CDN
- Use `/cdn-cgi/image/<effect>/<file>` URLs generated automatically
- Support both public and private image style derivatives locally
- Preview styled images in non-production without Cloudflare
- Configure effects per style rather than globally
- Route `/cdn-cgi/image/{effect}` requests through the fallback controller
- Rely on the priority-300 inbound path processor for URL rewriting
- Confine fallback delivery to the public files scheme
- Deploy the same config across dev, staging and production
