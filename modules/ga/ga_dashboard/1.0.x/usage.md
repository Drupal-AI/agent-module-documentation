<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google Analytics dashboard adds an admin dashboard page that embeds several Google Analytics report views (sessions, pageviews, top pages, top cities, site speed, top sources) rendered as charts.

---

The single controller at /admin/ga-dashboard calls views_embed_view() for the 'ga_reports_page' view's display IDs and stacks the results into one page. It depends on the charts, charts_google, and google_analytics_reports modules, which supply the data source, the GA authentication/reporting, and the chart rendering; this module is essentially a curated dashboard layout over those views. There are no settings, entities, or permissions of its own. Note the route is gated only by 'access content', so the dashboard page itself is reachable broadly (the embedded views still apply their own access) — restrict the underlying views or place the page behind stronger access if the analytics data is sensitive. Use it to give stakeholders a quick at-a-glance analytics view inside Drupal.

---

- Give admins an in-Drupal Google Analytics overview page.
- Show sessions and pageviews as a chart on a dashboard.
- Display top pages and top traffic sources together.
- Surface top cities of your audience.
- Track site speed metrics alongside traffic.
- Avoid switching to the GA web UI for a quick glance.
- Provide stakeholders a curated analytics summary.
- Combine several GA report views on one screen.
- Reuse google_analytics_reports data via embedded views.
- Render analytics with the Charts/Google Charts library.
- Add an analytics tab to an internal admin section.
- Present marketing KPIs to editors inside the CMS.
- Bootstrap a reporting page without building views by hand.
- Show trends without granting GA console access.
- Embed the same GA views elsewhere via the underlying view.
- Offer a lightweight analytics landing page for the team.
