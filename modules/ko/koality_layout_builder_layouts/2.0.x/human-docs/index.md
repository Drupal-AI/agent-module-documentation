# Koality Layout Builder Layouts — manual setup guide

**Koality Layout Builder Layouts** (`koality_layout_builder_layouts`) gives
**Layout Builder** a practical set of ready‑made layouts to build pages with, so
you don't have to write custom layout plugins from scratch. It ships **1‑, 2‑, 3‑,
and 4‑column** layouts as a jumping‑off point, each with options you set per
section: the **width**, the **spacing** between columns and above/below the
layout, and **background colours** — either for the layout as a whole or per
column.

It's a pure presentation/site‑building helper. The module registers additional
layout plugins and attaches a small CSS library to style them; it adds **no admin
pages, no entities, and no permissions of its own**. Who may place these sections
is governed entirely by **core Layout Builder's** own access controls, exactly as
for core's built‑in layouts.

Because everything is driven from the Layout Builder UI, there is nothing to
configure globally — you enable the module and the new layouts simply appear in
the layout picker when you add a section.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside core Layout Builder.

There is **no configuration page** for this module — it has no settings form. The
layouts and their options are used directly in the Layout Builder UI, described
under "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. You use its layouts wherever Layout Builder is
active — for example on a content type's **Manage display** (Layout Builder
enabled) or when editing a node's layout.

## How to use it

1. Make sure **Layout Builder** is enabled for the entity/display you want to
   build (for example, at **Structure → Content types → *(type)* → Manage
   display**, enable Layout Builder).
2. Edit the layout and click **Add section**.
3. Pick one of the Koality layouts — **1, 2, 3, or 4 columns**.
4. In the section settings, set the **width**, the **spacing** (between columns and
   above/below the layout), and the **background colour** for the layout or for an
   individual column.
5. Add blocks or fields into the columns as usual and save.

For richer per‑section styling you can combine these layouts with
[Layout Builder Styles](https://www.drupal.org/project/layout_builder_styles), and
add your own CSS on top of the module's base styles.
