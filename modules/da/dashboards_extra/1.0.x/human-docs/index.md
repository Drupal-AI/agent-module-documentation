# Dashboards Extra — manual setup guide

**Dashboards Extra** (`dashboards_extra`) extends the
[Dashboards](https://www.drupal.org/project/dashboards) module by adding more
statistics blocks for richer administrative insight. Its headline addition is a
**multi‑statistics block** that surfaces several site metrics at once on an admin
dashboard.

The extra blocks cover **content statistics** (content types, published/
unpublished status, and recent changes), **block statistics** (block counts across
the site), **media statistics** (media counts), and **user statistics** (user
counts). Together they give administrators an at‑a‑glance operational picture
without adding a new admin section — everything appears as blocks you place on a
dashboard.

It's a pure add‑on: it depends on the **Dashboards** module (which provides the
dashboard framework these blocks are placed into) and has no access‑control role of
its own — each block shows only data the viewer can already access, following
normal permissions. It supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (alongside the Dashboards module).

There is **no settings form** — the module simply provides extra blocks. You place
them on a dashboard through the Dashboards module, described in "How to use it"
below.

## Where it lives in the admin menu

Dashboards Extra adds no admin page of its own. Its blocks become available inside
the **Dashboards** module's dashboards. You add them the same way you add any
dashboard block — through the Dashboards module's dashboard‑editing interface.

## How to use it

1. Make sure the **Dashboards** module is installed and you have a dashboard set up
   (see [Installation](installation/index.md)).
2. Edit a dashboard in the Dashboards module.
3. Add one of Dashboards Extra's blocks — for example the **multi‑statistics**
   block, or the individual content / block / media / user statistics blocks.
4. Save the dashboard. The chosen statistics now appear for administrators viewing
   it (each block respecting the viewer's normal access).
