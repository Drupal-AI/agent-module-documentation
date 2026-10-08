# Civic Accessibility Toolbar — manual setup guide

**Civic Accessibility Toolbar** (`civic_accessibility_toolbar`) adds a placeable
block with front-end buttons that let your visitors adjust the page for
readability: **resize the text** (100%, 125%, or 150%) and **switch the colour
contrast** (normal, blue, high-visibility, or soft). Each choice is remembered in
a cookie, so it carries across pages and persists on the visitor's next visit.

It's aimed at public-sector and civic sites that need to meet accessibility
regulations, giving users control over text size and contrast directly on the
page. The module is lightweight — it relies only on core (jQuery) and ships its
own CSS and templates.

Everything is configured on the **block instance**: you place the *Accessibility
Toolbar* block in a region, choose whether to show the text-resize group, the
contrast group, or both, and optionally give each group a label. There is no
global settings page. One important thing to know: the text-resize buttons work by
scaling `rem`/`em`-based font sizes, so your active theme's typography must use
`rem`/`em` units for resizing to take visible effect.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — placing the block, its settings, the
   `rem`/`em` requirement, and how to restyle it.

## Where it lives in the admin menu

There is no dedicated settings page. You place and configure the toolbar as a
block at **Structure → Block layout** (`/admin/structure/block`) — look for the
**Accessibility Toolbar** block.

## How to use it

1. Go to **Block layout**, click **Place block**, and choose **Accessibility
   Toolbar** into whatever region you like (header, sidebar, footer).
2. In the block's settings, decide whether to show the text-resize controls, the
   contrast controls, or both, and set optional labels.
3. Use core's block **Visibility** conditions to scope where the toolbar appears
   (specific paths, roles, or content types).

Visitors then click the buttons to enlarge text or change contrast, and their
choice is remembered via a cookie. See [Configuration](configuration/index.md) for
the details, including the theme requirement for text resizing.
