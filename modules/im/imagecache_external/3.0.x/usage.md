<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Imagecache External lets you apply Drupal image styles to images that live on **remote** servers: it downloads the external image into a local cache directory once, then serves image-style derivatives of that cached copy.

---

Core image styles only work on locally stored files. Imagecache External bridges that gap: given an external image URL, `imagecache_external_generate_path($url)` fetches the file over HTTP (Guzzle), validates its MIME type against an allowlist, optionally sanitizes SVGs (via `enshrined/svg-sanitize`), and stores it under a configurable directory (default `public://externals`, hashed filename) as either an *unmanaged* file or a managed `File` entity. Once local, normal image styles apply. You consume it three ways: two **field formatters** (`imagecache_external_image` and `imagecache_external_responsive_image`) that render a `link`/`string`/`text` field holding a URL as a styled `<img>`; two **theme hooks** (`imagecache_external`, `imagecache_external_responsive`); and a **Twig filter** `{{ url|imagecache_external('thumbnail') }}` that returns the styled derivative URL. An admin settings form (`/admin/config/media/imagecache_external`, permission `administer imagecache external`) controls the cache directory, subdirectory nesting, default extension, allowed MIME types, an optional **host whitelist** (`imagecache_external_use_whitelist` + `imagecache_external_hosts`), a **fallback image**, SVG allowed tags/attributes, and cron-based cache flushing. A separate flush form plus a queue worker (`imagecache_external_flush_images`) and `hook_cron` purge the cache in batches. Three Drush commands (`imagecache-external:generate`, `:set-default-image`, `:validate-host`) and three alter hooks (`hook_imagecache_external_needs_refresh_alter`, `…_destination_alter`, `…_flush_filepath_alter`) round out the API.

---

- Apply an image style (resize, crop, scale) to an image hosted on another server.
- Display remote images from an API/feed with your own responsive image styles.
- Cache a partner's or CDN's images locally so styles and cropping work on them.
- Render a URL field (e.g. `field_remote_image`) as a styled thumbnail via the `imagecache_external_image` formatter.
- Show remote images through a responsive image style with `imagecache_external_responsive_image`.
- Use `{{ item.image_url|imagecache_external('large') }}` in a Twig template to style an external image.
- Avoid hotlinking by serving a locally cached copy of an external image.
- Restrict which external hosts images may be fetched from using the host whitelist.
- Sanitize externally fetched SVG files (strip scripts/unsafe tags) before serving them.
- Configure which MIME types are accepted when fetching (jpg, png, gif, webp, svg, …).
- Serve a fallback image when an external URL is unreachable or invalid.
- Cache thumbnails of externally hosted product images in a commerce catalog.
- Pull avatar/profile images from a remote identity provider and style them.
- Store cached externals in subdirectories (hashed) to avoid huge flat directories.
- Change the cache directory (e.g. to a private stream or a custom scheme) via config or the destination alter hook.
- Switch between unmanaged files and managed `File` entities for the cached copies.
- Pre-warm the cache for a known image URL with `drush imagecache-external:generate <url>`.
- Set a default/fallback image fid from the command line with `drush imagecache-external:set-default-image <fid>`.
- Test whether a host passes the whitelist with `drush imagecache-external:validate-host <host>`.
- Periodically flush the external image cache on cron (configurable frequency).
- Manually flush all cached external images from the flush form.
- Add `.webp`/`.avif` derivative paths to the flush list via `hook_imagecache_external_flush_filepath_alter()`.
- Force periodic re-fetching of changed remote images with `hook_imagecache_external_needs_refresh_alter()`.
- Route certain external images to an S3 (or other) scheme with `hook_imagecache_external_destination_alter()`.
- Serve cached external images correctly under the private file system (custom `hook_file_download`).
- Migrate content that references remote image URLs while still getting image styles.
