<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Protected Pages Extra password-protects arbitrary pages (single paths or wildcards), gated by granular permissions and rate-limited against brute force. It is a config-entity, HTTP-middleware reimplementation of the Protected Pages module.

---

Protected Pages Extra lets administrators require a password to view any path on a Drupal 11 site. Each protected page is a `protected_page` config entity holding a title, one or more paths (wildcards like `/news/*` allowed), a hashed password, and an "allow password in URL" flag — so protection is exportable via CMI and survives deployments. Enforcement runs in an HTTP middleware (priority 30) that normalizes the request path through the full inbound path-processor chain, matches it (exact internal path, then alias, then wildcard patterns longest-first), and redirects unauthenticated visitors to a login form; unlocks are stored per-session with a configurable expiry. A password mode setting chooses between per-page password, global password, or either. Failed attempts are rate-limited via core's flood service on two axes (per-IP and per-page-per-IP), with a configurable IP allowlist that exempts trusted origins. Protected responses carry `Cache-Control: private, no-store` and the entity's config cache tag, and entity saves invalidate the `http_response` tag so CDN/proxy caches are evicted. A per-entity "Send email" operation notifies recipients using configurable subject/body templates with URL and wildcard tokens. On first install it migrates entities, settings, and role permissions from the legacy `protected_pages` module and suppresses that module's redirect so the two coexist. Depends on core `path_alias`; requires Drupal 11.1+.

---

- Password-protect a single page by its path.
- Protect many paths under one shared password with a single entity.
- Protect whole sections with wildcards (e.g. `/news/*`, `/*/edit`).
- Gate pages independently of Drupal's role/permission access.
- Set a site-wide global password for every protected page.
- Choose per-page, global, or either-accepted password modes.
- Re-prompt visitors after a configurable session expiry.
- Rate-limit brute-force password guessing per IP and per page.
- Allowlist trusted IPs to skip flood limits (IPv4/IPv6, single or range).
- Customize login-form title, description, field label, button, and error text.
- Translate login and email strings per language via config_translation.
- Email recipients a notification with the protected URLs and password hint.
- Let a page accept `?password=…` in the URL (opt-in per entity).
- Grant trusted roles a bypass so they never see the prompt.
- Export protected pages with `drush cex` for deployment across environments.
- Exclude per-environment passwords from config export via Config Ignore.
- Keep protected responses out of CDN/proxy caches (`private, no-store`).
- Evict already-cached pages when a path becomes protected.
- Migrate entities, settings, and permissions from the legacy Protected Pages module.
- Run both Protected Pages and Protected Pages Extra side by side without double prompts.
- Soft-gate confidential reports, drafts, or pre-launch pages.
- Password-protect content behind a language prefix or alias transparently.
- Query the access-checker service programmatically to test whether a path is protected.
- Unlock a protected page for the current session from custom code.
