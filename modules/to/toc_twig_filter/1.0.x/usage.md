<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TOC Twig Filter adds a Twig `|toc` filter that generates a hierarchical table of contents from the header tags in a piece of rendered markup, using the TOC API module.

---

The module registers a single Twig extension (`TocTwigExtension`) providing the `toc` filter. Applied to rendered field markup, the filter passes the HTML to the TOC API manager (creating a TOC named `toc_twig_filter`) and returns an array with two keys: `toc` (the built table-of-contents render array) and `content` (the original content with anchor ids injected into the headers). You control the heading levels and behavior either by naming a TOC API `TocType` config entity (e.g. `'full'`) or by passing an inline options array such as `{ 'header_min': 2, 'header_max': 4 }`.

Typical usage is in a node or field template: render the body, pipe it through `|toc`, then print `body.toc` and `body.content` separately. Because it operates on already-rendered, filter-processed markup and only reads/annotates headings, it introduces no new routes, permissions or services beyond the Twig extension, and no user-input trust boundary of its own (sanitization remains the responsibility of the text format that produced the markup).

---
- Add a table of contents above a node's body field.
- Generate anchor links for all H2/H3 headings in content.
- Limit the TOC to a heading range with `header_min`/`header_max`.
- Reference a predefined TOC API type by name (e.g. `|toc('full')`).
- Render the TOC and the anchored content separately in a template.
- Build a sticky sidebar TOC for long articles.
- Produce in-page navigation for documentation pages.
- Apply the filter to any rendered field or block markup.
- Reuse TOC API TocType config entities across templates.
- Inject heading anchor ids into existing content without editing it.
- Provide jump links for accessibility on long pages.
- Combine with theme templates for consistent TOC styling.
- Configure heading depth per template via an inline options array.
- Skip the TOC when content has no headings (empty result).
- Add TOC output to teaser vs full view modes selectively.
- Style the generated TOC list with theme CSS.
