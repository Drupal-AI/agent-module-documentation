Analyze Broken Links extracts the links from your content and verifies each one's HTTP status, surfacing dead and redirected links per page and site-wide.

---

Analyze Broken Links is an add-on for the Analyze module that turns broken-link detection into a first-class content-quality signal. It registers an Analyze plugin (`analyze_broken_links_checker`) that renders each entity, parses out the URLs it contains (`<a href>`, `<img src>`, `<iframe src>`, `<script src>`, and other media `src` attributes), and issues concurrent server-side HTTP requests (HEAD first, GET fallback) to determine each link's status code, final redirect target, and response time. Results are cached in two dedicated database tables and shared across every entity that references the same URL, so a popular URL is checked only once. Content authors see a per-page "Broken Links" health gauge in the Analyze tab; administrators get a filterable site-wide Views report, a Drupal status-report warning when broken links exist, and three Drush commands. Cron keeps the data fresh by rechecking stale URLs and auto-scanning newly published entities of the content types you enabled. A settings form lets you tune request timeout, concurrency, recheck interval, check scope (internal/external/both), URL exclusion patterns, User-Agent, and which HTTP status codes count as "broken". The module needs no API keys or external services — checking runs entirely on your server via core's Guzzle HTTP client.

---

- Detect dead outbound links (404/410/5xx) in article bodies before visitors and search engines hit them.
- Give content editors an at-a-glance link-health gauge on each node's Analyze tab.
- Run a site-wide broken-links report at `/admin/config/analyze/broken-links` → Results tab, filtered by status, scope, or content type.
- Surface a warning on the Drupal status report page (`/admin/reports/status`) whenever broken links are present.
- Check links from the command line in CI: `drush analyze:broken-links:check node/123`.
- Emit machine-readable JSON for pipelines: `drush analyze:broken-links:report --format=json`.
- Show only broken links for a single node: `drush analyze:broken-links:check node/123 --status=broken`.
- Limit checking to external links only during an SEO audit: `--scope=external`.
- Recheck stale URLs on demand after a maintenance window: `drush analyze:broken-links:recheck --limit=200`.
- Auto-scan freshly published content on cron without manual batch runs.
- Batch-scan a whole content type via Analyze's UI/CLI: `drush analyze:batch --analyzers=analyze_broken_links_checker`.
- Find internal links left dangling after deleting or restructuring pages.
- Exclude noisy or intentionally non-HTTP links (`mailto:*`, `tel:*`, `javascript:*`, `#*`) from checks.
- Skip staging or third-party hosts by adding wildcard exclusion patterns such as `*://staging.example.com/*`.
- Tune the recheck interval (6h–7d) so external links are re-verified on a cadence that suits your site.
- Cap request timeout (1–60s) and concurrency (1–20) to stay within your server's outbound-request budget.
- Treat additional status codes as broken (e.g. add 403 or 521–523) for stricter link-quality gates.
- Restrict which roles can see link-health data via the `access broken links reports` permission.
- Track redirect chains and see the final destination URL for links returning 3xx.
- Feed broken-link counts into content-audit and site-health dashboards.
- Identify images and embedded media (`img`, `iframe`, `video`, `audio`, `source`) that no longer load.
- Measure per-link response time to spot slow external dependencies.
- Automatically invalidate a page's cached link data when the content is edited or deleted.
- Report the number of analyzed entities per content type for coverage tracking.
