<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TOC API is a developer framework that parses the header tags (`h1`–`h6`) out of an HTML fragment and turns them into a hierarchical, numbered table of contents with bookmarked headers and "back to top" links. It ships no end-user feature of its own — it is the engine that TOC modules (TOC filter, TOC Twig Filter, Footnotes) and custom code build on.

---

The module centres on a `Toc` value object that loads a source HTML string, finds the configured header levels via XPath, assigns each a unique `id`, computes a hierarchical numbering path, and exposes a flat index and a nested tree. Three stateless-ish services drive it: `toc_api.manager` (`TocManager`) creates and caches `Toc` instances keyed by an id; `toc_api.builder` (`TocBuilder`) renders the navigation (`buildToc`/`renderToc`) and rewrites the source body so headers carry ids and back-to-top links (`buildContent`/`renderContent`); and `toc_api.formatter` (`TocFormatter`) converts strings to ids and numbers to decimal/alpha/roman list values. Presentation is controlled by a `toc_type` **config entity** whose `options` map template, header range, numbering, id strategy, an exclude XPath, and back-to-top settings — five come pre-installed (`default`, `simple`, `simple_numbered`, `full`, `full_numbered`) and more can be added at `/admin/structure/toc`. Rendering uses six theme hooks and Twig templates (`toc_tree`, `toc_menu`, `toc_responsive`, plus header/back-to-top partials); the built-in `responsive` type shows a tree on desktop and a jump menu on mobile. An abstract `TocBlockBase` plugin lets a downstream module expose its current-request TOC as a block. The module deliberately does **not** hook into any content itself: you must call the API from a custom module (see the `toc_api_example` submodule) or install a contrib implementation.

---

- Build a table of contents from a node body's `h2`/`h3` headings inside a custom `hook_node_view()`.
- Provide a jump-menu navigation for long documentation or policy pages.
- Auto-number headings as `1)`, `1.1)`, `1.2)` using the decimal numbering path.
- Number sections with upper-roman (`I`, `II`, `III`) or alpha (`A`, `B`, `C`) list styles per header level.
- Add "Back to top" links after each top-level section heading.
- Give every heading a stable, slugified `id` anchor so headings are directly linkable.
- Create a reusable `toc_type` preset (e.g. "simple menu") once and apply it across modules.
- Restrict the TOC to a header range, e.g. only `h2`–`h4`, ignoring `h1`, `h5`, `h6`.
- Only render a TOC when a page has at least N top-level headers (`header_count`).
- Exclude specific headings from the TOC via an XPath (e.g. anything with class `toc-ignore`).
- Present a responsive TOC: hierarchical tree on desktop, select/jump menu on mobile.
- Expose the current page's TOC in a sidebar block by subclassing `TocBlockBase`.
- Rewrite an arbitrary HTML string (not just node bodies) — e.g. a rendered view or field — into a TOC-annotated document.
- Deduplicate colliding heading ids automatically (`-01`, `-02` suffixes).
- Migrate values from the deprecated `name` anchor attribute to `id` when parsing legacy HTML.
- Prefix generated section ids with a custom prefix (`section-...`) using the `key` or `number_path` id strategy.
- Limit which inline HTML tags survive inside TOC links and headers via `header_allowed_tags`.
- Build a Twig filter that renders a TOC for any formatted-text field (as TOC Twig Filter does).
- Add automatically numbered footnote-style navigation on top of formatted text.
- Ship a site-specific TOC style by cloning `full_numbered` and tweaking numbering prefixes/suffixes.
- Programmatically read a document's heading hierarchy (`getTree()`) for search indexing or an outline API.
- Change the TOC title and its wrapper element (`h3` by default) per preset.
- Convert an accented or non-ASCII heading into a clean ASCII anchor id via `TocFormatter::convertStringToId()`.
- Generate roman/alpha numerals independently of a TOC via the formatter service.
- Cache a TOC block per node and route using the block base's cache tags/contexts.
