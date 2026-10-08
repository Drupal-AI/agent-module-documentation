<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Security Advisories NL (security_advisories_nl) — agent index
**Aggregates Dutch security advisories (NCSC/CSAF/RSS/WordPress) into `security_advisory` entities with admin + queue tooling.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11 · **Depends on:** node, views
- **Config:** `security_advisories_nl.settings` → `/admin/config/system/security-advisories-nl` (`administer security advisories nl`)
- **Permissions:** `administer security advisories nl` (restrict), `manage security advisories`, `view security advisories`
- **Public routes:** `/security-advisories`, `/security-advisory/{advisory}` (`view security advisories`)
- **Services:** `HttpCacheService`, `AdvisoryFetcherService`, `QueueManagerService`, `NcscParserService`, `RssParserService`, `WordPressParserService`; Drush commands; QueueWorkers; `LatestAdvisoriesBlock`

**Security:** Source/fetch URLs come only from admin forms (`administer security advisories nl`) with `FILTER_VALIDATE_URL` — no anonymous SSRF. Guzzle fetches use default TLS verification (no `verify => false`). Every mutating/maintenance route is admin- or manage-gated; only the two listing routes are visitor-facing (view permission). No findings. See [configure/sources.md](configure/sources.md).
