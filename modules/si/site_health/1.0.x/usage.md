<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Site Health monitors database queries and displays diagnostics.

---

Site Health **monitors database queries and displays performance/health diagnostics** — surfacing slow/
heavy queries and health metrics to help diagnose performance issues, by miniOrange. It depends on core System,
provides its own permissions.

Use it to diagnose performance. It is a developer/monitoring tool. Security/operational note: query monitoring
can surface **query text (potentially with data)** and adds overhead — gate its reports by its permission (keep
to developers/admins), and prefer it on dev/staging (don't leave heavy monitoring on production). It has no
content or access role beyond its permission. Configure the monitoring.

---

- Monitor database queries.
- Show performance/health diagnostics.
- Surface slow/heavy queries.
- Depend on core System.
- Provide its own permissions.
- Serve monitoring.
- KNOW query text may include data.
- Gate the reports by permission.
- Prefer dev/staging (overhead).
- Have no content/access role beyond permission.
- Configure the monitoring.
- Handle site health.
- Monitor queries.
- Configure the diagnostics.
- Show metrics.
- Handle the monitoring.
- Diagnose performance.
- Track queries.
- Restrict the reports.
- Provide health monitoring.
