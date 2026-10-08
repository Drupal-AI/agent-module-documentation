<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Short URL makes the Short URL module domain-aware on multi-domain sites.

---

It decorates Short URL's manager and slug generator, adds a domain field to short-URL nodes, and scopes everything by domain: full URLs are built with the assigned domain's hostname and path prefix, redirects are stamped with a `domain_id`, auto-increment counters can run per-domain, and slug lookups/uniqueness are validated within a `(domain, language)` pair rather than globally. The node form filters the domain selector to the user's `domain_access` domains unless they hold `create shorturl on any domain`, and visit tracking records the domain. A response header (`X-Shorturl-Domain-Id`) lets domain-aware tracking record the domain without an extra DB lookup.

Security: the only route is the settings form (`administer shorturl`); redirects are produced through the redirect/Short URL machinery (no user-controlled redirect target — slugs resolve to internal short-URL nodes, so no open-redirect), and the per-domain max-slug query uses parameterized placeholders. Setup: enable alongside Short URL + Domain + Domain Redirect, choose per-domain vs global counter scope on the settings form, and assign a domain when creating a short URL.

---
- Reuse the same slug on different domains without collision.
- Scope short-URL slug uniqueness per domain and language.
- Build short URLs with each domain's hostname and prefix.
- Run auto-increment slug counters per domain.
- Assign a target domain to a short-URL node.
- Filter the domain selector to a user's assigned domains.
- Grant `create shorturl on any domain` to bypass domain scoping.
- Record the domain on each short-URL visit.
- Stamp redirects with the correct `domain_id`.
- Fall back to global slug lookup when no domain match.
- Keep QR/download links pointing at the right domain.
- Choose global vs per-domain counter scope in settings.
- Sync a short URL's `field_domain_access` to its domain.
- Title short-URL nodes as "{slug} @ {domain}".
- Provide a domain filter in the short-URL admin view.
- Prevent editors creating slugs on unauthorized domains.
- Serve domain-correct absolute short URLs in emails/exports.
- Migrate a single-domain Short URL setup to multi-domain.
