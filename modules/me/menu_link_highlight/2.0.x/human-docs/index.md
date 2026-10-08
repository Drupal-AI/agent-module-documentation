# Menu Link Highlight — manual setup guide

**Menu Link Highlight** (`menu_link_highlight`) adds a simple checkbox to the
menu‑link edit form that flags a link as "highlighted." When ticked, the module
adds a highlight CSS class to that link's `<li>` element, so your theme can style it
differently — the classic use is turning one navigation item into a call‑to‑action
(a "Sign up" or "Contact us" button, for example).

The problem it solves is safety for editors. There are other modules that let you
attach arbitrary classes and attributes to menu items, but that flexibility is easy
for a non‑technical editor to misuse and break the layout. A single, clearly labelled
checkbox is a much cleaner solution: editors decide *which* link stands out, and the
theme decides *how* it looks. The module simply adds the class; the visual styling
comes from your theme's CSS.

It depends on core's **Menu Link Content** module and provides a permission so you
can control who is allowed to toggle the highlight flag. There's no central settings
page — the checkbox lives right on each menu link.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no settings page** for this module. You use it directly on the menu‑link
form, described in "How to use it" below.

## How to use it

1. Go to **People → Permissions** (`/admin/people/permissions`) and grant the
   module's highlight permission to the roles that should be allowed to flag links.
2. Go to **Structure → Menus** (`/admin/structure/menu`), open a menu, and add or
   edit a link.
3. Tick the **highlight** checkbox and save.
4. In your theme's CSS, style the highlight class on the menu item's `<li>` element
   to give it the emphasis you want (colors, a button appearance, and so on).

The checkbox only adds the class — the actual appearance is entirely up to the CSS
you write in your theme.
