<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dashboards matomo — agent index

Submodule of [Dashboards](../../../../2.1.x/agent/start.md). Adds **five Dashboard widgets** (category
"Matomo") that pull reports from a Matomo instance via the Matomo Reporting API. Requires the contrib
`matomo` + `matomo_reporting_api` modules (configured with site id / URL / token). No config entity,
settings form, permissions, or Drush of its own.

Widgets (all extend `MatomoBase`; each placed as block `dashboards_block:dashboard:<id>` — see the
parent's [plugins doc](../../../../2.1.x/agent/plugins/dashboard-plugins.md)):

- `matomo_visit_statistic` — "Visit report."
- `matomo_top_urls` — "Top urls."
- `matomo_countries` — "Show per country."
- `matomo_browser` — "Browser."
- `matomo_os` — "Operating systems."

Note: on this documentation site `matomo_reporting_api` is not installed, so the submodule cannot be
enabled and the widgets return no data — but a dashboard config entity can still store these block ids.
