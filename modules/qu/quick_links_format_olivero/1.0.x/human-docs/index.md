# Quick Links Format - Olivero — manual setup guide

**Quick Links Format - Olivero** (`quick_links_format_olivero`) is a small companion
to the [Quick Links](https://www.drupal.org/project/quick_links) recipe. Its job is
purely presentational: it adds **Olivero‑theme formatting** for the quick‑links
block so it looks polished out of the box, and when you are using the Olivero theme
it also **places the quick‑links block at the top of the home page** for you.

Think of it as the "make it look right" layer on top of Quick Links. If you run a
custom theme instead of Olivero, you don't have to enable this module at all — you
can read its code as a reference and add equivalent styling to your own theme.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no settings form** for this module — it applies formatting and (on
Olivero) places the block automatically once enabled.

## How to use it

Install the **Quick Links** recipe/module first, then enable this module. On the
Olivero theme it immediately styles the quick‑links block and places it at the top of
the home page — no configuration needed. On a custom theme, use this module's code as
a reference for adding equivalent formatting rather than enabling it.
