Transparently rewrites public file URLs to a CDN (CloudFront, BunnyCDN, Cloudflare, Fastly or any generic CDN) with cache-busting and filtering, and purges the CDN cache when files change.

---

Advanced Filesystem: CDN Integration serves your Drupal public files from a CDN without touching a single template. By implementing hook_file_url_alter it intercepts every public file URL Drupal generates and rewrites it to your configured CDN base URL, honouring an optional path prefix, an option to strip the public files path, a MIME-type whitelist, glob exclusions and cache-busting (off, file-modification timestamp, or a stable path hash). A |adfs_cdn_url Twig filter and function let templates convert a URI, an already-absolute URL or a file entity to its CDN URL on demand. On top of rewriting, the module can purge the CDN cache through provider-specific APIs — Cloudflare, BunnyCDN, Fastly and AWS CloudFront (with a native Signature v4 invalidation, no SDK) — or a generic HTTP PURGE/BAN/DELETE endpoint for Varnish and self-hosted caches. Purges can be triggered by hand (by CDN URL, Drupal URI, or file ID, or purge-everything), automatically when a file is updated or deleted, and either synchronously or through a cron queue so slow CDN APIs never block file saves. A credential-test endpoint and a filterable purge log help you verify and audit it. The module works standalone — only core's file module is required.

---

- Serve all public:// images and files from a BunnyCDN pull zone.
- Rewrite file URLs to an AWS CloudFront distribution domain.
- Point assets at a Cloudflare (R2 custom-domain) or Fastly host.
- Use a generic/self-hosted CDN or reverse-proxy cache by base URL.
- Add a path prefix when the CDN origin is mounted at a sub-path.
- Strip /sites/default/files from CDN URLs when the CDN serves from root.
- Cache-bust with the file's mtime so updated files invalidate automatically.
- Cache-bust with a stable path hash for long-lived immutable assets.
- Rewrite only images (or only chosen MIME types) and leave everything else local.
- Exclude a private directory or specific files from CDN rewriting via glob patterns.
- Rewrite a file URL inside a Twig template with {{ uri|adfs_cdn_url }}.
- Rewrite a file field's URL in a template from a media/node reference.
- Purge specific CDN URLs by hand from the purge form.
- Purge by Drupal public:// URI and let the module convert it to the CDN URL.
- Purge by file ID (FID), loading each file entity and clearing its CDN copy.
- Purge the entire CDN zone/distribution in one click (with a confirmation).
- Auto-purge a file's CDN copy whenever the file entity is updated.
- Auto-purge on file delete so stale assets don't linger on the edge.
- Queue auto-purges and process them on cron to keep file saves fast.
- Test CDN provider credentials before enabling purging.
- Audit purge history (provider, action, URL, result) with a filterable log.
- Preview the before/after CDN URL for an example path right on the settings form.
- Distinguish per-provider setups (Cloudflare token/zone, Fastly key/service, etc.) from one form.
