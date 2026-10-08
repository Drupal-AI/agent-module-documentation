<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain 301 Redirect (domain_301_redirect) — agent index

301-redirects any domain/subdomain the site answers on to one configured "main" domain,
preserving the path. Implemented as a response event subscriber; no plugins, Drush, or
submodules. Depends on core `path_alias`. Provides a config schema and two permissions.

- **Settings form, config keys, the redirect subscriber, page include/exclude, and the
  domain-check route/token** → [configure/settings.md](configure/settings.md)
- **The two permissions (`administer …`, `bypass …`)** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config object `domain_301_redirect.settings`: `enabled` (bool), `domain` (string),
  `applicability` (0 = exclude listed pages, 1 = include only listed pages), `pages` (string).
  Defaults ship in `config/install`: `enabled: true`, empty `domain` (so nothing redirects
  until a domain is set).
- `DomainRedirectEventSubscriber` runs on `KernelEvents::RESPONSE` (priority 31) and returns a
  `TrustedRedirectResponse(..., 301)` with header `X-Redirect-ID: 0` when host/scheme differ.
- Settings form at `/admin/config/search/domain-301-redirect` (perm `administer domain 301 redirect`).
- Check route `domain_301_redirect.check` (`/domain-301-redirect-check`) is access-gated by a
  `token` query arg = `Crypt::hmacBase64('domain_301_redirect_check_domain', hashSalt . privateKey)`.
- The redirect target is admin-only config (`administer …`, `restrict access: true`), the check
  route is HMAC-token gated, and the outbound domain-check request targets an admin-entered domain.
