<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Security Advisories NL fetches, parses and stores security advisories from Dutch cybersecurity sources (NCSC, CSAF feeds, RSS/WordPress endpoints) as `security_advisory` content entities, with admin tooling and a public listing.
---
Admin-configured *sources* (label, URL, type rss/json/html) drive a set of parser services (`NcscParserService`, `RssParserService`, `WordPressParserService`) that fetch over an `http_client`-backed HTTP cache (`HttpCacheService`) and hand results to `AdvisoryFetcherService`, which upserts `security_advisory` entities. A queue (`QueueManagerService` + two QueueWorkers) handles batched content fetching, CVE extraction and severity updates. A large admin control panel (`AdvisoryController`) exposes many maintenance actions (fetch now, refetch content, extract CVEs, update severity, clear cache, process queue, cleanup duplicates) plus a Drush command class. A `LatestAdvisoriesBlock` and public routes render advisories to visitors.

Security posture: source URLs are entered only through admin forms gated by `administer security advisories nl` (restrict-access), so the server-side fetch target is admin-controlled — there is no anonymous SSRF vector, and `SourceForm::validateForm` requires a valid URL. HTTP fetches use Guzzle's defaults (TLS verification on; no `verify => false` anywhere in the service). All admin/maintenance routes require `administer security advisories nl`; the collection/refresh/delete routes require `manage security advisories`; the two public routes (`/security-advisories`, `/security-advisory/{advisory}`) require `view security advisories`. Note the module intentionally fetches from external, admin-supplied hosts — operators should restrict source configuration to trusted staff.

Typical setup: enable it (with Node + Views), add sources at `/admin/config/system/security-advisories-nl/sources`, fetch, then grant `view security advisories` to the audience.
---
- Aggregate NCSC advisories into Drupal.
- Parse CSAF advisory feeds.
- Pull advisories from RSS/Atom feeds.
- Import from a WordPress REST endpoint.
- Store advisories as `security_advisory` entities.
- Add/edit/delete advisory sources.
- Enable or disable individual sources.
- Fetch all advisories on demand.
- Refetch full article content.
- Extract CVE identifiers from advisories.
- Update advisory severity.
- Process the fetch queue manually.
- Clean up duplicate advisories.
- Clear the HTTP response cache.
- View queue & cache status.
- Show a "latest advisories" block.
- Publish a public advisories listing page.
- Run maintenance via Drush.
- Restrict fetching/config to security staff.
- Give read-only advisory access to a wider audience.
