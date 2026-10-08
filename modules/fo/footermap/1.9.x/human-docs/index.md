# Footermap — manual setup guide

**Footermap** (`footermap`) provides a configurable **block** that renders an HTML sitemap of
your menus' links — a recursive "quick links" map you typically drop into the page footer.
Point it at one or more menus and it builds a tidy, columnar list of their non‑hidden links at
render time, staying in sync automatically as your menus change.

You place and configure it like any block. Its settings choose which menus to include, an
optional depth limit (so you can show just the top level, or the whole hierarchy), whether to
show each menu's name as a column heading, and — for advanced cases — a specific menu link to
use as the root so the map shows just a sub‑branch. You can place several Footermap blocks with
different menus and depths.

One important design detail: Footermap builds its link list **as an anonymous visitor would see
it**. It only ever shows links a logged‑out user could reach, which keeps the block cacheable
and avoids leaking access‑restricted links into your footer — at the cost of not showing
per‑user links. There is **no global settings page** and no permissions of its own; everything
lives in the block configuration. It depends on core's **Menu UI** module.

This guide is written for a **human** clicking through the admin UI. If you want the block
settings schema and the theme hooks/templates for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.
2. [Configuration](configuration/index.md) — place the Footermap block and set which menus it
   shows, field by field.

## Where it lives in the admin menu

There is no dedicated settings page. Place and configure the block through **Structure → Block
layout** (`/admin/structure/block`) — the block is called **Footermap**, in the **Sitemap**
category. You can put it in the footer (its intended home) or any other region.
