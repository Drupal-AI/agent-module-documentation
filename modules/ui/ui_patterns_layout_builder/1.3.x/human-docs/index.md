# UI Patterns Layout Builder — manual setup guide

**UI Patterns Layout Builder** (`ui_patterns_layout_builder`) lets you use your
**UI Patterns** components as **Layout Builder** section layouts. Each field
("slot") of a pattern becomes a Layout Builder region, so site builders can drag
blocks straight into a component's slots — a card's header and body, a hero's
media and text — using the standard Layout Builder interface, with no custom code.

It's a thin glue module: once enabled, every registered pattern shows up in the
**Add section** layout list (complete with its icon). Drop blocks into the pattern's
named regions and they render inside the matching placeholders of the pattern's
Twig template. Entity context (type, bundle, view mode, and so on) is passed
through to the pattern, and per‑region HTML attributes are made available to the
template. The result is drag‑and‑drop page building on top of a maintained,
branded component library.

There is **no configuration UI, no permissions, and nothing to set up** beyond
enabling it alongside UI Patterns, Layout Builder, and a pattern‑layout discovery
module (such as `ui_patterns_layout`).

> **Version note:** this 1.x release targets the **UI Patterns 1.x** API. If your
> site runs UI Patterns 2.x, verify compatibility before relying on it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside its companion modules.

## Where it lives in the admin menu

The module adds no admin page. Its effect shows up in **Layout Builder**: when you
edit a layout (for example **Structure → Content types → [type] → Manage display →
Manage layout**) and click **Add section**, your UI Patterns components appear as
layout choices.

## How to use it

1. Make sure UI Patterns, Layout Builder, and a pattern‑layout discovery module
   (e.g. `ui_patterns_layout`) are enabled, plus this module — see
   [Installation](installation/index.md).
2. Enable Layout Builder for a display: **Structure → Content types → [type] →
   Manage display**, tick **Use Layout Builder**, and save.
3. Click **Manage layout**, then **Add section**.
4. Pick one of your **patterns** from the layout list (each shows its icon).
5. The pattern's slots appear as regions — click **Add block** in a region to drop
   content into that slot.
6. Save the layout. The blocks you placed render inside the corresponding slots of
   the pattern's template.
