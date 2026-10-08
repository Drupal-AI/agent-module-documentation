<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Find External Links scans configured node fields for anchor tags pointing to external URLs and records them, then presents the collected external links (with content type and node id) in an admin report. Useful for auditing outbound links across a site.

---

- Drupal 8.8, 9, or 10; no extra dependencies.
- Enable with `drush en find_external_links`.
- Configure at `/admin/config/system/find-external-links` (permission: "administer find external links", restricted) — choose fields to scan and ignore-strings for domains to skip.
- Run the scan (batch process) to (re)build the list; the previous list is cleared each run.
- View results at `/admin/config/system/find-external-links/list` (paged, sortable table).

---

- Inventory all external/outbound links on the site.
- Scan selected node fields (e.g. body) for `<a>` hrefs.
- Ignore internal links (href starting with `#` or `/`).
- Skip links matching configured ignore-strings/domains.
- List each external URL with its content type and node id.
- Link straight to the source node from the report.
- Page and sort the results table.
- Rebuild the list on demand via a batch operation.
- Audit for broken or unwanted third-party links.
- Support SEO/compliance reviews of outbound links.
- Restrict access with a dedicated admin permission.
- Store results in a dedicated database table.
- Re-run scans after content changes.
- Parse HTML with DOMDocument to extract links.
- Cover multiple content types in one report.
- Provide a starting point for link-policy enforcement.
