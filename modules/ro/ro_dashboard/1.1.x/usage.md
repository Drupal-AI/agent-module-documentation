<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
RO Dashboard is the base module for the Multi Site Status Dashboard.

---

RO Dashboard is the **base module for a multi-site status dashboard** — infrastructure for collecting and
displaying status/health across multiple Drupal sites from one dashboard (a central operations view). It
provides its own permissions, in the ro_dashboard package.

Use it as the foundation for a multi-site monitoring dashboard. It is an administration/monitoring feature.
Security note: a status dashboard aggregates operational data across sites, which can be **sensitive
infrastructure information** — gate its permissions to **trusted operators**, and if it exchanges status data
between sites, secure that channel (auth + HTTPS). It has no broad access-control role beyond its permission.
Configure the dashboard.

---

- Provide a multi-site status dashboard base.
- Collect status/health across sites.
- Give a central operations view.
- Provide its own permissions.
- Aggregate operational data.
- Serve multi-site operators.
- Gate permissions to trusted operators.
- Secure inter-site status exchange (auth + HTTPS).
- Treat status data as sensitive.
- Have no broad access-control role.
- Configure the dashboard.
- Handle the dashboard.
- Monitor multiple sites.
- Configure monitoring.
- Show site status.
- Handle multi-site status.
- Aggregate status.
- Provide a dashboard.
- Configure operators.
- Provide site monitoring.
