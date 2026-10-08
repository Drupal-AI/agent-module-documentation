<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloudflare Images

Integrates a Drupal site with the Cloudflare Images product so image assets are served from Cloudflare's global CDN instead of the local file system.

- Pushes image-bundle media to the Cloudflare Images API when entities are saved, and deletes them on entity delete.
- Rewrites image file URLs to `https://imagedelivery.net/{hash}/{site_name}/{path}/public` via `hook_file_url_alter()`.
- Only acts when the current request host matches the configured "site host", so it can be limited to a live/production stage.
- Intended for sites that want Cloudflare-backed image delivery, resizing and caching without changing content-authoring workflow.

---

## Installation & configuration

- Install the module normally (`drush en cloudflare_images`); requires Drupal 9 or 10.
- Configure at `/admin/config/cloudflare_images/settings` (permission: `administer site configuration`).
- Set the Drupal host that enables the functionality (e.g. `example.pantheonsite.io`) so uploads/URL-rewrites only happen on that host.
- Set the site name used as an image-namespace prefix, the Cloudflare Account ID, Account Hash and API Token.
- The Cloudflare API Token is stored in plain module configuration (`cloudflare_images.settings`); treat exported config as sensitive.

---

## Usage & API

- On `hook_entity_presave` and `hook_entity_predelete`, the module registers a shutdown function `_cloudflare_images_entity()` to sync the entity to Cloudflare.
- Sync only fires for entities whose bundle is `image` and whose `field_media_image` references a file.
- The image is POSTed to `https://api.cloudflare.com/client/v4/accounts/{account}/images/v1` with a Bearer token over HTTPS.
- The Cloudflare image ID is derived as `{site_name}/{image_path}`, giving each site a stable namespace.
- `hook_file_url_alter()` swaps local image URIs for the Cloudflare delivery URL at render time.
- `_cloudflare_images_path_from_uri()` maps a Drupal file URI to the relative image path used in the delivery URL.
- The request host guard (`$requestHost !== $siteHost`) short-circuits both upload and URL rewrite on non-matching hosts.
- No admin UI exists for browsing or bulk-migrating already-uploaded images; sync happens incrementally on save.
- There is no local fallback: if the Cloudflare URL is wrong or the asset is missing, the rewritten URL will 404.
- The delivery URL always requests the `public` variant; other Cloudflare variants are not configurable in this version.
- API calls use the core `http_client` (Guzzle) with default TLS verification enabled.
- Uploads happen in a shutdown function, so failures do not block the entity save but are not surfaced to the editor.
- Deletion of a Cloudflare image is attempted when the source entity is deleted.
- Suitable when you already have a Cloudflare Images subscription and want transparent CDN delivery.
- Not suitable if you need signed/private image URLs or per-image access control (only the `public` variant is used).
- Review the exported `cloudflare_images.settings` config before committing, since it contains the account hash and token.
