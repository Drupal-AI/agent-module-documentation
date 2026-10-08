# Exclude Node Title — manual setup guide

**Exclude Node Title** (`exclude_node_title`) hides the big title (the `<h1>` page
title) on content, without ever deleting the title itself. The title value stays
safely in place — it just stops appearing in the rendered output. That is exactly
what you want for landing pages, hero sections where the headline is baked into an
image, "card" or "tile" teasers where a repeated heading would be redundant, and
similar designs where the automatic title gets in the way.

You choose *where* the title is hidden with a good amount of precision. On a single
admin form you set, per content type, whether to hide the title on **none** of its
nodes, **all** of them, or let editors decide **per node**. You also pick which
**view modes** the hiding applies to — for example hide it on the teaser but keep
it on the full page. When you choose the per‑node option, editors get an "Exclude
title from display" checkbox on the node edit form (gated by their own
permissions).

There is also a site‑wide choice about *how* the title disappears: either remove
the text from the markup entirely, or keep the markup and add a `visually-hidden`
class so the title is still present for screen readers and search engines but not
seen on screen. The module works with the core Page Title block and node
templates, can optionally strip titles from core Search results, and includes a
Display Suite field override so DS‑built displays honour the same settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, per content type
   and view mode, plus the per‑node checkbox.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → Exclude Node Title**
(`/admin/config/content/exclude-node-title`). When a content type is set to the
per‑node mode, the per‑node control appears as a checkbox on the node edit form
itself.

## How to use it

1. Enable the module and grant the permissions you need (see
   [Installation](installation/index.md)).
2. On the settings form, set each content type to hide its title on none, all, or
   user‑defined nodes, and tick the view modes it should apply to.
3. If you chose the per‑node mode, edit a node and use the "Exclude title from
   display" checkbox to hide that node's title.
