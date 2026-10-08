# CSS/JS Aggregate Retention — manual setup guide

**CSS/JS Aggregate Retention** (`css_js_agg_retention`) solves a specific,
annoying problem introduced by Drupal 10.1. As part of the move to lazy generation
of aggregated CSS/JS, Drupal 10.1 changed cache‑clearing so that a rebuild
(`drush cr`) **deletes the entire** `/sites/*/files/css` and
`/sites/*/files/js` directories. On dynamic sites that regenerate aggregates
on demand this is fine — but on **static generators** and heavily cached/CDN‑fronted
sites it means pages already cached against an old aggregate suddenly point at
files that no longer exist, producing **404s** for missing CSS and JavaScript and
broken styling after every deploy or cache rebuild.

This module restores the pre‑10.1 behavior. It **prevents the wholesale deletion**
of the CSS/JS aggregate directories during cache clears and reinstates
**time‑based garbage collection** that removes only genuinely stale aggregate
files after a retention window, rather than everything at once. The net effect is
that recently referenced aggregates stay on disk long enough for cached pages to
keep loading them.

It is a performance/operations feature that affects only the assets directory —
it has no content, editorial, or access‑control role. It requires no other modules
and supports Drupal 10.2 and 11. This is an alpha release, so test it against your
deployment workflow before depending on it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no admin settings page** for this module. It changes cache‑clear
behavior as soon as it is enabled; the retention window that governs how long old
aggregates are kept is a module setting rather than a form you fill in through the
UI.

## Where it lives in the admin menu

CSS/JS Aggregate Retention adds no admin page. It works behind the scenes by
altering how CSS/JS aggregate files are cleaned up during cache rebuilds.

## How to use it

For most sites there is nothing to do beyond enabling the module — the moment it
is on, cache rebuilds stop wiping the aggregate directories and instead prune only
stale files after the retention window. If you deploy with a static generator or
sit behind a CDN, this is exactly the behavior you want after each build.
