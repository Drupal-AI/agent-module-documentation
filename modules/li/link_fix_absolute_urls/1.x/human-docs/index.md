# Link Fix Absolute URLs — manual setup guide

**Link Fix Absolute URLs** (`link_fix_absolute_urls`) is a small content‑hygiene
utility. When an editor pastes a full URL to one of your own pages into a link
field — the kind of address you copy straight from the browser bar — this module
rewrites that same‑site absolute URL into its internal path equivalent before it
is saved. So `https://example.com/about-us` quietly becomes an internal reference
to that page.

Why bother? Hard‑coded absolute URLs are brittle. They break if your domain ever
changes, they behave awkwardly across environments (production versus a staging
or DDEV domain), and they miss out on Drupal's internal link handling. Storing
the internal path instead keeps your links domain‑independent and lets Drupal
resolve them correctly wherever the site runs.

The module only touches links that point at the *current* site — genuinely
external URLs are left alone. There is nothing to configure and no security
surface: you simply enable it, and every link saved from that point on is
normalized. One thing to confirm for your own site is that you have no link
fields deliberately holding an absolute URL to a canonical external mirror of a
page you also host, since those would be candidates for rewriting.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — none is required or
available. Enabling it is the whole setup.

## Where it lives in the admin menu

Link Fix Absolute URLs adds no admin page and no settings form. It works
invisibly the moment it is enabled, converting qualifying absolute URLs as link
fields are saved.

## How to use it

Enable the module. From then on, any link saved to the site that points at the
current site with a full absolute URL is converted to the appropriate internal
path automatically. Existing values are not touched until they are re‑saved, so
this improves your links going forward rather than migrating old content in bulk.
