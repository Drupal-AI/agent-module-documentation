Audit analyzer that scores a site's performance and cache configuration and flags debug/anti-pattern code.

---

audit_performance registers the `performance` AuditAnalyzer plugin (PerformanceAnalyzer). It scores production readiness (error-display level, Twig debug/auto-reload, CSS/JS aggregation, page/dynamic-page cache, BigPipe), inspects the state of cache-related contrib modules (delegating discovery to audit_modules), and statically scans the custom-code scan directories for cache-bubbling and performance anti-patterns (e.g. `file_get_contents()`/`fopen()` on variable URIs, direct DB queries where entity API is preferred, leftover debug code). Findings surface as scored issue sections plus informational status tables on the Performance detail page.

---

- Score a production site's cache and aggregation configuration before go-live.
- Detect `error_level`/Twig-debug settings left in a development state on production.
- Confirm CSS and JS aggregation are enabled and page/dynamic-page caching is configured.
- Check BigPipe is enabled (with an option to ignore the sessionless case via `ignore_bigpipe_sessionless`).
- Verify the recommended cache max-age against the configurable `recommended_cache_max_age` (default 21600s).
- Flag cache-related contrib modules that are missing or misconfigured.
- Statically scan custom modules/themes for `file_get_contents()`/`fopen()` on variable URIs (slow on S3/remote).
- Spot direct database queries in custom code where entityQuery/cache APIs are preferable.
- Find leftover debug code (var_dump/kint/dpm) affecting performance.
- Produce a weighted Performance score that feeds the overall Project Score.
- Review a per-issue faceted list filterable by severity and tag.
- Run headless via `drush audit:run performance --format=json` in CI.
- Compare performance posture across multiple client sites via DruScan.
- Use as a quality gate for AI-generated code that ignores caching best practices.
- Enumerate cache anti-patterns in Twig-adjacent preprocess/theme code.
- Get remediation guidance rendered inline with each detected issue.
