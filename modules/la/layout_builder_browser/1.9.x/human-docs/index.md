# Layout Builder Browser — manual setup guide

**Layout Builder Browser** (`layout_builder_browser`) replaces Layout Builder's
default "Choose a block" list with a **curated, searchable browser**. Instead of
showing editors every block plugin on the site — a long, technical list grouped
by which module provides it — you decide exactly which blocks they may place,
arrange them into named categories that make sense to your team ("Hero", "Media",
"Promotions"), and optionally give each one a preview thumbnail so editors pick
components visually.

The result is a component picker rather than a raw block list. A block that you
haven't added to the browser simply never appears, so this is also how you
*restrict* what editors can drop into a layout — low‑level field blocks and
administrative blocks stay hidden unless you deliberately expose them.

The curated palette is built from two kinds of configuration: **categories**
(each with a label, a sort weight, an open/collapsed default, and an optional
shared preview image) and **browser blocks** (each pointing at one block plugin,
placed in a category, with an optional custom label and its own preview image).
Because these are configuration, you can export the whole palette and ship the
same editorial choices to every environment. There's also a setting to
auto‑list every reusable custom block of a chosen type, and an option to show the
browser in a centred modal instead of the narrow off‑canvas tray.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Layout Builder.
2. [Configuration](configuration/index.md) — build the categories and block list,
   choose which layout screens use the browser, and switch on the modal or
   auto‑added reusable blocks.

## Where it lives in the admin menu

All administration is at **Configuration → Content authoring → Layout Builder
Browser** (`/admin/config/content/layout-builder-browser`), which has three tabs:
**Blocks**, **Block categories**, and **Settings**. Access is gated by core's
**Administer site configuration** permission — the module defines no permissions
of its own.

## How to use it

1. Enable the module (Layout Builder must be on too).
2. Create one or more **categories**, then add **browser blocks** to them.
3. In **Settings**, make sure the browser is switched on for the layout screens
   you want (by default it takes over per‑entity overrides only).
4. Open Layout Builder on a page and click **Add block** — you'll now see your
   curated browser instead of core's full list.
