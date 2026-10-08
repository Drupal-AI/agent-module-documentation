# Field group anchors — manual setup guide

**Field group anchors** (`fga`) builds an in‑page navigation index for your
content out of the **field groups** you have already created. Each field group you
opt in gets an HTML anchor, and the module renders an index of links — a small
table of contents — that jumps the reader straight to that section of the page. It
is handy for long content pages where field groups act as visual sections.

You can place that index in two ways: as a **pseudo field** (a "field" you position
on the content type's *Manage display*) or as a **block** you place in your theme's
regions. Which node types use the module, and which placement you want, are chosen
in the module's settings.

The module builds on the [Field Group](https://www.drupal.org/project/field_group)
module (its per‑group IDs are what the anchors are built from). Note two current
limits from the project's own documentation: it works with **nodes only**, and
with the **full** view mode.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Field Group dependency.
2. [Configuration](configuration/index.md) — assign IDs to your field groups and
   choose node types and placement.

## How to use it

The result is an index of anchor links that scroll the visitor to the matching
field group within a node. Build your field groups first (that is where the
anchors come from), then turn on the module for the node types you want and decide
whether the index appears as a pseudo field on the node or as a block. The
step‑by‑step is in [Configuration](configuration/index.md).
