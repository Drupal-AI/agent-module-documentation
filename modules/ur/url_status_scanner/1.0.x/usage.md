<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Url Status Scanner scans external URLs found in the site's content and configuration, displaying their HTTP response codes and details on a dashboard.

---

Url Status Scanner is a broken-link checker: it scans URLs found in the site's own content and
configuration (base code, config, content — as toggled in settings) and reports each URL's HTTP status
code and details on a dashboard, so administrators can find broken or redirecting links. It depends on
core Node, is configured at `url_status_scanner.settings`, and the dashboard/scan is gated by the
`execute url_status_scanner` permission.

Use it to audit outbound links across the site for 404s and other problems. Note the scanner makes
server-side HTTP requests to the URLs it finds; because those URLs come from the site's own content/
config (not arbitrary attacker input) and only permissioned administrators run the scan, it functions as
a link auditor rather than an open request tool. Still, be aware it fetches whatever URLs exist in
content — on sites where lower-trust users can author link URLs, a scan run by an admin will request
those URLs, so restrict the scan permission to trusted administrators. Configure which scopes (config/
content) are scanned.

---

- Scan site URLs for broken links.
- Report HTTP status codes.
- Find 404s and redirects.
- Scan content and config URLs.
- Show results on a dashboard.
- Depend on core Node.
- Configure at url_status_scanner.settings.
- Gate scanning by permission.
- Audit outbound links.
- Make server-side requests to found URLs.
- Scan the site's own links (not arbitrary input).
- Restrict the scan to trusted admins.
- Choose config/content scan scopes.
- Detect broken references.
- Check link health.
- Run link audits.
- Report link details.
- Find dead links.
- Monitor URL status.
- Audit links across the site.
