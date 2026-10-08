# LB Section Navigation — manual setup guide

**LB Section Navigation** (`lb_section_navigation`) adds a block to Layout Builder
that displays a list of **anchor (jump) links** to the other components in the
same Layout Builder section. On a long, layout-built page, dropping this block
into a section gives visitors a small in-page table of contents for that
section's components.

It works by adding an `id` attribute to each component in the section (based on
the component's UUID) and then generating a list of links pointing at those
anchors, labelled by each component's title. Because it needs information about
the other components, the block's list is generated when the whole section is
rendered. It is purely a presentation/site-structure feature — it adds no content
of its own and has no effect on which blocks a user may see.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no configuration page** of its own. You place the
section-navigation block from within Layout Builder, described below.

## Where it lives in the admin menu

There is no dedicated settings page (`configure` is null). The section-navigation
block becomes available in the **Layout Builder** "Add block" list.

## How to use it

1. Enable the module.
2. Edit the layout of a Layout Builder–enabled page.
3. In the section whose components you want to link to, **add** the section
   navigation block.
4. Save. On the rendered page, the block shows a list of jump links — one per
   component in that section — so readers can skip straight to the part they
   want.
