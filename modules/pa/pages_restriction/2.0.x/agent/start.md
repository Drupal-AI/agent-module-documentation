<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pages Restriction Access — agent index

Redirects visitors from configured **restricted pages** to a **target page**, unless they hold
a **bypass role** or a per-page **session bypass**. All rules live in one config object
`pages_restriction.settings`. No config schema, no own permissions (uses `administer site
configuration`), no Drush.

- **The settings config (`pages_restriction`, `keep_parameters`, `bypass_role`), the configure route, and the redirect rules** →
  [configure/settings.md](configure/settings.md)
- **The request subscriber's logic and the session-bypass service (`setBypass`)** →
  [api/services.md](api/services.md)

Key facts:
- Config object `pages_restriction.settings`: `pages_restriction` (textarea, one `restricted|target` per line), `keep_parameters` (bool), `bypass_role` (roles that skip restrictions).
- Configure UI: `/admin/config/development/pages-restriction/settings`, route `pages_restriction.settings`, permission `administer site configuration`.
- Enforcement: kernel `REQUEST` subscriber `PagesRestrictionSubscriber` (redirects on match); matching is against the current path's **alias**.
- Session bypass: `pages_restriction.session_service` → `setBypass($path)` stores a one-time allow in the `pages_restriction_bypass` session array.
