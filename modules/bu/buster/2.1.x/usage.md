Buster appends a content-derived cache-busting query token to the external URLs of public files so CDNs, proxies and browsers refetch a file automatically whenever its contents change.

---

Buster is a zero-configuration performance module that replaces Drupal's `public` stream wrapper service with `Drupal\buster\PublicStreamBusted`, a subclass of core's `PublicStream`. It overrides `getExternalUrl()` so that every generated public-file URL (images, documents, downloads, uploaded managed files, etc.) gains a short `_buster=<token>` query parameter. The token is an 8-character HMAC computed from the file's URI plus a `sha1_file()` hash of the current file contents (or the request time as a fallback when the file cannot be read), keyed by the site private key and hash salt. Because the token is derived from file contents, editing or replacing a file changes its URL, so downstream caches treat it as a new resource and never serve a stale version. Aggregated CSS/JS in `public://css/` and `public://js/` are deliberately excluded because Drupal already versions those. The module ships no routes, permissions, config, forms, blocks or Drush commands — installing it is the entire setup.

---

- Enable the module so all public file URLs are automatically cache-busted with no further configuration.
- Force a CDN to serve the updated version of an image immediately after it is re-uploaded under the same filename.
- Prevent browsers from showing a stale logo or favicon after a site rebrand replaces the file in place.
- Keep long CDN/edge cache TTLs on public files while still guaranteeing freshness when content changes.
- Avoid manually appending `?v=123` version strings to public asset URLs.
- Ensure downloadable PDFs, brochures or price lists always reflect the latest uploaded revision.
- Bust caches for user-uploaded media managed through public file fields.
- Support aggressive origin-shield / reverse-proxy caching (Varnish, Cloudflare, Fastly, Akamai) of public files.
- Guarantee that a replaced webform or media attachment is delivered fresh to end users.
- Let editors overwrite a file in place (same path) without worrying about cache lifetimes.
- Provide deterministic, content-addressed URLs that only change when the underlying bytes change.
- Reduce support tickets caused by "I updated the file but still see the old one" cache issues.
- Combine with far-future `Cache-Control`/`Expires` headers on public files safely.
- Keep image-style derivative URLs fresh when their source file is replaced.
- Deploy across Drupal 8, 9, 10 and 11 sites with a single dependency-free module.
- Use as a lightweight alternative to complex asset-versioning or manifest tooling.
- Ensure syndicated or hotlinked public file URLs invalidate when the file is updated.
- Serve fresh public images to mobile apps or headless front-ends consuming Drupal file URLs.
- Skip busting on aggregated CSS/JS (already handled by core's own query-string versioning).
- Fall back gracefully to a request-time token when a file's bytes cannot be read at URL-build time.
