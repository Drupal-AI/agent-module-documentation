# Custom Add Content — manual setup guide

**Custom Add Content** (`custom_add_content`) turns the `/node/add` page into a
**configurable menu** named *Custom add content page*. Core lists content types
alphabetically with their descriptions, and on a site with two dozen types that's
a wall — the three types editors create regularly are mixed in with twenty others
meant for a migration or a specific team. Making the list a menu lets you order it
by what people actually create, group it by team or purpose, hide what's not for
general use, and write descriptions that say *when* to use each type.

When a content type is created or deleted, the menu updates automatically, so it
stays in sync. You can also have unlinkable menu entries (useful as group
headings), and choose which menu renderer to use — Drupal's core renderer or the
module's own custom renderer (the default).

One distinction is worth stating plainly: **ordering a menu is presentation, not
permission**. Removing a type from the menu does not stop anyone creating it —
`/node/add/type` still works for whoever holds the permission. If a role genuinely
should not create a type, that's a permission change; this module's tidier list is
a usability layer on top, not a substitute for it.

The module has no dependencies and works on Drupal 10 and 11. It pairs well with
*Special Menu Items* and *Menu Item Visibility* if you want unlinkable headers or
per‑item visibility.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

Configuration is done by editing the generated menu (and choosing a renderer),
described in "How to use it" below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). It creates a
   menu called **Custom add content page**, pre‑populated with a link per content
   type.
2. Go to **Structure → Menus** (`/admin/structure/menu`) and edit the **Custom
   add content page** menu. Here you can:
   - **reorder** the links so the most‑used types come first;
   - **build a hierarchy** and group links (optionally with unlinkable entries as
     headings);
   - **hide** links you don't want on the add‑content page;
   - **rewrite descriptions** to explain when to use each type.
3. On the module's own administration page, choose the **menu renderer**: Drupal's
   core renderer, or the module's custom renderer (the default).
4. Visit `/node/add` to see the customized, menu‑driven page.

Remember: hiding a link here is a usability choice, not a security control — use
Drupal's permissions if a role truly must not create a given type.
