<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TOC Filter is a text-format input filter that replaces a `[toc]` token in body content with a hierarchical, responsive table of contents built from the content's header tags (`<h1>`–`<h6>`).

---

The module provides a single Drupal filter plugin, `toc_filter` ("Display a table of contents"), which you enable on a text format at *Text formats and editors*. When the filter runs it looks for a `[toc]` token in the text; if found (or if the `auto` setting injects one at the top or bottom), it hands the content and a set of options to the **TOC API** module (`toc_api.manager` / `toc_api.builder`), which parses the header tags and renders the TOC using a named **TOC type** (Default, Simple, Full, Full - Numbered, etc.). Filter-level settings are `type` (which TOC type to use), `auto` (`''`/`top`/`bottom` — auto-insert a TOC when no token is present), `block` (render the TOC in a block instead of inline), and `exclude_above` (ignore headers above the token). The `[toc]` token accepts inline options as attributes — e.g. `[toc type="simple" title="Contents"]` — which are parsed and merged over the TOC type's options. A companion block plugin ("Table of contents", id `toc_filter`) can display the TOC in a region instead of inline. Modules can implement `hook_toc_filter_alter()` to change options or suppress the TOC. TOC types themselves are configuration entities owned by TOC API and are managed at *Structure → Table of contents* (`entity.toc_type.list`, the module's `configure` route).

---

- Add an automatic table of contents to long articles by dropping a `[toc]` token in the body.
- Turn a documentation page's `<h2>`/`<h3>` structure into clickable jump links.
- Auto-insert a TOC at the top of every page in a text format without editing each node (`auto: top`).
- Auto-insert a TOC at the bottom of content (`auto: bottom`).
- Choose a numbered outline style with the "Full - Numbered" TOC type.
- Use a compact "Simple" TOC that only lists top-level headings.
- Render the TOC as a responsive menu that collapses on mobile (responsive TOC type).
- Move the TOC out of the flow and into a sidebar via the "Table of contents" block.
- Override the TOC style per page with an inline token, e.g. `[toc type="tree"]`.
- Give the TOC a custom heading with `[toc title="On this page"]`.
- Exclude an intro paragraph's headings from the TOC using the `exclude_above` setting.
- Suppress the TOC on pages with too few headings via `hook_toc_filter_alter()`.
- Provide "back to top" navigation on lengthy legal or policy pages.
- Standardise TOC appearance across a site by picking one TOC type in the filter settings.
- Let editors opt into a TOC per node simply by adding `[toc]` where they want it.
- Build a wiki-style knowledge base where each page has a generated contents list.
- Add anchored navigation to FAQ pages structured with headings.
- Improve accessibility of long pages with a keyboard-navigable heading index.
- Keep the TOC in sync with content automatically as headings are added or removed.
- Combine with CKEditor headings so authors write normal H2/H3 and get a TOC for free.
- Display a TOC block only on nodes that actually contain a `[toc]` token (the block hides otherwise).
- Present a table of contents on a custom text format used only for handbook content.
- Use different TOC types on different text formats (e.g. simple for blog, full for docs).
- Migrate legacy anchored-navigation markup to a maintainable token-based TOC.
