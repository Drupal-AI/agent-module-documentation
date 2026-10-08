<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Url Status Scanner — agent index

**Broken-link checker** — scans URLs in the site's own **content/config** and reports HTTP status on a
dashboard. Depends on core `node`. Config at `url_status_scanner.settings`; scan gated by
`execute url_status_scanner`. Version **1.0.3**. Core `^10||^11`.

Makes server-side requests to found URLs (site's own content/config, not arbitrary input; admin-run) —
a link auditor. Restrict the scan permission to trusted admins (it fetches whatever link URLs exist in
content).
