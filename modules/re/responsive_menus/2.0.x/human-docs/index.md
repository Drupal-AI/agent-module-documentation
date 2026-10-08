# Responsive Menus — manual setup guide

**Responsive Menus** (`responsive_menus`) makes any menu your theme already
renders behave nicely on small screens. Below a screen width you choose, it
swaps the normal menu for a toggle button (a hamburger, for example) and reveals
the links in a mobile-friendly panel. It is one of Drupal's most widely used
navigation helpers, with tens of thousands of sites relying on it.

The key idea is that the module does **not** build menus. It "responsifies"
whatever markup already exists: you tell it which menu to target using a CSS or
jQuery selector (for example `#block-mainnavigation` or `.menu`), pick a **style**
that controls the mobile behavior, set the breakpoint width, and choose the
toggle text. On every non-excluded page it attaches the chosen style's
JavaScript and CSS to those selectors.

A "style" is a small plugin. Two ship ready to use: **Simple expanding**
(`responsive_menus_simple`, the default) is a zero-dependency mobile menu, and
**Mean Menu** (`mean_menu`) supports multi-level menus with expand and collapse
controls. Additional styles — Sidr, codrops Multi-level, Google Nexus, and
Multi-level Push Menu — are available but require you to download their external
libraries first. Only one style is active site-wide at a time. Developers can add
their own style by defining a `@ResponsiveMenus` plugin.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, field by field:
   choosing a style, targeting menus with selectors, the breakpoint, and toggle
   text.

## Where it lives in the admin menu

The settings form sits at **Configuration → User interface → Responsive Menus**
(`/admin/config/user-interface/responsive_menus`). Access to it is gated by the
**Administer responsive menus** permission.

## How to use it

The whole workflow happens on the settings form: choose a style (start with
**Simple expanding**), enter the CSS/jQuery selector for the menu you want to
transform, set the breakpoint width at which the menu switches to mobile mode,
and enter the toggle button text. Save, then resize your browser below the
breakpoint to see the menu collapse into a toggle. See
[Configuration](configuration/index.md) for every option.
