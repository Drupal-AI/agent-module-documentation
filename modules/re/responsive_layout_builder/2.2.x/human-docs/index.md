# Responsive Layout Builder — manual setup guide

**Responsive Layout Builder** (`responsive_layout_builder`) lets you make
**Layout Builder** layouts responsive by controlling which blocks appear at which
screen sizes. You assign **breakpoints** (media queries) to individual blocks in a
layout, so a block can be shown, hidden, or adjusted depending on the visitor's
device — for example, hiding a heavy sidebar block on mobile while keeping it on
desktop. Blocks configured with breakpoints are loaded dynamically as needed for
the screen size, so you avoid pushing unwanted content to every device.

Think of it as the modern successor to the old Responsive Panel Panes approach,
rebuilt for Drupal's core Layout Builder. It plugs into the Layout Builder UI you
already use and adds per‑block responsive controls, driven by breakpoints you
define in its settings form.

One important thing to keep in mind: hiding a block by breakpoint is a **display**
choice, not an access‑control mechanism. A block hidden via CSS/media queries is
still delivered in the page's markup — it's just not shown — so don't rely on it
to protect sensitive content. Each block keeps its own access rules, and this
module has no access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it and its dependencies.
2. [Configuration](configuration/index.md) — define breakpoints in the settings
   form and apply them to blocks in Layout Builder.

## Where it lives in the admin menu

The module provides a settings form registered as
`responsive_layout_builder.settings`, found under **Configuration**, where you
define the breakpoints (media queries) available to your layouts. The per‑block
responsive controls themselves appear inside the **Layout Builder** editing
interface when you configure a block. See
[Configuration](configuration/index.md) for the walk‑through.
