# Menu UI Asynchronous Widget — manual setup guide

**Menu UI Asynchronous Widget** (`menu_ui_async_widget`) speeds up the node edit
form on sites with very large menus. Normally Drupal builds the full menu‑selection
UI (the "Provide a menu link" section, including the parent selector) every time a
node form loads — and when your menus contain thousands of links, building that
widget can make the form noticeably slow to open.

This module removes that heavy widget from the node form and replaces it with a
simple **button**. The full menu UI only loads — asynchronously, over AJAX — if and
when the editor actually clicks the button to add or edit the node's menu link. In
the scenario the module was built for (two menus of about 1,500 links each), this
cut node‑form load time dramatically.

Whether it helps *you* depends entirely on your menus: if they are large, the
performance win is real; if they are small, you will see little or no gain and will
simply have added an extra click for editors. It depends on core's **Menu UI**
module, works on Drupal 9.2, 10, and 11, and changes nothing about content or
access — it is purely a node‑form performance and UX tweak. There is nothing to
configure; enable it and the async widget takes over.

If large menus are your problem, you may also want to look at the related
[Menu tree](https://www.drupal.org/project/menu_tree),
[Trailless Menu](https://www.drupal.org/project/trailless_menu), and
[Big Menu](https://www.drupal.org/project/big_menu) modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — the module has no settings form. Once enabled,
the asynchronous widget replaces the standard menu widget on node forms
automatically.

## How to use it

After enabling, edit any node. Where the "Provide a menu link" section used to
render the full menu UI, you will now see a button instead. Click it to load the
menu selection UI on demand and add or edit the node's menu link.
