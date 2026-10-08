CDN rewrites file URLs (CSS, JS, images, fonts, videos …) so that static assets are served from an Origin Pull CDN instead of your web server, without putting the whole site behind the CDN.

---

The module decorates Drupal's `file_url_generator` service so that URLs for public files are rewritten to point at one or more CDN domains, based on a configurable mapping. The mapping (`cdn.settings:mapping`) supports three types: `simple` (one domain, optionally limited by file-extension conditions, including negated `not` conditions), `complex` (a fallback domain plus nested per-extension mappings), and `auto-balanced` (spread matching extensions across several domains using consistent hashing so a given file always resolves to the same domain). A master `status` flag turns rewriting on/off, `scheme` chooses `//` (scheme-relative, default), `https://` or `http://`, and `stream_wrappers` limits which local stream wrappers are eligible. An optional "Far Future" feature (`farfuture.status`) serves files through a `/cdn/ff/{token}/{mtime}/{scheme}` route with 480-week cache headers and a security token, giving forever-cacheable assets (best offloaded to the web server via `.htaccess` rules on big sites). The module deliberately does not serve HTML/REST responses or private files from the CDN, adds DNS-prefetch hints for the CDN domains, and prevents duplicate content behind reverse proxies. It ships no admin UI of its own — configure it by editing `cdn.settings` directly or by enabling the bundled **CDN UI** submodule (which can be uninstalled after setup).

---

- Serve all static files from a single CDN domain (`simple` mapping with no conditions).
- Serve everything except CSS and JS from a CDN (the shipped default `not: {extensions: [css, js]}`).
- Serve only images (jpg, jpeg, png) from a CDN and leave everything else local.
- Split assets across CDNs: CSS/images from CDN A, downloads from B, the rest from a fallback (`complex`).
- Auto-balance images across two or more CDN domains with consistent hashing (`auto-balanced`).
- Use a vanity CNAME domain so the CDN host isn't obvious in the HTML.
- Generate scheme-relative (`//`) URLs so assets work over both HTTP and HTTPS.
- Force absolute `https://` asset URLs when required.
- Enable "Far Future" forever-cacheable file serving with a security-token-protected URL.
- Offload far-future file serving to Apache via the provided `.htaccess` rewrite rules on large sites.
- Add DNS-prefetch hints so browsers connect to the CDN sooner.
- Restrict CDN eligibility to specific local stream wrappers (e.g. only `public`).
- Keep private files served by Drupal while public files go to the CDN.
- Avoid serving HTML and REST responses from the CDN for SEO correctness.
- Prevent duplicate-content issues when the site sits behind a reverse proxy (Varnish) and a CDN.
- Reduce origin server load and bandwidth costs by offloading static assets.
- Improve page-load latency for globally distributed users.
- Configure everything as code by importing a `cdn.settings.yml` for repeatable deployments.
- Configure through a UI by temporarily enabling the CDN UI submodule, then uninstalling it.
- Limit a CDN mapping to a set of file extensions via `conditions.extensions`.
- Exclude specific extensions from an otherwise site-wide CDN via a negated `not` condition.
- Serve CKEditor plugin assets correctly when far-future is enabled.
- Programmatically read the active CDN domains via the `CdnSettings` service for diagnostics.
- Roll CDN rewriting out or back instantly with the single `status` flag.
