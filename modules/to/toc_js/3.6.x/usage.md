<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Toc.js automatically builds a client-side table of contents from a page's headings, offered either as a node extra field (per content type) or as a placeable block, with smooth scrolling, highlight-on-scroll, back-to-top links and many options.

---

The module embeds a JavaScript library (`toc.js`) that generates the table of contents in the browser from selected heading elements. It exposes the TOC two ways: a per-content-type **node extra field** (`toc_js`) that you enable via a "Table of contents" section on the content type form and place on Manage display, and a **block plugin** (`toc_js_block`) you can place anywhere. Per-content-type settings are stored as node type third-party settings under the `toc_js` namespace, keyed by `toc_js_active` plus ~40 option keys (selectors, container, title, list type, smooth scrolling, highlight on scroll, back-to-top/back-to-toc, sticky, collapsible items, ajax updates, etc.), all provided with defaults by `TocJsService::defaultSettings()`. At render time the settings become `data-*` attributes on the TOC element and the library reads them to build the list, so behavior is configured server-side but executed client-side. Defaults target `h2,h3` headings inside a `.node` container with smooth scrolling and highlight-on-scroll enabled. A theme hook `toc_js` (template `toc-js.html.twig`) renders the container with entity-based theme suggestions, and the `administer toc_js` permission gates the content-type TOC settings. Two submodules extend it: **toc_js_filter** adds a `[toc]` text-format filter, and **toc_js_per_node** lets editors enable/disable the TOC per node.

---

- Add an automatic table of contents to long articles or documentation pages.
- Show a TOC only on specific content types by enabling it per node type.
- Place a TOC block in a sidebar for any page via the toc_js_block.
- Generate anchor links from `h2`/`h3` headings without editing content.
- Enable smooth scrolling to headings when a TOC link is clicked.
- Highlight the current section in the TOC as the reader scrolls.
- Add "back to top" links next to headings.
- Add "back to table of contents" links next to headings.
- Make the TOC sticky as the user scrolls the page.
- Restrict which headings appear by customizing the selectors (e.g. `h2,h3,h4`).
- Scope heading collection to a specific container selector.
- Choose an ordered (`ol`) or unordered (`ul`) TOC list.
- Set a minimum number of headings before the TOC is displayed.
- Add custom CSS classes to the TOC, its title, list, and items.
- Provide a custom TOC title (e.g. "On this page").
- Enable collapsible TOC items for deeply nested headings.
- Skip visually hidden headings from the TOC for accessibility.
- Clean up icons/hidden spans from heading text before adding to the TOC.
- Handle Ajax page updates by refreshing the TOC (experimental).
- Place multiple TOCs with different settings on one page.
- Provide a TOC for taxonomy term pages (the service resolves node/term route entities).
- Theme the TOC via `toc-js.html.twig` and entity-specific suggestions.
- Insert a TOC inside body text with the `[toc]` filter (toc_js_filter submodule).
- Let editors toggle the TOC per node (toc_js_per_node submodule).
- Apply a scroll offset so sticky headers don't cover the target heading.
- Gate who can configure content-type TOC settings with `administer toc_js`.
