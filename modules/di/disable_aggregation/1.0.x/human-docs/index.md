# Disable Aggregation — manual setup guide

**Disable Aggregation** (`disable_aggregation`) turns off Drupal's CSS and
JavaScript aggregation **for authenticated users only**, while anonymous visitors
keep the aggregated, cached assets that make the public site fast. In other words,
logged-in developers and editors see the individual, un-combined asset files —
which makes front-end debugging much easier — and the public never pays a
performance cost for it.

The problem it solves is a familiar one: with aggregation enabled, some
authenticated users hit JavaScript errors while editing nodes that are caused by
the way files get combined. Serving un-aggregated assets to logged-in users makes
those errors go away and lets you inspect exactly which file a script or style came
from. It is a developer/operations convenience with **no content or access-control
role** — it changes nothing a visitor can see or do, only how assets are delivered.

The module works the moment you enable it: there is nothing to configure, and no
settings page. It supports a very wide range of core versions (Drupal 8 through 12).

One thing worth noting: the project is **not covered by Drupal's security advisory
policy**, and it is a developer/debugging aid rather than a production feature, so
consider whether you want it enabled on a live site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it has no settings form. Once
enabled, it applies automatically: authenticated users get un-aggregated assets,
anonymous users keep aggregation.

## How to use it

Enable the module while you are debugging front-end issues as a logged-in user.
Reload the page and check the page source or your browser's network panel — CSS and
JS should now appear as many individual files rather than a few combined bundles.
When you're finished debugging, you can uninstall it to return authenticated users
to normal aggregated delivery.
