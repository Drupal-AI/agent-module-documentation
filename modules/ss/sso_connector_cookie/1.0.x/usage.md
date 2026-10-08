<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cross-subdomain shared-cookie session sharing for SSO Connector.

---

SSO Connector – Cookie provides cookie-based cross-subdomain session sharing for SSO Connector — implementing the shared-cookie SSO pattern (similar to Bakery) where a signed cookie on a common parent domain provides authentication across all sub-sites, riding on the SSO Connector token infrastructure.

It builds on SSO Connector, whose tokens are RS256-signed JWTs validated via firebase/php-jwt with single-use and audience checks; keep the shared secret/keys secure (env-backed). Depends on `sso_connector` and core `help`; supports Drupal 11.2+ and 12.

---

- Share sessions across subdomains.
- Use a signed shared cookie.
- Implement the Bakery-like pattern.
- Authenticate across sub-sites.
- Ride on SSO Connector tokens.
- Keep the shared secret secure.
- Depend on `sso_connector` and core `help`.
- Support Drupal 11.2+ and 12.
- Configure the common domain.
- Handle cookie SSO.
- Share authentication.
- Link sub-sites
- Support Drupal.
- Support Drupal.
- Support Drupal.
