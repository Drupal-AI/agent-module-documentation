Adds `Vary` HTTP headers so the Acquia platform's Varnish layer can cache and serve full pages that differ by specific cookie values.

---

Acquia Cookie Vary is a small, dependency-free performance module for sites hosted on the Acquia Cloud platform. Drupal already tracks which pages depend on a cookie through its `cookies:<name>` cache contexts, but Acquia's Varnish infrastructure does not vary on the raw `Cookie` header — it varies on a set of purpose-built request headers (`X-Acquia-Cookie-A`, `-B`, `-C`, and a `X-Acquia-Cookie-Key`/`X-Acquia-Cookie-Value` pair for one site-defined cookie). This module bridges the two: a single response event subscriber inspects each cacheable response's cache contexts and, when it finds one of the recognized `cookies:*` contexts, appends the matching `Vary` header value so Varnish partitions the cache correctly. The result is server-side, full-page-cached personalization/segmentation with no client-side flash of unstyled or original content and no layout shift. An optional, off-by-default debug mode echoes the relevant cookie values back as `X-Acquia-Cookie-*` response headers to help operators confirm the cache-variation plumbing is working. Configuration is limited to one settings form (custom cookie name + debug toggle) gated behind `administer site configuration`.

---

- Serve cookie-varied full-page cache hits from Acquia Varnish instead of relying on JavaScript personalization.
- Eliminate flashes of original/unstyled content on segmented pages by moving variation server-side.
- Emit `Vary: X-Acquia-Cookie-A` for pages that carry the `cookies:acquia_a` cache context.
- Emit `Vary: X-Acquia-Cookie-B` / `-C` for the `cookies:acquia_b` / `cookies:acquia_c` contexts.
- Vary a full-page-cached response on a marketing/segmentation cookie set by an edge or origin process.
- Support A/B testing where the bucket is stored in one of the standard Acquia platform cookies.
- Add a site-specific custom cookie name (e.g. `geo`, `plan`, `variant`) and vary on it via `X-Acquia-Cookie-Key` / `X-Acquia-Cookie-Value`.
- Keep anonymous full-page caching enabled while still delivering per-segment content.
- Confirm which cookie a given page varies on by enabling debug headers temporarily.
- Debug caching problems by reading the reflected `X-Acquia-Cookie-A: <value>` response header for the current request.
- Drive block or content visibility from a cookie and have that variation honored by the CDN cache tier.
- Integrate Drupal's cache-context system with Acquia's documented Varnish cookie-vary contract without custom code.
- Provide the header prerequisites needed before configuring Cloudflare Cache Keys (enterprise) to vary on individual cookies.
- Identify the paths that need a CDN cache-bypass rule (non-enterprise) by seeing which responses gain `X-Acquia-Cookie-*` vary values.
- Reduce origin load by keeping segmented pages in the Varnish cache rather than bypassing cache for logged-in-style personalization.
- Roll out geo- or locale-based content variation driven by an edge-set cookie.
- Show pricing or plan-tier content that differs by a cookie while staying fully cacheable.
- Vary a landing page on a campaign/referrer cookie for personalized-but-cached experiences.
- Audit cache memory pressure implications before enabling variation (each varied cookie multiplies Varnish object count).
- Turn debug mode off in production after verifying the vary plumbing to keep response headers minimal.
- Standardize how a multi-site or agency team wires Acquia cookie variation across projects.
