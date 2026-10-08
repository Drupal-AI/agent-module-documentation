# Cheeseburger Menu — manual setup guide

**Cheeseburger Menu** (`cheeseburger_menu`) provides a configurable "hamburger"
off-canvas menu for Drupal — the kind of panel that slides in from the side when
you tap a menu button. It works on both mobile and desktop, and it can build its
navigation from one or more of your site's **menus** *and* **taxonomy
vocabularies** at the same time, merged into a single ordered, weighted tree.

The module ships as two blocks that work together: the **Cheeseburger menu**
block is the sliding panel that renders the aggregated menu, and the
**Cheeseburger menu trigger** block is the button that opens and closes it. You
place both from the Block layout page, then configure everything in their block
settings forms — there's no central admin settings page.

There's a lot you can tune per placement: which menus and vocabularies to
aggregate and in what order, how deep each source renders, which levels show
initially, custom titles and SVG icons per source, a full set of colors and
opacities for the panels/trigger/scrollbar, active-trail highlighting, and an
in-panel top navigation. The trigger can be limited to certain breakpoints or a
custom media query, so you can make it a mobile-only hamburger. You can place
several independent cheeseburger menus (each with its own trigger) on one site,
and everything exports as block configuration for deployment.

For developers, the module also exposes language-switch menu links and three
alter hooks (gated behind an `invoke_hooks` setting that's off by default for
performance) for customizing individual items, whole menus, or the tree
manipulators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — place and configure the menu block
   and the trigger block, field by field.

## Where it lives in the admin menu

Cheeseburger Menu has **no central settings page**. You configure it entirely by
placing and editing its two blocks at **Structure → Block layout**
(`/admin/structure/block`).
