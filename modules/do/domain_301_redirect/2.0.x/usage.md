<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain 301 Redirect issues a 301 (permanent) redirect from any domain/subdomain a site answers on to a single configured "main" domain, preserving the request path — a code-only way to canonicalise a site onto one hostname/scheme for SEO.

---

The module registers a response event subscriber (`DomainRedirectEventSubscriber`, priority 31 on `KernelEvents::RESPONSE`, before core's 404/redirect handling) that runs on every request. If redirection is `enabled` and a `domain` is configured, it parses the target domain (scheme, host, optional port) and — when the current request's host or scheme differs — returns a `TrustedRedirectResponse` to `<domain><requestUri>` with a 301 status and an `X-Redirect-ID: 0` header (the same header the Redirect module uses, handy for Varnish). Requests are skipped when the user has the `bypass domain 301 redirect` permission, or when the current path matches the configured include/exclude page list (path-alias-aware, wildcard `*` supported via the path matcher). The admin settings form (`/admin/config/search/domain-301-redirect`, permission `administer domain 301 redirect`) captures the domain, an enable toggle, a page list, and include-vs-exclude applicability; before enabling it verifies the domain actually points back to the site by requesting a token-protected check route (`/domain-301-redirect-check?token=…`, token = HMAC of the site hash salt + private key) via Guzzle. Config lives in `domain_301_redirect.settings` (`enabled`, `domain`, `applicability`, `pages`). No plugins, Drush, or submodules.

---

- Redirect a bare domain (`example.com`) to `www.example.com` (or vice-versa) permanently.
- Force all traffic onto a single canonical hostname for SEO link consolidation.
- Redirect legacy/alternate domains pointing at the same site to the primary domain.
- Canonicalise scheme by redirecting `http://` visitors to the `https://` main domain.
- Consolidate several parked/marketing domains onto one main site domain.
- Preserve the full request path when redirecting across domains (`/user/1` stays `/user/1`).
- Exclude specific paths (e.g. `/api/*`, health-check endpoints) from the domain redirect.
- Restrict the redirect to only a listed set of paths (include mode) instead of site-wide.
- Let privileged users (with the bypass permission) reach the site on any domain without redirect.
- Emit an `X-Redirect-ID` header so Varnish/edge caches can recognise the redirect.
- Verify a domain actually resolves to the site before enabling redirection (built-in check).
- Move a site to a new primary domain while permanently redirecting the old one.
- Set up www→non-www canonicalisation without editing server/vhost config.
- Add a port to the canonical domain (e.g. staging on `:8443`) via the parsed domain settings.
- Apply the redirect using path aliases (matching aliased URLs, not just internal paths).
- Use wildcards to exclude an entire section (`/admin/*`) from cross-domain redirection.
- Handle multi-domain hosting where only one domain should be publicly canonical.
- Improve SEO by eliminating duplicate-content across mirror domains via 301s.
