# Dynamic Layouts — manual setup guide

**Dynamic Layouts** (`dynamic_layouts`) lets you **create and manage reusable layouts
through the admin UI**, instead of declaring them in a theme's or module's
`layouts.yml` and deploying code for every new arrangement. You build a layout by
adding rows and columns, setting column widths, adding CSS classes, and naming each
column — all from a friendly interface — and the finished layout becomes available
anywhere Drupal offers layouts: **Display Suite**, **Panels**, and the **core Layout
Builder**.

Drupal's own layout system is code‑first, which is exactly right for a fixed design
system but frustrating when a site builder needs, say, a three‑column variant on a
Friday afternoon. This module adds the UI path. Because the layouts you create are
**configuration entities**, they export with `drush cex` and import with `drush cim`
just like a code‑declared layout — so environments stay in step without a code
release.

A few useful details: you can choose a **frontend library** for the grid — Bootstrap
(v4) or a custom 6/8/12‑column grid — set a list of predefined classes selectable per
column, and give each column a custom name that shows up in Display Suite and Panels.
The module depends only on core **Layout Discovery** and **System**, targets Drupal
10 and 11, and gates its admin pages behind a single **Administer dynamic layouts**
permission.

> **Trade‑off worth knowing:** a layout built in the UI has no template file of its
> own, so anything beyond arranging regions (bespoke markup, wrapper components) still
> needs theme work. And because creating layouts is cheap, it's easy to accumulate a
> catalogue nobody curates — a light governance rule helps.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and (if
   using Bootstrap) the frontend prerequisites.
2. [Configuration](configuration/index.md) — choose the frontend library and build
   your rows, columns, widths, classes, and names.

## Where it lives in the admin menu

The layout manager sits at **Configuration → Dynamic Layouts**
(`/admin/config/dynamic-layouts`), gated by the **Administer dynamic layouts**
permission. Layouts you create there appear automatically as options in Display
Suite, Panels, and Layout Builder sections.
