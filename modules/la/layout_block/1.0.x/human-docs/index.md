# Layout Block — manual setup guide

**Layout Block** (`layout_block`) ties a **block content type** to a **layout**.
Instead of building a custom form in code to configure a structured, multi‑region
block, you let a `block_content` bundle use a configured layout (a Layout Builder
section) as its own internal structure — so you can build reusable, multi‑region
blocks and fill them with content through the normal block editing flow.

Be aware up front that this is a **developer‑oriented** module, not a
click‑together feature. Its own documentation is clear that it "will require some
basic programming in a custom module to get it working": it relies on **custom
typed entity classes** for the block types you create, and after installation you
must switch the Layout Builder widget to **"Layout Builder Asymmetric Translation
(layout_block support)"**. Only that widget is supported today — support for
Drupal core's stock Layout Builder widget is untested and unknown. The bundled
`README.txt` in the module is the authoritative starting point.

Block content created this way follows normal block access; the module adds no
access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer and enable it.

This module has no standalone settings form of its own — the layout is configured
against a block type in the site‑building UI, and getting it working requires the
custom‑code steps below. See "How to use it".

## Where it lives in the admin menu

Layout Block adds no dedicated admin settings page. You work with it against your
**custom block types** (`/admin/structure/block-content`) and through the Layout
Builder / block editing flow, backed by a small custom module you write.

## How to use it

1. Install and enable the module and its dependencies (see
   [Installation](installation/index.md)).
2. **Read the module's bundled `README.txt`** — it is the canonical, step‑by‑step
   guide and the setup genuinely depends on it.
3. Switch the Layout Builder widget to **"Layout Builder Asymmetric Translation
   (layout_block support)"** — this is the only supported widget.
4. In a **custom module**, define the typed entity classes for the block types you
   want to back with a layout, as described in the README. This programming step
   is required; the module does not provide a no‑code path.
5. Configure the layout on your block type, then place and fill the resulting
   layout‑backed block through the normal block editing flow.
