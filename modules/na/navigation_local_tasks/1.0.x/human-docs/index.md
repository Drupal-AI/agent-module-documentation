# Navigation Local Tasks — manual setup guide

**Navigation Local Tasks** (`navigation_local_tasks`) brings **local tasks** — the
contextual tabs you normally see on an entity or admin page, such as *View*,
*Edit*, and *Delete* — into Drupal's new **Navigation** toolbar. On the redesigned
Navigation UI those tabs are not shown by default, so this module provides blocks
that surface them there, keeping contextual actions within reach as you work in
the sidebar.

It offers four ways to present the tasks, so you can pick the style that suits
your editors:

- **Action buttons** (marked as a dev/experimental option)
- **Dropdown button**
- **Expandable details**
- **Expandable menu**

An administrator can also choose *which* tasks are displayed. The module depends
on core **Navigation** and requires **Drupal 11.1+**.

**Before you adopt it:** the project is marked **unsupported / obsolete**. Its own
maintainers note it will be deprecated once the corresponding core work lands, so
treat it as a stopgap and keep an eye on the core alternative rather than building
long‑term reliance on it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central configuration page** — you configure each block (including
which tasks it shows and how) where you place it, described in "How to use it".

## How to use it

1. Make sure the core **Navigation** module is enabled (it is a dependency).
2. Enable this module (see [Installation](installation/index.md)).
3. Go to **Structure → Block layout** (`/admin/structure/block`) and place one of
   the module's local‑task blocks into the Navigation toolbar region.
4. In the block's settings, choose the presentation style — **action buttons**,
   **dropdown button**, **expandable details**, or **expandable menu** — and pick
   which local tasks (View, Edit, Delete, and so on) should be displayed.
5. Save, then open an entity or admin page and confirm the local tasks now appear
   in the Navigation toolbar in the style you chose.
