# Pagedesigner Megadropdown — manual setup guide

**Pagedesigner Megadropdown** (`pagedesigner_megadropdown`) is an add‑on for the
[Pagedesigner](../../../pagedesigner/4.x/human-docs/index.md) drag‑and‑drop page
builder. It adds **mega‑dropdown menus** to your main navigation — the large,
multi‑column dropdown panels you see on big sites — and it lets you build the *content*
of those panels with Pagedesigner. So instead of a plain list of links, a top‑level
menu item can open a rich, designed panel with columns, images and formatted content.

It is a site‑structure / navigation feature. The mega‑menu content is authored through
Pagedesigner and respects Pagedesigner's access model; the module itself has no
access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Pagedesigner.

This add‑on has **no separate configuration page** (its configure route is empty). You
build the mega‑dropdown content with the Pagedesigner editor and attach it to your main
menu. Set up the base [Pagedesigner](../../../pagedesigner/4.x/human-docs/index.md)
module first.

## How to use it

1. Install and enable both Pagedesigner and this module (see
   [Installation](installation/index.md)).
2. For the main‑menu items that should open a mega‑dropdown, build the panel content
   using Pagedesigner.
3. The menu items then render as multi‑column mega‑dropdowns in your main navigation.
