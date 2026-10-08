# Superfish — manual setup guide

**Superfish** (`superfish`) turns any Drupal menu into a multi-level dropdown or
fly-out navigation block, powered by the jQuery Superfish plugin. Where core's menu
blocks render a static list, Superfish renders an animated, accessible,
touch-friendly menu with nested fly-out panels — ideal for main navigation,
mega-menus, or vertical sidebar menus.

The module provides a **Superfish block** (one per menu, like core's menu blocks)
with a rich per-block configuration form: starting level and depth,
horizontal/vertical/navbar layouts, built-in styles, hover and animation speed and
delay, drop shadows, arrows on parent items, and slide-in effects. It bundles the
Superfish library's add-ons — **Supposition** (keeps sub-menus on screen),
**hoverIntent** (smarter hover detection), **Supersubs** (custom sub-menu widths),
and a comprehensive **Smallscreen / Touchscreen** mode (accordion or `<select>`
conversion, breakpoints, and user-agent detection for mobile).

The key thing to know is that Superfish has **no global admin settings page** — you
configure everything **per block, when you place or edit it** on the Block layout
screen. Markup is rendered through overridable Twig templates so themers can fully
customize output, and each block's settings are exportable configuration. The
external JavaScript and CSS come from the `lobsterr/drupal-superfish` library,
installed via Composer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its library with
   Composer and enable it.

There is **no configuration page** for this module — you configure each Superfish
block when placing it, as described in "How to use it" below.

## Where it lives in the admin menu

Superfish adds no configuration page of its own. You work with it entirely from
**Structure → Block layout** (`/admin/structure/block`), where you place and
configure Superfish blocks.

## How to use it

1. Go to **Structure → Block layout** and click **Place block** in the region where
   you want the menu (for example, the primary navigation region).
2. In the block picker, choose the **Superfish - *(your menu)*** block for the menu
   you want to render (there's one Superfish block per menu).
3. Configure the block:
   - Pick the **menu type** — horizontal, vertical, or navbar.
   - Set the **starting level** and **depth** to control which part of the menu
     tree appears.
   - Choose a built-in **style**, and tune **animation speed**, **hover delay**,
     **drop shadows**, **arrows**, and **slide-in** effects.
   - Enable the plugins you need — **Supposition**, **hoverIntent**, **Supersubs**,
     and **Touchscreen/Smallscreen** behavior with a breakpoint for mobile.
4. Save the block. Repeat to place multiple, differently-configured Superfish blocks
   for different menus. Because settings are stored per block, they deploy between
   environments as configuration.
