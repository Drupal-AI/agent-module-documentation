<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a Cloudflare-served image style

Configuration lives on each image style's edit form (`/admin/config/media/image-styles/manage/<style>`), added via `cloudflare_image_style_form_image_style_edit_form_alter`:

- **Serve from Cloudflare** (`serve_from_cf`, Yes/No) — enterprise Cloudflare Images feature.
- **Cloudflare Effect** (`cf_effect`) — the effect string placed into the `/cdn-cgi/image/<cf_effect>/…` URL.

Both are saved onto the `image.style.<name>` config object. When set, `template_preprocess_image_style` rewrites the rendered image URI to `/cdn-cgi/image/<cf_effect>/<public-target>`. Off-CDN environments hit the same path locally: `CloudflarePathProcessorImageStyles` extracts the style and moves the file path into a `file` query param, and `CloudflareImageStyleDownloadController::deliverFallback` loads the matching style (`cf_effect` + `serve_from_cf=1`) and serves the derivative via core's `deliver()` on the **public** scheme.

Security: the delivery route is `_access: 'TRUE'` (as core's image route), but the file scheme is hardcoded to `public`, confining reads to `public://` — no arbitrary path traversal to other schemes/filesystem.
