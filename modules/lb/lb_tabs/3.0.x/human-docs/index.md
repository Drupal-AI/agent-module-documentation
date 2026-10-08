# Tabs And Accordion Layout — manual setup guide

**Tabs And Accordion Layout** (`lb_tabs`) supplies two Drupal layouts — a
**tabbed** one and an **accordion** one — so a Layout Builder section can present
its blocks as tabs or collapsible panels instead of stacking them in a column.
The layouts core ships are all spatial (one column, two columns, three); tabs and
accordions are *interactive* arrangements, where the same regions are revealed one
at a time.

These are among the most requested editorial patterns — FAQ pages, specification
sheets, product detail pages, and long policy content all benefit from grouping
blocks into tabs or collapsing them into an accordion. You get the effect without
writing custom templates or JavaScript: just choose the layout when you add a
section and place blocks into its regions.

Two things are worth knowing. The layouts depend on the contributed
**`jquery_ui_tabs`** and **`jquery_ui_accordion`** modules, which carry the jQuery
UI components Drupal removed from core after Drupal 9 — jQuery UI is in long-term
maintenance rather than active development. And the **accessibility of these
patterns is inherited from those components**, not provided by this module: tabs
and accordions live or die on keyboard operation, focus management, and ARIA
state, so test them (especially with a screen reader) rather than assuming. On a
site with strict accessibility obligations, a modern alternative built on
`<details>` may be preferable. This module is **minimally maintained**
(maintenance fixes only).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its jQuery UI dependencies.

This module has **no configuration page** of its own. You choose the tabs or
accordion layout from within Layout Builder, described below; tab/panel labels are
set from the layout's own settings when you configure the section.

## Where it lives in the admin menu

There is no dedicated settings page (`configure` is null). The tabs and accordion
layouts appear as layout choices inside **Layout Builder**.

## How to use it

1. Enable the module (its jQuery UI dependencies come with it).
2. Edit the layout of a Layout Builder–enabled entity or view display.
3. When you **add a section**, choose the **Tabs** or **Accordion** layout.
4. Configure the section's settings (for example the tab/panel labels) and place a
   block into each region — each region becomes a tab or an accordion panel.
5. Save. On the rendered page, the blocks are revealed one at a time as tabs or
   collapsible panels.
