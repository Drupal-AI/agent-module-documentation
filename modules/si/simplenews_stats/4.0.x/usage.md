<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simplenews Stats measures what happens after a Simplenews newsletter is sent: it rewrites the links so clicks can be counted and embeds a tracking image so opens can be counted, then reports the results per newsletter node.

---

The mechanism is the standard email-analytics one, implemented as two public routes plus a request subscriber. When a Simplenews issue is mailed, `hook_mail_alter` (legacy path) or `hook_mailer_post_render` (Symfony Mailer path) hands the message to `SimplenewsStatsMail` / `SimplenewsStatsMailSymfony`, which append an `<img>` pointing at `/simplenews-image?sstc=u{sub}nl{node}` and rewrite each `<a href>`: external links are recorded and pointed at `/simplenews-c/{tag}`, internal links just carry the `sstc` tag. A `KernelEvents::REQUEST` subscriber reads the `sstc` parameter and logs an open; the click route looks the requested destination up against the links harvested from that issue before redirecting. Results land in two content entity types — `simplenews_stats` (per-issue totals: views, clicks, total sent) and `simplenews_stats_item` (one row per event) — each with its own storage, list builder, view builder and Views integration. Reporting is a per-node "Stats" tab (a totals table, a Chart.js line chart, and a "Top links" list), plus the admin collections at `/admin/content/simplenews-stats` and `/admin/content/simplenews-stats-items`. The permission set is granular: `administer simplenews stats` (restricted) is separate from `access simplenews stats overview`, from `access simplenews stats results`, and from `access simplenews stats results editable node`, which lets an author see figures only for newsletters they can edit. There is no settings form — enabling the module turns tracking on. The current release on this branch is `4.0.0-beta3`.

---

- Measure open rates for a Simplenews newsletter.
- Count clicks on links inside a newsletter.
- Compare performance across several mailings.
- Show authors the figures for their own newsletters only.
- Report newsletter results from a per-node tab.
- Identify which articles or links drove the most traffic.
- Justify newsletter frequency with engagement data.
- Track a call-to-action link's clicks separately.
- Restrict analytics administration to a trusted role.
- Keep newsletter statistics inside Drupal.
- Work with either the legacy mail path or Symfony Mailer.
- Give a marketing team a per-mailing dashboard.
- Retain per-event detail rather than only totals.
- Segment reporting by newsletter issue.
- Chart clicks and opens per day for a mailing.
- Filter the raw event log by action, user, or associated newsletter.
- Detect a mailing whose open rate is unusually low.
- Support an editorial review of newsletter content.
- Decide which subject lines perform best.
- Expose the stats entities to custom Views for bespoke reports.
