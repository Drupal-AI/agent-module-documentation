<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Detects external links across content entities, verifies their HTTP status in the background, and reports broken ones on an admin dashboard.

---

External Link Status Check scans content entities for outbound URLs, records each one (with the HTTP status code, response time, scraped page title and thumbnail, and its source entity) in a dedicated `external_links_registry` database table, and re-checks them so editors can find and fix dead links. Scanning is triggered automatically when an entity is inserted or updated and during cron, and a full manual scan can be launched from a form; the actual URL fetches run asynchronously through Drupal's Queue API (queue `external_link_status_check_queue`, worker `LinkCheckerWorker`) so page requests stay fast. Results appear on a report at `/admin/reports/external-links` with All / Broken / 200-OK filters, a pager, and a CSV export. The module depends only on core's `link` and `node` modules, ships no permissions or config schema of its own (it reuses core permissions on its routes), and drops its table on uninstall.

---

- Find broken outbound links across all content on a Drupal 10/11 site.
- Run an SEO audit that flags dead external references before search engines penalize them.
- Maintain editorial link integrity by monitoring links authors add to nodes.
- Monitor external partner or supplier links for availability over time.
- Track HTTP status codes (200 vs. error) for every external URL used in content.
- Record response time for each external link to spot slow destinations.
- Build a broken-link report editors can review at `/admin/reports/external-links`.
- Filter the report to show only broken links or only 200-OK links.
- Export the full link inventory to CSV for a spreadsheet or compliance record.
- Scan content automatically whenever a node or other content entity is saved.
- Schedule recurring link checks via Drupal cron without manual effort.
- Trigger an on-demand full scan of all supported content from the scanner form.
- Offload slow external HTTP checks to a background queue processed on cron.
- Keep the tracking table tidy by removing a link when its source entity is deleted.
- Remove links from the registry when they are edited out of content.
- Cache a link's status for 24 hours to avoid re-fetching the same URL repeatedly.
- Capture each destination page's `<title>` and Open Graph / Twitter image for context.
- Show a thumbnail preview and source entity link for each tracked URL on the dashboard.
- Support link discovery in nested content via entity-reference traversal.
- Detect protocol-less `www.` links and normalize them to `https://`.
- Prepare accessibility or compliance reports that require a list of outbound links.
- Provide a starting point for content-quality assurance workflows.
- Give site administrators an at-a-glance count of total, broken, and healthy links.
