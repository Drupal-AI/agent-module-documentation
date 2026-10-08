<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Generates a hierarchical table of contents block from H2-H6 headings in a node, with configurable levels, threshold, and skip selectors.

---

GovNL Table of contents scans the headings (H2-H6) in a node's rendered content and builds a hierarchical, anchor-linked table of contents, exposed as a placeable block.

The module generates URL-friendly IDs on each heading (handling special characters), nests list items by heading level and adds ARIA labelling for screen readers. A settings form at `/admin/config/content/govnl-toc` (permission `administer govnl_cms_toc`) configures which heading levels are scanned, a minimum-heading threshold below which no TOC renders, and default CSS skip-selectors that exclude specific elements from scanning. The TOC itself is placed and further configured as a block under Structure > Block layout, so it can be positioned in any region with standard block visibility rules.

Typical setup: enable the module, set the default skip selectors and levels on the settings form, then place and configure the Table of Contents block on the pages that need it.
---
- Add a table of contents block to long content pages.
- Auto-generate anchor links for H2-H6 headings.
- Choose which heading levels appear in the TOC.
- Require a minimum number of headings before showing a TOC.
- Exclude elements from scanning via CSS skip-selectors.
- Set site-wide default skip selectors centrally.
- Produce URL-friendly heading IDs automatically.
- Support special characters in heading text.
- Provide ARIA labels for screen-reader users.
- Place the TOC in any theme region as a block.
- Apply block visibility rules to the TOC.
- Nest sub-headings hierarchically.
- Improve navigation on government/CMS content pages.
- Restrict TOC configuration to administrators.
- Keep anchors stable for deep-linking.
