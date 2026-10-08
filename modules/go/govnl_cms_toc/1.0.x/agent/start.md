<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GovNL Table of contents (govnl_cms_toc) — agent index

**Builds a hierarchical, anchor-linked table of contents from a node's H2-H6 headings, exposed as a placeable block.**

- **Version:** 1.0.x — core `^10 || ^11`
- **Config:** `/admin/config/content/govnl-toc` (`administer govnl_cms_toc`) — heading levels, minimum threshold, default skip selectors
- **Display:** placed as a block via Structure > Block layout; generates heading IDs + ARIA labels.
- **Security:** single admin config route, permission-gated; no anonymous or mutating endpoints.
