<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Toc NG block

Enable `toc_ng`, then place the **Toc NG block** (Structure → Block layout) in the region where the table of contents should appear. All settings live on the block configuration form (core block-administration permission).

## Core settings
- **Selectors** (`selectors`, default `h2,h3`) — comma-separated elements that become TOC entries.
- **Container** (`container`, default `.node`) — the element scanned for those selectors; match your theme's content wrapper.
- **Minimum elements** (`selectors_minimum`, default 0) — hide the TOC until at least N headings exist (0 = always show).
- **Prefix** (`prefix`, default `toc`) — prefix for generated anchor ids and class names.
- **List type** (`list_type`) — `ul` or `ol`.
- **Title / Title HTML tag / Title CSS classes** — heading text and markup for the TOC block.
- **Table of contents CSS classes** — classes on the TOC wrapper.

## UX / accessibility options
- **Back to top** links (+ label) next to headings.
- **Back to toc** links (+ label + classes, default `visually-hidden-focusable`).
- **Heading focus** — move focus to the target heading on selection.
- **Smooth scrolling** (default on).
- **Highlight on scroll** (default on) + **highlight offset**.
- **Sticky** + **sticky offset** — keep the TOC in view.
- **AJAX page updates** — re-scan headings after AJAX content changes.

Settings are serialized to `drupalSettings`; `assets/js/tocng.js` (with `js/toc_ng.js`, library `toc_ng/toc`) builds the anchored list in the browser — no server-side heading parsing.

## Per-node toggling
Enable the **Toc NG per node** submodule to add a block that reads a per-node setting, letting editors turn the TOC on/off for individual nodes. The `administer toc_ng` permission controls this.
