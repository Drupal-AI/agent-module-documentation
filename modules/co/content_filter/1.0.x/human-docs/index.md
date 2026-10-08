# Content filter — manual setup guide

**Content filter** (`content_filter`) gives each content type its own focused
listing page inside the admin Content area, instead of the single mixed content
overview where every type is jumbled together. On a site with many content types
that default overview gets noisy fast; Content filter lets you spin up a clean,
purpose‑built page per type so editors can go straight to "just the Articles" or
"just the Events".

For every content type you select on its settings form, the module creates a page
at `/admin/content/filtered/{node_type}` that embeds Drupal's own core **Content**
view — with the content‑type filter locked to that one bundle and hidden — so the
page keeps all the familiar filters and actions you already know, but scoped to a
single type. It also injects an **Add {bundle}** button into the page so editors
can create content of that type in one click. A parent index at
`/admin/content/filtered` links to all the filtered pages.

Optionally, the module can add submenu links under the **Content** menu for
quick access to each page; if you leave that off, the pages are still reachable as
sub‑tabs. Content filter creates no new content types and changes none of your
existing content, permissions, or text formats — it only adds these listing pages.

Because it relies on the core Content view, this is a **needs‑config** module: after
enabling it you visit the settings form to pick which types get pages. Its one real
requirement is that the default **Content** view is enabled (it is, on a standard
Drupal site). There are no other dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which content types get their
   own page and whether to add Content menu links.

## Where it lives in the admin menu

The settings form is at **Configuration → User interface → Content filter**
(`/admin/config/user-interface/content-filter`), gated by the **administer
content_filter** permission. The generated pages live under **Content**: the index
at `/admin/content/filtered` and each type at `/admin/content/filtered/{node_type}`.
