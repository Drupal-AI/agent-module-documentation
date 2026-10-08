Audit analyzer that scores Views displays for cache misconfiguration, expensive relationships, generic cache tags and access issues.

---

audit_views registers the `views` AuditAnalyzer plugin (ViewsAnalyzer) and depends on core Views. It scans View config entities for missing/weak display caching, excessive relationships (above the configurable `relationships_threshold`), overly-generic cache tags that cause broad invalidation, and displays exposing data to anonymous users; when Search API views are present it also flags rendering and caching pitfalls specific to Search API. An admin can exclude specific views from cache checks (`cache_excluded_views`), skip disabled views, and enable Search-API-on-MySQL detection. Scored issue sections are complemented by display and cache overviews.

---

- Detect Views displays with missing or ineffective caching.
- Flag views with too many relationships (N+1 query risk) above `relationships_threshold`.
- Find overly-generic cache tags that trigger broad, expensive invalidation.
- Identify displays exposing content to anonymous users unintentionally.
- Audit Search-API-backed views for rendering and caching pitfalls.
- Exclude noisy admin views (watchdog, redirect_404) from cache checks via `cache_excluded_views`.
- Skip disabled views with `exclude_disabled_views` to reduce noise.
- Detect Search API indexes served from a MySQL backend (`detect_searchapi_mysql`).
- Review a display overview and cache-status summary.
- Score the Views layer as part of the overall Project Score.
- Run headless via `drush audit:run views --format=json`.
- Include Views performance in a pre-deploy check.
- Prioritize which views to optimize when taking over a site.
- Track Views quality across a portfolio via DruScan.
- Get inline remediation guidance per cache/relationship finding.
