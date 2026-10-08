<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TOC API example is a tiny reference module (a single `hook_node_view()`) that shows how to call the TOC API from custom code: it adds an automatic table of contents to the top of Page and Article nodes viewed in the full view mode.

---

The whole module is one hook in `toc_api_example.module`. On `hook_node_view()` it checks that the node is a `page` or `article`, that the view mode is `full`, and that a `body` field is present. It renders the body to an HTML string, loads the bundled `default` `toc_type` for its options, and calls `toc_api.manager` (`TocManager::create('toc_filter', $body, $options)`) to build a `Toc`. If the TOC `isVisible()` (i.e. the body has at least `header_count` — 2 by default — top-level headers) it replaces the body render array with two parts from `toc_api.builder`: `buildToc($toc)` (the navigation) and `buildContent($toc)` (the body with unique header ids and back-to-top links). It defines no config, no routes, no permissions — it exists purely as a copy-paste starting point for your own TOC implementation, and to give the parent TOC API something to demonstrate out of the box.

---

- See a working, minimal implementation of the TOC API before writing your own.
- Add an automatic table of contents to the top of every full-page Article.
- Add an automatic table of contents to the top of every full-page Page node.
- Learn the exact `TocManager::create()` → `isVisible()` → `TocBuilder` call sequence.
- Demonstrate that a TOC only appears once a body has 2+ top-level headers.
- Copy the hook and swap `['page', 'article']` for your own content types.
- Copy the hook and load a different `toc_type` preset instead of `default`.
- Verify a fresh TOC API install renders TOCs without writing any code.
- Use as a smoke test that the `toc_api.manager` / `toc_api.builder` services resolve.
- Show how the body render array is replaced with a `toc` + `content` pair.
- Teach how header ids and "back to top" links get injected into rendered body HTML.
- Prototype TOC styling against real node content quickly.
- Reference how to render a field/body to a string before parsing it for headers.
- Adapt the pattern to a different view mode (e.g. `teaser` is intentionally skipped).
- Compare against contrib implementations (TOC filter, TOC Twig Filter) to pick an approach.
- Provide QA/demo content with rich headings that exercises the numbering path.
- Disable it once a real TOC implementation module is in place.
- Confirm the `default` toc_type's options are what drives the demo output.
- Use it in documentation/screenshots showing a rendered TOC on an Article.
- Serve as the "custom module implementation" example referenced in the TOC API README.
