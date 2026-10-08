# Quick Tabs — manual setup guide

**Quick Tabs** (`quicktabs`) lets you build a block of tabbed (or accordion)
content without writing any code. Each tab in the set pulls in a piece of content —
a node, a block, a View, or even another Quick Tabs set — and visitors switch
between them by clicking the tabs. It is a site-builder tool: you assemble the tab
set in the admin UI, save it, and it becomes a block you can place in any region.

You create and name tab sets at **Structure → Quick Tabs**. Each set is stored as a
`quicktabs_instance` configuration entity, which means it is exportable and can live
in version control alongside the rest of your site's config. For every tab you pick
a *tab type* (what content it loads) and for the whole set you pick a *renderer*
(how it looks). The base module ships the classic horizontal-tabs renderer, and two
optional submodules add a jQuery UI accordion and jQuery UI tabs.

Beyond the basics, a tab set can load each tab's content over AJAX for a faster
first paint, remember the tab a visitor last clicked, hide tabs that render empty,
let visitors deep-link straight to a particular open tab, and be styled with one of
several shipped CSS themes. Developers can go further by adding new content sources
or presentation styles through the module's two plugin types.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick the optional accordion / jQuery UI submodules.
2. [Configuration](configuration/index.md) — build a tab set field by field: the
   tabs, tab types, renderer options, and how to place the resulting block.

## Where it lives in the admin menu

Tab sets are managed at **Structure → Quick Tabs**
(`/admin/structure/quicktabs`). The whole admin UI is gated by the **Administer
quicktabs** (`administer quicktabs`) permission. Once you save a tab set, its block
appears on the **Block layout** page (`/admin/structure/block`) under the "QuickTabs"
category, ready to place.

## How to use it

1. Go to **Structure → Quick Tabs** and click **Add**.
2. Give the set a label, choose a renderer, add tabs, and pick a content type and
   source for each tab.
3. Save. Then go to **Block layout** and place the new Quick Tabs block into a
   region.

> **Security note:** when a tab loads a node over AJAX, that node is returned using
> its configured display. Node access is respected, but individual field visibility
> is not filtered separately — control which fields show up on the content type's
> **Manage display** settings rather than relying on the tab to hide them.
