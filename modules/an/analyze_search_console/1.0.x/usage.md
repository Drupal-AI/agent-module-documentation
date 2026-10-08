Analyze Search Console surfaces Google Search Console performance data (clicks, impressions, CTR, average position) for URL-bearing entities inside Drupal's Analyze tab, plus a sitewide report.

---

Analyze Search Console is an Analyze-framework plugin by DXPR that connects a Drupal site to the Google Search Console (Webmasters) API and shows each entity's search performance right on its Analyze tab — clicks, impressions, click-through rate, and average position, each with a change indicator versus the previous period. A full report drills into Queries, Pages, Countries, and Devices dimensions, with 7/14/28/90-day windows, Web/Image/Video/News search types, country and dimension filters, status badges (up/down/new/lost), and pagination. A sitewide report lives under Reports, and a set of Drush commands mirror the UI on the CLI. OAuth client credentials are stored through the Key module; the access/refresh token lives in Drupal state; results are cached for a configurable TTL. It requires the Analyze base module (>=1.1.0), the Key module, and the `google/apiclient` Composer package.

---

- See a page's Google clicks, impressions, CTR, and average position without leaving the node edit/Analyze workflow.
- Show each metric with its change versus the previous equal-length period (e.g. "1,234 (+12.3%)").
- Drill into the top search queries that bring traffic to a specific page.
- Break search performance down by country for one page or sitewide.
- Break performance down by device (desktop / mobile / tablet).
- Compare Web vs Image vs Video vs News search types for a URL.
- Switch date windows between the last 7, 14, 28, or 90 days.
- Filter report rows by status: up, down, new, or lost keywords/pages.
- Text-search within a dimension's rows (case-insensitive contains on the key).
- Apply and remove stacked dimension filters via clickable filter chips on entity reports.
- View a sitewide performance report at /admin/reports/search-console.
- Auto-detect and pick your Search Console property from a dropdown after connecting.
- Map dev/staging entity paths to your production domain via a base URL override so data still resolves.
- Support both URL-prefix properties (https://example.com/) and domain properties (sc-domain:example.com).
- Store Google OAuth client ID and secret as Key entities rather than plaintext config.
- Check connection status and list accessible properties from the CLI (`drush analyze-sc-status`).
- Query any URL's Search Console data from the CLI (`drush analyze-sc-query /path`).
- Print a sitewide CLI report with country/status/search filters (`drush analyze-sc-report`).
- Clear cached Search Console data on demand (`drush analyze-sc-cc`).
- Jump straight to the matching report in Google Search Console via per-page source links.
- Gate report visibility with the dedicated `access search console reports` permission.
- Integrate SEO performance data into a marketing CMS editorial workflow (DXPR CMS suite).
