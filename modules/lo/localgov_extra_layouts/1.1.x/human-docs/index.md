# LocalGov Extra Layouts — manual setup guide

**LocalGov Extra Layouts** (`localgov_extra_layouts`) adds a handful of extra section
layouts for use with **Layout Builder**, tailored for the LocalGov Drupal
distribution. Once enabled, these appear alongside Drupal's built-in layouts whenever
an editor adds a section to a page or entity managed by Layout Builder — giving them
more ways to arrange content without any custom theming.

The layouts it currently provides are:

- **2 Column – 33:66** — two columns, the first taking 33% of the width and the
  second 66%.
- **2 Column – 66:33** — two columns, the first taking 66% and the second 33%.
- **2x2** — a grid-like layout with two 50%-width columns, where each column holds two
  stacked regions (so four regions in total).

There is nothing to configure and no admin settings page — enabling the module is all
it takes for the new layouts to become selectable. Because this is part of the
**LocalGov Drupal** distribution, it is designed to sit naturally with the LocalGov
themes and page-building tools, but it works on any site using Layout Builder.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.

There is **no configuration page** for this module — it has no settings form. You use
the layouts directly in the Layout Builder editing flow, described under "How to use
it" below.

## Where it lives in the admin menu

LocalGov Extra Layouts adds no admin settings page of its own (`configure` is
`null`). The new layouts appear inside **Layout Builder** — when you click *Add
section* on any entity or page that uses Layout Builder, you will see the extra
layouts listed among the choices.

## How to use it

1. Make sure Layout Builder is enabled for the content type (or other entity) you want
   to build — under **Structure → Content types → *(type)* → Manage display**, use the
   **Layout options** to enable Layout Builder.
2. Edit a piece of content (or the default layout) with Layout Builder.
3. Click **Add section**. In the list of layouts you will now see **2 Column –
   33:66**, **2 Column – 66:33**, and **2x2** alongside the core layouts.
4. Choose one, add your blocks or fields into its regions, and save.
