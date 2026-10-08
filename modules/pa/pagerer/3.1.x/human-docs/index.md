# Pagerer — manual setup guide

**Pagerer** (`pagerer`) gives you a collection of configurable pager styles that
can replace Drupal's plain core pager — either **site‑wide** or **per View** —
built from reusable "preset" configurations. Instead of the same numbered pager
everywhere, you can show "Items 1–10 of 240" ranges, compact "Page X of Y" mini
pagers, jump‑ahead links to distant pages, or a rich three‑pane pager that
combines several of these.

The heart of Pagerer is the **preset**. Each preset is a three‑pane pager — a
**left**, **center** and **right** area — and you drop a **style** into each pane.
The built‑in styles are `standard` (like core's pager), `basic` (like Views' mini
pager), `progressive` (links that jump to progressively more distant pages, e.g.
+10/+20/+100), `adaptive` (smart, context‑sensitive links), and `multipane` (a
composite that combines the others). You build as many presets as you like and
reuse them across the site.

Once you have a preset, you can make it the **site‑wide replacement** for the core
pager, or choose it **per View** through Pagerer's Views pager plugin. Pagerer can
also tidy up pager URLs — renaming the `page` query key to something like `pg`,
starting page numbers at 1 instead of 0, and adjusting the querystring encoding.
Because it reuses core's pager markup and theme classes, your existing CSS keeps
working, and AJAX‑enabled Views pagers keep working too.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the
`@PagererStyle` plugin type and the developer rendering API — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and (optionally) the example submodule.
2. [Configuration](configuration/index.md) — building presets, replacing the core
   pager, URL querystring settings, and using a preset as a Views pager.

## Where it lives in the admin menu

The pager preset list is at **Configuration → User interface → Pagerer**
(`/admin/config/user-interface/pagerer`). It is gated by the standard
**Administer site configuration** permission — Pagerer adds no permission of its
own.

## How to use it

The typical flow:

1. Enable the module.
2. Create a **preset** at `/admin/config/user-interface/pagerer`, choosing a style
   for the left, center and right panes.
3. Either set that preset as the **site‑wide** pager override, or select it as the
   pager on individual Views.
4. Optionally adjust the URL querystring settings for friendlier page links.

See [Configuration](configuration/index.md) for each step in detail.
