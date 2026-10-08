<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Toc NG (toc_ng) — agent index
**Client-side table-of-contents generator delivered as a configurable block; optional per-node on/off submodule.**

- **Version:** 1.0.x (release `1.0.0-beta2`)
- **Core:** `^10 || ^11`
- **Depends on:** `node`, `block`.
- **Block:** `toc_ng_block` (`src/Plugin/Block/TocNgBlock.php`) — config-form settings (`selectors`, `container`, `selectors_minimum`, `prefix`, `list_type`, title/tag/classes, back-to-top / back-to-toc, heading focus, smooth scrolling, highlight + offset, sticky + offset, ajax updates) passed to `drupalSettings`; JS in `assets/js/tocng.js` + `js/toc_ng.js` builds the list client-side.
- **Permissions:** `administer toc_ng` (defined in `toc_ng.permissions.yml`; used by the per-node submodule).
- **Submodule:** `toc_ng_per_node` — block that reads a per-node flag to enable/disable the TOC on a node.
- **Surface:** no routes/controllers; configuration only through the standard block config form (core block-admin permission).

**Security:** Display-only. No routes, no server-side processing of request data, no external calls, no mutating endpoints. Block config is gated by core block administration; the per-node submodule adds `administer toc_ng`. TOC is generated client-side from rendered headings; emitted markup passes through `Html`/`Xss`. No security findings.

See [configure/block.md](configure/block.md).
