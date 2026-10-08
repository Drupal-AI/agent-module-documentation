<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Toc.js — agent index

Client-side table-of-contents generator. Two surfaces: a per-content-type **node extra field**
(`toc_js`) and a **block** (`toc_js_block`). Requires `node` + `block`. Per-content-type config is
stored as **node type third-party settings** under `toc_js`. No `configure` route. Config schema +
one permission (`administer toc_js`). Submodules: `toc_js_filter`, `toc_js_per_node`.

- **Enable the TOC on a content type, the settings keys, placing the extra field** →
  [configure/per-content-type.md](configure/per-content-type.md)
- **The `toc_js_block` block plugin** → [configure/block.md](configure/block.md)
- **`toc_js.service` (TocJsService): defaultSettings(), buildToc(), form builder** →
  [api/service.md](api/service.md)
- **Theme hook `toc_js`, template, suggestions, libraries** → [theming/template.md](theming/template.md)
- **Permission `administer toc_js`** → [permissions/permissions.md](permissions/permissions.md)

Key facts: enabling the TOC on a node type sets `toc_js.toc_js_active = TRUE` (plus ~40 option keys)
as third-party settings on the `node.type.<bundle>` config; a `toc_js` extra display field then
renders it. Settings become `data-*` attributes on a `.toc-js` element that the JS library reads.
Defaults: selectors `h2,h3`, container `.node`, smooth scrolling + highlight-on-scroll on.
