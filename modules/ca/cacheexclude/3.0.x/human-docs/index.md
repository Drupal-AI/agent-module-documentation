# Cache Exclude — manual setup guide

**Cache Exclude** (`cacheexclude`) lets an administrator stop specific pages,
paths, or entire content types from being stored in Drupal's anonymous **page
cache**, so genuinely dynamic content stays dynamic. It solves the familiar
problem where the page cache serves stale output to anonymous visitors on pages
that should change on every request — a rotating banner, a random quote, a live
counter or scoreboard, a countdown, an exchange‑rate ticker, a coupon page whose
value must always be current.

You manage everything from one settings form. There you list the Drupal paths to
exclude (one per line, with `*` wildcards and the `<front>` token) and/or tick the
content types to exclude. On every request the module checks the current path (and
its URL alias) against your list, and the routed node's content type against your
ticked types; when either matches, it fires Drupal's core page‑cache "kill switch"
so **that one response is not written to the anonymous page cache**. The rest of
the site keeps caching normally — the exclusion is surgical, not site‑wide.

The module is light: it requires only core's Path Alias, defines **no permissions
of its own** (the form is gated by the core *Administer site configuration*
permission), and flushes all caches automatically when you save so new rules take
effect right away. It also ships Drupal 7 migration support so a legacy site's
exclusion settings carry forward on upgrade.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form: path list syntax
   and content‑type exclusions.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Cache exclusions**
(`/admin/config/system/cacheexclude`). It requires the core **Administer site
configuration** permission.

## How to use it

Enable the module, open the settings form, add the paths and/or content types you
want to keep out of the page cache, and save (which flushes caches for you). Those
pages will now bypass the anonymous page cache while everything else stays cached.
