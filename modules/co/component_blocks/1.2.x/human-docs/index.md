# Component blocks — manual setup guide

**Component blocks** (`component_blocks`) turns a theme's **UI Patterns**
components into placeable Layout Builder blocks whose slots are filled from the
host entity's **fields** — so a design-system component can be dropped into a
layout and wired to real content instead of to values an editor retypes. It
creates one block derivative per UI pattern; the block's configuration form then
lets you pick which entity field feeds each slot (and which formatter renders
it), or supply a fixed string with token support.

UI Patterns declares components with named slots, and Layout Builder places
blocks — bridging the two normally means either a custom block per component or
an inline block where an editor re-enters content that already lives on the
entity. Component blocks supplies the third option: content stays on the entity,
markup stays in the theme's component, and the block just maps one to the other.

One thing is decisive when deciding whether this module fits your site: its
Composer constraint pins **UI Patterns 1.x** (`drupal/ui_patterns ^1.0`). UI
Patterns 2.x is a substantially different architecture aligned with Single
Directory Components, so on a UI Patterns 2 site this bridge does not apply. It
depends on core's **Block** and **Layout Builder** modules plus **UI Patterns**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

There is **no configuration page** for this module — you configure each block
where you place it, in Layout Builder, mapping its slots to entity fields.

## Where it lives in the admin menu

Component blocks adds no settings page. You use it from **Layout Builder** on an
entity's layout: add a block, choose one of the component-derived blocks, then
map each of its slots to a field on the entity (or to a fixed/token string) and
pick the formatter for each mapped field.
