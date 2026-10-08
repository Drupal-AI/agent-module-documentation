# Basic Layouts — manual setup guide

**Basic Layouts** (`basic_layouts`) adds a small set of extra layout options for
use with **Layout Builder** (and anywhere else Drupal layouts are used). Core
ships only a few layouts; this module fills in the common arrangements people
usually reach for — simple one‑, two‑ and three‑column sections and the like — so
you have more choices when you build a page.

It is deliberately minimal. It provides layout plugins and depends only on core's
**Layout Discovery** module. The actual content you drop into these layouts still
comes from your blocks and fields, and it is displayed under their own access
rules — Basic Layouts has no access‑control role of its own; it only supplies the
column/section shapes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — where the layouts show up and the
   module's settings form.

## Where it lives in the admin menu

There is nothing to click to "turn on" the layouts — once the module is enabled,
its layouts appear in the layout picker wherever Layout Builder (or another
layout‑aware feature) lets you choose a section layout. The module also registers
a small settings form; see [Configuration](configuration/index.md).
