# Cool Editor Tabs — manual setup guide

**Cool Editor Tabs** (`cool_editor_tabs`) restyles Drupal's local task tabs — the
**View / Edit / Revisions / Delete / Translate** row that editors use more than
almost anything else on a site — into a cleaner, icon‑based interface. Instead of
a horizontal strip that wraps awkwardly on narrow screens and becomes hard to read
once several modules pile on extra tabs, it shows a toggle button at a fixed
position on the screen; clicking it reveals the tabs as intuitive, icon‑based
buttons.

The problem it solves is quiet but real: on a site with moderation, translation,
layout, and other modules enabled, a single node can carry eight or more tabs, and
finding "Edit" among them costs a moment every time — a cost paid back on every
content operation. Cool Editor Tabs gives the row consistent, legible styling that
looks the same across admin themes.

Its features include Heroicons v2 icons for all the common tabs (Edit, Delete,
Translate, Revisions, Layout, Clone, and more), built‑in icons for popular contrib
modules (Metatag, Pathauto, Redirect, Webform, Scheduler, Simple XML Sitemap,
Content Moderation, Rabbit Hole), and a first‑letter fallback so unknown tabs
still get a recognizable badge rather than a blank circle. It integrates with
Drupal's Icon API, and developers can supply custom icons via
`hook_cool_editor_tabs_icon_alter()`.

Only authenticated users who hold the **`use cool editor tabs`** permission see the
tabs, so the interface stays clean for ordinary visitors. That permission simply
changes the *presentation* for whoever holds it — it grants no capability the user
did not already have. The module works as soon as it is enabled; an optional
settings form lets you tune the tab colors, complete with a live WCAG 2.1 contrast
checker.

> **Note:** this module targets a tight core requirement — **Drupal 11.1 or
> higher** (`^11.1`) — so it will not install on older Drupal.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   grant the permission.
2. [Configuration](configuration/index.md) — the optional color settings and the
   built‑in contrast checker.

## Where it lives in the admin menu

The tab styling is active immediately for users with the permission. Its optional
settings form sits at **Configuration → User interface → Cool Editor Tabs**.
