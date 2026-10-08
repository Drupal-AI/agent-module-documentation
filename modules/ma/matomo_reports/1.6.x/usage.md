<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Matomo Reports pulls analytics reports from an external Matomo (formerly Piwik) server and displays them inside Drupal's admin, plus an in-page statistics block — using a Matomo `token_auth` you configure globally or per user.

---

The module talks to a Matomo server's HTTP API using a `token_auth` credential. It adds a settings form (`/admin/config/system/matomo-reports`, route `matomo_reports.matomo_reports_settings`) storing the Matomo server URL, an optional global `token_auth`, an allowed-sites whitelist, and an "ignore SSL" flag in the `matomo_reports.matomoreportssettings` config object. When no global token is set, each user with the "Access Matomo Reports" permission can enter their own `token_auth` on their user-edit form (stored via the `user.data` service). A reports section under `/admin/reports/matomo-reports` (controller `MatomoReportsController`) renders many Matomo widgets — visitors overview/times/locations/variables, actions (pages, entry/exit, site search, outlinks, downloads), events, referrers, goals and transitions — by embedding Matomo's own `Widgetize` iframes for the chosen site, time period or date range (kept in the session). A `MatomoData` helper resolves the server URL (falling back to the `matomo` module's `matomo.settings` if present), fetches the accessible sites (`SitesManager.getSitesWithAtLeastViewAccess`) and goals. A "Matomo page statistics" block (`matomo_page_report`) shows per-page view counts and requires the companion [`matomo`](https://www.drupal.org/project/matomo) module for the tracked `site_id`. Two permissions gate it: "Access Matomo Reports" (view) and "Administer Matomo reports" (configure).

---

- Show visitor overview, times, locations and custom-variable reports to editors without leaving Drupal.
- Give the marketing team an in-admin dashboard of Matomo actions: top pages, entry/exit pages, downloads and outlinks.
- Display referrer reports (search engines, keywords, websites, social, campaigns) inside `/admin/reports`.
- Surface Matomo goal-conversion widgets for the selected site and period.
- Add a "Matomo page statistics" block that shows the current page's view count.
- Configure a single global `token_auth` so all permitted users see the same reports.
- Let each editor supply their own Matomo `token_auth` on their profile for per-user access scoping.
- Restrict which Matomo site IDs users may view via the allowed-sites whitelist (e.g. "1,4,12").
- Point the module at any Matomo base URL, independent of the tracking `matomo` module.
- Reuse the `matomo` module's configured server URL automatically when no reports URL is set.
- Filter reports by Today / Yesterday / Last week / month / year, or an explicit date range.
- Switch between multiple Matomo-tracked sites from a select box (when several are accessible).
- Allow anonymous-token access by setting `token_auth` to `anonymous` for public Matomo sites.
- Work with a self-signed Matomo SSL certificate in dev by enabling "do not verify SSL".
- Embed Matomo's native widget UI (via `Widgetize` iframes) so report styling matches Matomo.
- Provide a "Transitions" report showing how visitors move to/from a page.
- Give site owners quick traffic insight without granting Matomo back-office logins.
- Keep the selected site/period sticky across report pages using the session.
- Audit site-search keywords and no-result searches through the Actions → Site Search report.
- Present campaign performance to a client directly in their Drupal admin.
- Limit report visibility to trusted roles via the "Access Matomo Reports" permission.
- Separate who can view reports from who can change the Matomo connection via two distinct permissions.
