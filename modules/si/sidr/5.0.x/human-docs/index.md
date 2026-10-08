# Sidr — manual setup guide

**Sidr** (`sidr`) gives you the classic off‑canvas / responsive mobile menu — the
panel that slides in from the edge of the screen when you tap a hamburger button.
It does this with configurable **trigger blocks**: you place a block, point it at
the content you want to reveal (usually a menu), and the module wires up the jQuery
Sidr JavaScript library to slide that content in and out on click.

Each trigger block is highly configurable: you choose the source of the panel
content (a jQuery selector on the page, a URL, or a callback), which side it slides
from (left or right), the button's text and/or icon, whether the button toggles /
opens / closes, and animation speed and timing. A small global settings form adds a
visual theme choice and two convenience behaviors (close on Escape, close when you
click outside). You can place several independent triggers — say a left menu and a
right cart drawer — each as its own block.

One important caveat: Sidr integrates the jQuery Sidr library but does **not** bundle
it. You must install that third‑party JavaScript/CSS separately (into
`libraries/jquery.sidr`) before the slide behavior will work — the module only
provides the Drupal glue. It has no dependencies beyond core and ships no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, install
   the required jQuery Sidr library, and enable the module.
2. [Configuration](configuration/index.md) — the global settings form and the
   per‑block trigger options, field by field.

## Where it lives in the admin menu

The global settings form is at **Configuration → User interface → Sidr**
(`/admin/config/user-interface/sidr`). You place and configure trigger blocks under
**Structure → Block layout** (`/admin/structure/block`), where the block is called
**Sidr trigger button block**.

## How to use it

At a glance: install the jQuery Sidr library, place a **Sidr trigger button block**
in a theme region, set its source (e.g. a selector for your main menu) and side,
give it a hamburger icon or label, and save. Tapping the button slides your menu in.
The full walkthrough is in [Configuration](configuration/index.md).
