<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Short URL (domain_shorturl) — agent index

**Makes the Short URL module domain-aware: per-domain slug scoping, a domain field, and domain-stamped redirects/tracking.**

- **Version:** 1.0.x · **Core:** ^10.3 || ^11.2 · **Depends on:** shorturl, domain, domain_redirect
- **Route:** `domain_shorturl.settings` → `/admin/config/domain/shorturl` (permission `administer shorturl`).
- **Permission:** `create shorturl on any domain` (restricted) bypasses domain_access filtering of the domain selector.
- **Decorators:** `DomainAwareShortUrlManager` (buildFullUrl/syncRedirects/resolveNodeBySlug), `DomainAwareSlugGenerator` (per-domain counter), `DomainAwareVisitTracker` (adds `domain_id`); hook classes for entity/form/views.
- **Header:** redirect responses get `X-Shorturl-Domain-Id` for lookup-free tracking.
- **Security:** single admin route; slugs resolve to internal short-URL nodes (no open-redirect); per-domain max-slug SQL uses bound placeholders (`DomainAwareSlugGenerator.php` `getMaxNumericSlug`). No anonymous mutating endpoints. No findings.

See [configure/domain-scoping.md](configure/domain-scoping.md)
