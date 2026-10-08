<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Agent orientation: cloudflare_images

**What:** Offloads `image` media to Cloudflare Images and rewrites file URLs to `imagedelivery.net`.

**Key files:**
- `cloudflare_images.module` — `hook_entity_presave`/`predelete` (shutdown sync), `_cloudflare_images_entity()` (POST to Cloudflare API), `hook_file_url_alter()` (URL rewrite).
- `src/Form/SettingsForm.php` — admin config (host, site name, account ID, hash, token).

**Config:** `cloudflare_images.settings` at `/admin/config/cloudflare_images/settings`.

**Notes:** Only acts when request host == configured `site_host`. API token lives in plain config. TLS verification is default-on (Guzzle). Only the `public` variant is served.
