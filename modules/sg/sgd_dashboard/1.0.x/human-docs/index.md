# Site Guardian Dashboard — manual setup guide

**Site Guardian Dashboard** (`sgd_dashboard`) provides the core dashboard for Site
Guardian — an admin-facing, Views-driven screen that displays information gathered
from multiple monitored sites via the companion **Site Guardian Dashboard API**
module. It's designed to run on a dedicated administrative site that watches your
other sites, though nothing stops you installing it elsewhere.

You model the things you're monitoring as content: you add a **client** node and then
a **website** node under it, configure each website with the details of the site you
want to watch (including that site's Site Guardian API key), and the dashboard then
pulls in and surfaces each site's status. There's a companion **Site Guardian PDF
Report** module that integrates with this one to produce a PDF status report for a
monitored site.

The module depends on core **Views** and **Taxonomy**, and — because the dashboard is
built from Views with exposed filters — also on **Twig Tweak**, **Ultimate Cron**,
**Better Exposed Filters** and **Entityreference Filter**; Composer pulls these in for
you. It provides its own permissions. Since the dashboard surfaces operational data
about your sites, gate it to trusted administrators. Supports Drupal 10 and 11. Note
that this project is not covered by Drupal's security advisory policy.

This guide is written for a **human** setting the module up through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is no single settings form — you set it up by creating content and visiting the
dashboard:

1. Add a **client** node.
2. Add a **website** node (under the client) and configure it with the details of the
   site you want to monitor. You'll need the **Site Guardian API key** from that
   monitored site (provided by the Site Guardian API module running there).
3. Open the **Site Guardian Dashboard** — it's linked from the admin menu.
4. Refresh the website entry, and its information should appear on the dashboard.

Make sure only trusted admin roles can reach the dashboard, since it aggregates
operational information about the sites you monitor.
