# Content Insights Report — manual setup guide

**Content Insights Report** (`content_insights_report`) turns a content audit —
the job everyone agrees should happen and nobody does — into a page. On a site with
thousands of nodes, answering "what is here, how old is it, who owns it, what has
nobody touched in years, where are the thin pages" by hand is a week of spreadsheet
work. This module reads data the site already holds and produces that report for
you.

The report has a few parts. A **Content Insights Summary** gives a high‑level
percentage breakdown of content by type — your content mix at a glance. A deeper
**Content Insights Report** adds monthly trends of created and updated nodes over a
configurable number of months, and a breakdown by **moderation state** (draft,
pending, published, and so on) to reveal where content gets stuck. A **Content
Report** offers a granular, date‑filtered view for narrowing down to exactly what
you want to look at. An optional submodule integrates with the **Group** module so
you can generate a report per group.

The real value is in what the report prompts, not the numbers themselves: it is the
input to decisions about what to retire, rewrite, or consolidate, so it's worth
running when someone has the authority and time to act on it. This is a
**needs‑config** module — you set it up on its settings form, then read the report
under Reports. It has no dependencies beyond Drupal core (the Group integration is
an optional submodule).

Two practical cautions. Analysing all content is **expensive**, so on a large site
expect it to run as a batch or cron job rather than a page load — check which before
running it on production. And the report necessarily **aggregates content the reader
might not otherwise be able to see**, so on a site with restricted content, deciding
who may view the report is an access decision, not just a convenience.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form and where to read
   the generated report.

## Where it lives in the admin menu

Settings live at **Configuration → Content authoring → Content Insights Report
Settings** (`/admin/config/content/content_insights_report/settings`). The report
itself is at **Reports → Content Insights Report**
(`/admin/reports/content-insights-report`). If you enable the Group submodule, it
adds a **Content Insights Report Group Settings** page
(`/admin/config/content/content_insights_report_group/settings`) and per‑group
reporting.
