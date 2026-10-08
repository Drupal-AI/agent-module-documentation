# Custom breadcrumbs — manual setup guide

**Custom breadcrumbs** (`custom_breadcrumbs`) lets you define your own breadcrumb
trails and store them as reusable configuration, instead of relying on Drupal's
default breadcrumb. You decide which pages a trail applies to — either by content
type/bundle (e.g. "all Article nodes") or by URL path pattern (e.g. everything under
`/products/*`) — and you spell out each crumb's link and label yourself.

Crumbs can be plain text or built from **Tokens** (like `[node:title]` or
`[term:name]`), so they stay in sync with the content. A few special values give you
extra power: `<front>` links a crumb to the home page, `<nolink>` renders a crumb as
non-clickable text (handy for a section label), and `<term_hierarchy:field_name>`
expands a taxonomy reference field into its full parent-to-child term hierarchy as a
series of crumbs.

A global settings page controls site-wide behavior — whether to prepend a "Home"
crumb, whether to append the current page as the last crumb, trimming long titles,
turning trails off on admin pages, and an optional site-wide mode. Individual trails
are managed as configuration entities under **Structure**, so you can build them in
the UI and deploy them like any other config. The module requires the **Token**
module and works on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and Token) with
   Composer and enable it.
2. [Configuration](configuration/index.md) — the global settings, how to build a
   breadcrumb trail, and the permission that gates it all.

## Where it lives in the admin menu

- The global settings form is at **Configuration → User interface → Custom
  breadcrumbs** (`/admin/config/user-interface/custom-breadcrumbs`).
- The individual breadcrumb trails are managed at **Structure → Custom breadcrumbs**
  (`/admin/structure/custom-breadcrumbs`).

Both are gated by the single *Administer custom breadcrumbs* permission.
