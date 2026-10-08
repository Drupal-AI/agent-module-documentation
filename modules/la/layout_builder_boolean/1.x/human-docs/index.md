# Layout Builder Boolean — manual setup guide

**Layout Builder Boolean** (`layout_builder_boolean`) extends core's Layout
Builder with *conditional* layouts. It lets you configure True/False versions of
a Layout Builder section: you nominate a field on the entity to act as the
"switch", and depending on whether that boolean is on or off, either the section's
**True** regions or its **False** regions render.

It works by way of a deriver that automatically generates a "Boolean" variant of
every Layout plugin installed on your site. It does not alter the existing layouts
— the boolean versions are entirely new plugins that appear alongside the
originals when you choose a layout for a section.

The module is most useful for **site building** — configuring entity displays for
content types that have optional fields — rather than for one-off content
authoring. A classic example: an article with an optional "Related articles"
reference field. If the author picks related articles by hand, show them; if they
leave the field empty, fall back to a View of related articles instead. Layout
Builder Boolean lets you build both outcomes into a single display.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no settings form of its own**. You configure everything from
inside the Layout Builder UI, on a section, as described below.

## Where it lives in the admin menu

Layout Builder Boolean adds no admin page. Its layouts appear inside the Layout
Builder interface wherever you build a layout — typically **Structure → Content
types → *(type)* → Manage display**, then the **Layout** tab (or a per‑entity
layout override).

## How to use it

1. Enable Layout Builder for the entity display you want to work with, then open
   its **Layout** tab.
2. **Add a section** and, in the layout chooser, pick one of the new **Boolean**
   variants (for example "Two column (Boolean)"). Each boolean layout offers a
   True set of regions and a False set of regions.
3. In the section's settings, **configure the switch field** — choose which
   boolean field on the entity decides which set of regions renders.
4. **Add blocks to the True and False regions**. When the entity is displayed,
   only the regions matching the switch field's value are rendered.

> **Good companions:** because the deriver can generate a lot of extra layout
> plugins, pairing this with
> [Layout Builder Restrictions](https://www.drupal.org/project/layout_builder_restrictions)
> keeps the layout chooser manageable. It also plays nicely with
> [Layout Builder Styles](https://www.drupal.org/project/layout_builder_styles).

> **Note on visibility vs. access:** the switch controls whether a section
> *renders*, not who may see its content. Back any sensitive content with real
> access control rather than relying on the boolean condition.
