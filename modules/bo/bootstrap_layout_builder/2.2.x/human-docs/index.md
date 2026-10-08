# Bootstrap Layout Builder — manual setup guide

**Bootstrap Layout Builder** (BLB, `bootstrap_layout_builder`) adds **Bootstrap
grid rows and columns** to Drupal's core Layout Builder as section layouts. With
it, editors build responsive, multi‑column sections — and style them — without
writing any CSS. It's the Bootstrap‑native way to give content creators a real
page builder.

When enabled, BLB adds a family of "Bootstrap" section layouts (from one column
up to twelve) that appear in Layout Builder's **Add section** list. Each Bootstrap
section renders a Bootstrap `row` with the chosen number of column regions,
wrapped in an optional boxed `container`, full‑width `container-fluid`, or
edge‑to‑edge wrapper. Configuring a section opens a tidy tabbed form:

- **Layout** — choose the column structure **per breakpoint** (Mobile, Tablet,
  Desktop), so a section can stack on mobile and split into columns on desktop;
  pick the container type; and toggle Bootstrap gutters on or off.
- **Style** — this tab embeds the [Bootstrap Styles](../../bootstrap_styles/1.2.x/human-docs/index.md)
  engine, so you can apply a background color, image, or video, spacing, and more
  to the section's container wrapper.
- **Settings** — advanced free‑text CSS classes and YAML attributes for the row,
  columns, and container (this tab can be hidden from editors).

Under the hood, the available breakpoints, column counts, and column splits are
all **configuration entities** you can manage and extend — for example a custom XL
breakpoint, a six‑column layout, or a `4 4 4` split — and everything exports as
configuration so it deploys cleanly across environments. BLB depends on core
**Layout Builder** for the layout system and on the **Bootstrap Styles** module
for the styling engine.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — enabling BLB on a view mode, the
   per‑section UI, the global settings form, and managing breakpoints, layouts,
   and layout options.

## Where it lives in the admin menu

The configuration entities and settings live under **Configuration → Content →
Bootstrap Layout Builder** (`/admin/config/bootstrap-layout-builder`), landing on
the breakpoints list. Everything there is gated by the **Configure bootstrap
layout builder** permission.

## How to use it

1. Install and enable BLB (it pulls in Layout Builder and Bootstrap Styles).
2. Enable **Layout Builder** for a content type's view mode (Structure → Content
   types → *(type)* → Manage display → Layout options).
3. Click **Manage layout**, then **Add section**, and choose a **Bootstrap**
   layout such as "Bootstrap 2 Cols" or "Bootstrap 3 Cols".
4. Use the section's **Layout / Style / Settings** tabs to set the responsive
   column structure, container type, gutters, background styling, and any custom
   classes.
