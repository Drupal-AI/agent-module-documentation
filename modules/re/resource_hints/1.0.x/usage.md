Resource Hints adds W3C resource-hint directives (`dns-prefetch`, `preconnect`, `prefetch`, `prerender`) to every page so browsers can resolve DNS, open connections, or pre-fetch/pre-render third-party resources ahead of need. Each hint type is configured from one admin form and emitted either as an HTTP `Link` header or as an HTML `<link>` element.

---

A single settings form at `/admin/config/development/performance/resources-hints` (permission `administer resource hints`) collects, per hint type, a newline-separated list of resource URLs and an output mode (`Link` HTTP header vs. `<link>` HTML element). It also exposes an `X-DNS-Prefetch-Control` on/off toggle for the `dns-prefetch` type. On every response, `resource_hints_page_attachments_alter()` reads `resource_hints.settings` and, for each configured URL, runs `UrlHelper::stripDangerousProtocols()` before attaching it — as `#attached['http_header']` (`Link: <url>; rel="dns-prefetch"` etc.) when header mode is selected, or as `#attached['html_head_link']` (`<link rel="…" href="…">`) otherwise. The DNS-prefetch control value is HTML-escaped and emitted as an `X-DNS-Prefetch-Control` header or an `http-equiv` meta tag; when DNS prefetch is set to Disabled the `dns-prefetch` links are skipped entirely. Config is stored as sequences in `resource_hints.settings` with a schema; the module has no other UI, no Drush commands, and no dependencies beyond core. Because hints are applied globally to all pages, this is a set-and-forget performance tuning tool rather than a per-entity feature.

---

- Emit `dns-prefetch` hints so browsers resolve third-party domains (fonts, CDNs, analytics) early.
- Emit `preconnect` hints to open TCP/TLS connections to critical origins ahead of time.
- Emit `prefetch` hints to download resources likely needed on the next navigation.
- Emit `prerender` hints to render a likely next page in the background.
- Choose HTTP `Link` header output for hints (works even where you can't edit `<head>`).
- Choose HTML `<link>` element output for hints instead of headers.
- Enable DNS prefetching over HTTPS (off by default in browsers) via the control toggle.
- Explicitly disable DNS prefetching site-wide, ignoring inline attempts.
- Speed up first paint by preconnecting to a font provider (e.g. fonts.gstatic.com).
- Reduce latency to an analytics or tag-manager domain with dns-prefetch/preconnect.
- Warm up a payment or API origin used later in a checkout flow.
- Configure several resources per hint type, one URL per line.
- Apply the same hints across the whole site with no per-page setup.
- Improve Core Web Vitals (LCP) by connecting to render-critical third-party origins sooner.
- Manage all resource hints from one performance settings page.
- Keep hint URLs sanitized — dangerous protocols (e.g. `javascript:`) are stripped on output.
