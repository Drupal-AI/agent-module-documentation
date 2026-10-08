<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Makes the Redirect module domain-aware so the same source path can redirect to different destinations depending on which domain (from the Domain module) is serving the request.

---

Domain Redirect adds a `domain_id` entity-reference base field to every redirect entity and decorates the `redirect.repository` service so redirect matching is filtered by the active domain during request handling. A redirect can be scoped to a single domain or left global (applies to all domains), and when a source path has both a domain-specific and a global redirect the domain-specific one wins. The module replaces the core Redirect `RedirectUniqueHash` constraint with a domain-aware constraint so the same source path may have distinct redirects on different domains, changes the `redirect` table index from a unique key on `hash` to a composite `(hash, domain_id)` index, and adds a Domain column plus an exposed Domain filter to the redirect admin view. It has no settings page of its own — the Domain selector appears directly on the Redirect module's add/edit form. It also integrates with Domain Path so that redirects auto-created from a domain-specific alias change inherit that alias's domain. Requires Domain 3.x and Redirect 1.x on Drupal 10.2+ or 11.

---

- Run one Drupal install serving several domains and redirect the same legacy path to a different target per domain.
- Redirect `/promo` to a country-specific landing page on each regional domain.
- Keep a single global redirect as the default while overriding it only on the domains that need something different (domain-specific redirects take precedence).
- Migrate content on one domain and add domain-scoped redirects without affecting sibling domains sharing the same paths.
- Allow the same source path to exist as multiple redirects, one per domain, which plain Redirect would reject as a duplicate hash.
- Filter the URL-redirects admin list by domain to audit redirects for a single site in a multi-domain install.
- See at a glance which domain each redirect is scoped to via the new Domain column in the redirect listing.
- Point `/contact` to different regional contact pages depending on the visiting domain.
- Send affiliate or white-label domains to their own destinations for shared marketing URLs.
- Combine domain and language scoping so a path redirects differently per domain and per language.
- Set a global 301 redirect that all domains inherit unless a domain provides its own override.
- Consolidate SEO redirects across a domain farm from one Redirect admin screen.
- Let editors manage per-domain redirects from the familiar Redirect UI with no extra configuration to learn.
- Auto-create a domain-scoped redirect when a Domain Path alias is renamed, inheriting the alias's domain.
- Preserve query-string passthrough behavior of the Redirect module while adding per-domain matching.
- Fall back to non-domain-aware redirect matching automatically on requests where no domain has been negotiated yet.
- Retire the old `/domain-redirect/12345` custom-path approach (7.x/8.x) in favor of standard Redirect entities scoped by domain.
- Provide different maintenance or "moved" redirects per brand domain during a rebrand.
- Route the same short URL to different destinations for staging versus production domains.
- Manage tens of thousands of per-domain redirects efficiently thanks to the composite `(hash, domain_id)` index.
