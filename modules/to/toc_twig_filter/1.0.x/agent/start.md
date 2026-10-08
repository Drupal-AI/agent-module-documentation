<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TOC Twig Filter (toc_twig_filter) — agent index

**Adds a Twig `|toc` filter that builds a hierarchical table of contents from headers in rendered markup via the TOC API.**

- **Version:** 1.0.x
- **Core:** ^10.3 || ^11.0 — depends on `toc_api` (>=2.0.0).
- **Service:** `toc_twig_filter.twig_extension` (`TocTwigExtension`, args `@toc_api.manager`, `@toc_api.builder`).
- **Filter:** `toc` → `build($render, $options='default')` returns `{ toc, content }`.
- **Options:** a TocType machine name (string) or an inline array like `{header_min: 2, header_max: 4}`.
- **Usage:** `{% set body = content.body|render|toc %}{{ body.toc }}{{ body.content }}`.

**Security:** template-layer only — no routes, permissions or public endpoints; operates on already-rendered/filter-processed markup and only builds/annotates headings. No security findings.
