# Content Reporting — manual setup guide

**Content Reporting** (`content_reporting`) produces reports about a site's *own
content* — how much there is, of what types, by whom, and how it has changed over
time. The distinction from web analytics is the useful one: analytics tells you
what visitors *did*; content reporting tells you what you *have*. That's the
question nobody can answer on a site past a few thousand nodes, and the one that
comes up whenever something has to be decided about the content as a whole — how
many pages exist, how many haven't been touched in three years, which content
types are actually used, who is still producing content and who has stopped, how
many nodes lack an image, a summary, or a taxonomy term. It's the input to a
content audit, a migration scope, a redesign's information architecture, and a
retirement programme.

The module tracks page views, time spent on a page, interactions, and GDPR
consents, storing the data in custom tables and surfacing it through admin
dashboards. A lightweight background JavaScript sends updates without slowing the
site, and updates are batched through Drupal's queue engine to keep database load
down — it's designed to keep working even behind caching layers like CloudFront.
Notably, it collects **no** IP addresses, emails, or user IDs, keeping visitor
data anonymous. An optional **Content Reporting Charts** submodule
(`content_reporting_charts`) adds visual line/bar/pie charts via the Charts
module. It depends on core's **Node** and **Views** modules and supports Drupal 9,
10, and 11.

Two things are worth keeping in mind. First, **counting content is a query problem
at the scale where the answer matters** — several aggregates over tens of
thousands of nodes is a slow page at best, so on a large site plan for these
reports to run on a schedule with the result stored rather than computed live; the
naive path is fine on a development site and can time out on production. Second, a
content report is a report **about people as well as content**: "who has stopped
producing" is a performance statistic about named individuals, so decide
deliberately who may see the reports rather than exposing them to everyone.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note:** This is a beta release (1.1.0-beta23) — the high beta number suggests a
> long stabilisation — and the project is not covered by Drupal's security
> advisory policy. Evaluate it, and test its performance, before relying on it in
> production.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and add the optional charts submodule.

Configuration and dashboards live under the **Reports** section of the admin area
(see below); there is no separate settings walkthrough in this guide.

## Where it lives in the admin menu

After installation you'll find a new configuration/dashboard area under the
**Reports** section of the Drupal administration menu. From there you access the
content-reporting dashboards, and — with the charts submodule enabled — the visual
reports.

## How to use it

1. Enable the module (and optionally the charts submodule — see
   [Installation](installation/index.md)).
2. Open the Content Reporting area under **Reports** in the admin menu, where the
   dashboards display views, time spent, interactions, and GDPR consents per piece
   of content, filterable by time period.
3. Decide **who** should have access to the Reports section — remember the reports
   include editorial-output figures about named authors.
4. On a large site, review performance and prefer running/aggregating the reports
   on a schedule rather than computing them live on each view.
