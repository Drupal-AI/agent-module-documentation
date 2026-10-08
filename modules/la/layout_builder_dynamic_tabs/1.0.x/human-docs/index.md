# Layout Builder Dynamic Tabs — manual setup guide

**Layout Builder Dynamic Tabs** (`layout_builder_dynamic_tabs`) adds a new layout
you can use as a **section** inside core's Layout Builder. Each region of this
layout is rendered as a **tab** in a tab set: clicking a tab reveals the content
of its region. Every tab can hold an unlimited number of blocks, and the number of
tabs is unrestricted — the regions are created dynamically from the section's
settings form, so you add exactly as many tabs as you need.

It is a pure‑JavaScript implementation (no jQuery) and the tab set is
keyboard‑accessible. The section's markup and the layout‑builder preview use
separate Twig templates, so you can restyle the tabs entirely through template
overrides. It is a straightforward way to build tabbed interfaces in Layout
Builder without writing custom code, and it has no role in content access — the
tabbed content is authored and rendered through Layout Builder like any other
section.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no global settings form**. You configure each tabbed section
inside the Layout Builder UI, as described below.

## Where it lives in the admin menu

It adds no admin page. The "Dynamic tabs" layout appears in the layout chooser
inside the Layout Builder interface, wherever you build a layout (for example
**Structure → Content types → *(type)* → Manage display → Layout**).

## How to use it

1. Open a Layout Builder layout and **add a new section**, choosing the **Dynamic
   tabs** layout.
2. In the section's settings, **add tabs and give each a label**. Regions are
   created for each tab you add.
3. Save the section, then **place blocks** in each tab's region. A tab switcher
   appears at the top of the section in Layout Builder, and on the rendered page
   visitors can switch between the tabs.

> **Known quirk:** on the Layout Builder editing screen, the selected tab
> currently resets to the first tab after you place a block. This is a cosmetic
> editing inconvenience only and does not affect the rendered page.
