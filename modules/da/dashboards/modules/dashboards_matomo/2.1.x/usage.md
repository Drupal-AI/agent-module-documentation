<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dashboards matomo adds a set of Dashboards widgets that pull site-analytics reports from a Matomo instance (visits, top URLs, countries, browsers, operating systems) via the Matomo Reporting API.

---

This submodule of Dashboards provides five Dashboard plugins, all in the "Matomo" category and all extending a shared `MatomoBase` (a lazy-build base that formats Matomo date/period responses): `matomo_visit_statistic` ("Visit report."), `matomo_top_urls` ("Top urls."), `matomo_countries` ("Show per country."), `matomo_browser` ("Browser."), and `matomo_os` ("Operating systems."). Each is exposed as a block `dashboards_block:dashboard:<id>` (e.g. `dashboards_block:dashboard:matomo_visit_statistic`) that you place into a dashboard's Layout Builder, and each queries the Matomo Reporting API for the relevant report and renders it as a chart/table. The submodule depends on the contrib `matomo` and `matomo_reporting_api` modules, which must be installed and configured (site id + Matomo URL + auth token) for the widgets to return data. It defines no config entity, settings form, permission, or Drush command of its own — configuration is the Matomo connection (in those modules) plus per-widget placement/settings in Layout Builder.

---

- Show Matomo visit statistics (visits over time) on an admin dashboard.
- Display the top visited URLs from Matomo as a dashboard widget.
- Break down visitors by country with the per-country widget.
- Show which browsers your visitors use (Matomo browser report).
- Show visitor operating systems from Matomo.
- Add any Matomo widget as a block via Layout Builder (`dashboards_block:dashboard:matomo_visit_statistic`, etc.).
- Build a marketing analytics dashboard combining several Matomo widgets.
- Surface Matomo insights inside Drupal without leaving the admin UI.
- Give stakeholders a Matomo overview embedded in a Drupal dashboard.
- Compare traffic sources and audience geography at a glance.
- Monitor visit trends alongside content statistics on one dashboard.
- Place the visits widget next to the top-URLs widget for a traffic snapshot.
- Track audience technology (browser/OS) for front-end support decisions.
- Reuse Matomo widgets across multiple dashboards.
- Group Matomo widgets under the "Matomo" category in the block picker.
- Present analytics to non-technical staff without Matomo logins.
- Combine Matomo geography with content performance widgets.
- Show a country breakdown for a specific campaign period.
- Feed a leadership dashboard with live Matomo visit numbers.
- Centralize Matomo reporting inside the Dashboards module.
