<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Path Redirect makes the Redirect module domain-aware: each redirect is stored as its own content entity carrying a domain reference, so `/offers` can point to a different destination on each domain of a Domain Access site.

---

The Redirect module stores one redirect per source path for the whole install, which breaks down when several domains share a Drupal site and need different destinations for the same path. This module adds a `domain_path_redirect` content entity that subclasses Redirect's entity and adds a `domain` reference (defaulting to the active domain). The match key is a hash of the source path, language, query and domain, computed in `preSave()`, so the same `(path, language, query)` yields a different record per domain — that is how one path can redirect differently on each site. A `KernelEvents::REQUEST` subscriber (priority 33, before routing) asks the `domain_path_redirect.repository` service for a match against the current path and active domain, follows chained redirects, guards against loops (503 on a loop), optionally passes through the incoming query string, and issues a `TrustedRedirectResponse` with the record's own status code and an `X-Redirect-ID` header. Only `enabled = 1` records match. Administration is the entity list at `/admin/config/search/domain_path_redirect`, gated by Redirect's existing `administer redirects` permission (no new permission is defined), with a domain-name autocomplete Views filter for the listing. It requires `domain` and `redirect (>= 1.12.0)`.

---

- Point the same path at different destinations per domain.
- Redirect a legacy URL only on the domain where it existed.
- Keep marketing short links domain-specific.
- Manage per-domain redirects from a dedicated admin listing.
- Reuse the Redirect module's permission model instead of a new one.
- Add a redirect for a campaign on one affiliate site only.
- Avoid conflicting global redirects between domains.
- Migrate a domain-specific site into a multi-domain install.
- Redirect old country-site paths to new equivalents.
- Keep SEO tidy after consolidating several sites into one.
- Give each brand its own redirect set on a shared install.
- Filter the redirect list by domain name via autocomplete.
- Chain redirects that resolve to a final target within a domain.
- Pass through incoming query strings to the destination.
- Set a per-record HTTP status (301/302/…) per domain.
- Enable or disable an individual redirect via its `enabled` flag.
- Redirect to an external URL for a specific domain.
- Deploy domain redirects as content rather than config.
- Audit which redirects exist per domain in Views.
- Retire a domain gracefully by redirecting its paths.
- Look up redirects programmatically via the repository service.
- Prefill an add-redirect form from `?source=`/`?redirect=` query params.
