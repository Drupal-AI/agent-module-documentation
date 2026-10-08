# Superfish — manual setup guide

**Superfish** (`superfish`) turns any Drupal menu into an animated, multi-level
dropdown or fly-out navigation block using the well-known jQuery Superfish plugin.
Where core's menu blocks render a flat or statically expanded list, a Superfish
block lets top-level items reveal their children on hover as nested drop-downs or
side fly-outs — the classic "navbar with dropdowns" or "sidebar with flyouts"
pattern.

You use it by placing a **Superfish block** (there is one per menu, just like
core's menu blocks) into a region and then configuring that block instance. All of
the interesting choices — horizontal / vertical / navbar layout, which level to
start at and how deep to go, built-in visual styles, arrows on parent items, drop
shadows, animation speed and hover delay, slide-in effects, and a full touchscreen
mode with breakpoints — live on the block's own settings form. There is no
site-wide settings page; everything is per block, and because the settings are
stored as block config they export and deploy like any other block.

Superfish depends only on Drupal core, but it needs one external JavaScript/CSS
library, `lobsterr/drupal-superfish`, which Composer pulls in for you when you
install the module. The rendered markup goes through overridable Twig templates,
so themers can fully customize the output, and the module quietly supports
translated menu links on multilingual sites.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Superfish
   library with Composer, then enable it.
2. [Configuration](configuration/index.md) — place a Superfish block and walk
   through its settings, field by field.

## Where it lives in the admin menu

Superfish has **no global settings page**. Once enabled, you work with it at
**Structure → Block layout** (`/admin/structure/block`): place a block of type
**Superfish** into a region, pick the menu it should render, and configure the
drop-down behavior right there on the block form. Add as many Superfish blocks as
you like — for example a horizontal main-menu navbar in the header and a vertical
fly-out menu in a sidebar, each configured independently.
