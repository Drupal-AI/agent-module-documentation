<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
YASM adds admin statistics dashboards, yearly/monthly/timeline reports and scheduled report emails covering a Drupal site's content, users, files, entities, groups, taxonomies and comments.

---

YASM ("Yet Another Statistics Module") is a read-only reporting suite that lives under Drupal's core reports section (`/admin/reports/yasm`). It builds summary dashboards and drill-down pages (contents, users, files, entities, taxonomies, comments, and — with the Group module — groups), plus per-user "My statistics", a yearly report, a monthly report and an infinite-scroll timeline of monthly created/updated totals. Tabular data is rendered with DataTables 2.x (sortable, searchable, CSV/Excel/PDF export, auto-translated to the site language), and every page is behind its own fine-grained permission (all marked "restrict access"). It can email the yearly and/or monthly report to a configured recipient list on cron, using an HTML mail plugin. Two optional submodules extend it: `yasm_blocks` (placeable count blocks) and `yasm_charts` (renders the dashboard tables as charts via the Charts module). It reads and aggregates existing site data only — there is no content-write surface.

---

- See an at-a-glance summary of everything on a site (nodes, comments, media, files, users, taxonomies, groups, plus config counts like views, roles, blocks, image styles, content types, fields, languages and enabled modules).
- Break down nodes by content type and published vs. unpublished status.
- Break down nodes by language on multilingual sites.
- Chart nodes created and updated month by month.
- Rank the top content creators globally, for a chosen year, or for a chosen month.
- List the last 20 created nodes with author, type and publication status.
- Count webform submissions site-wide and per webform.
- Show node view counts and top-viewed rankings when the core Statistics module is enabled.
- Report users by role, by status (active/blocked) and by email domain.
- Report files by type and by MIME, with total and average disk usage.
- Let each user see their own content, comment, file and group statistics under "My statistics".
- Report group statistics (members, roles, contents, comments, files) across Group 1.x–4.x.
- Filter content, user, file and report pages to a single year.
- Filter reports and the timeline by the groups the current user belongs to.
- Produce a yearly report: cumulative totals per entity/bundle with a diff versus the previous year.
- Produce a monthly report: cumulative totals for the last 12 months with a diff versus the previous month.
- Email the yearly and/or monthly report automatically on cron to a recipient list.
- Send a test/demo report immediately from the settings form before enabling scheduled sends.
- Export any statistics table to CSV, Excel or PDF from the DataTables toolbar.
- Add "entity count per bundle" fields to Views (content types, vocabularies, media types, group types) for REST exports.
- Restrict each dashboard, report and the settings page to specific staff roles via granular permissions.
- Keep aggregate reporting admin-facing while still exposing per-user "My statistics" to authenticated users.
