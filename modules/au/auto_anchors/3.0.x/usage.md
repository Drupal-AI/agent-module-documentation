<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Automatic Anchors is client-side JavaScript that generates `id` attributes on chosen page elements — `h2`–`h6` headings by default — and can insert an inline `#` permalink into each, so any section of a page becomes directly linkable.

---

A deep link into a document is one of the most useful things a site can offer and one of the least often provided: a WYSIWYG emits `<h2>Refunds</h2>` with no attributes, and asking editors to add anchors by hand yields some pages with them and most without. Automatic Anchors closes that gap without touching the content — it works entirely in the browser. `hook_page_attachments()` attaches a jQuery library plus the module's settings via `drupalSettings` on every front-end page (admin pages are excluded by default), and `auto_anchors.js` runs on the window `load` event: it builds a selector from two admin-configured comma-separated CSS-selector lists (`root_elements`, default `body`, and `anchor_elements`, default `h2, h3, h4, h5, h6`), and for each match that has no id it derives one from the element's text — stripping URL-unsafe characters to hyphens, dropping apostrophes, collapsing repeats, truncating to 64 characters, lowercasing, and appending `-1`, `-2`… to de-duplicate collisions on the page. Elements that already have an id are left untouched, so hand-authored anchors survive. If the current user holds the `show automatic anchor links` permission, it also appends an `<a class="auto-anchor" href="#…">` link (whose visible content is the admin-set `link_content`, `#` by default) inside each matched element, and on load it smooth-scrolls to `window.location.hash` if that target exists. Two properties define the trade: because ids are generated in the browser they are **not in the server HTML** — invisible to crawlers, RSS, or JavaScript-disabled clients — and because they are **derived from live heading text** an edit to a heading silently changes its id, breaking every link that was shared to the old one; likewise two identically-titled sections collide and the deduplication suffix depends on document order, so inserting a section can quietly redirect an existing link. Configuration is at `/admin/config/auto_anchors/settings` behind `administer automatic anchors` (`restrict access: true`).

---

- Make every heading on a long policy or manual directly linkable.
- Send a customer to the exact paragraph of a support article.
- Give a table-of-contents block real targets to point at.
- Share a deep link such as `/about#kevins-famous-chili`.
- Cross-reference a specific step in a how-to guide.
- Show editors an inline `#` permalink they can copy from each heading.
- Support a knowledge base's in-page navigation.
- Link straight into one answer of a long FAQ page.
- Reference a numbered clause in terms and conditions.
- Add anchors to headings across an existing content set without re-editing nodes.
- Provide citation targets into a published report.
- Generate ids on non-heading elements (any CSS selector) via the settings.
- Scope id generation to one region by changing the root-elements selector.
- Preserve manually-authored ids while filling in the gaps automatically.
- Auto-scroll a reader to the linked section when they arrive via a fragment URL.
- Improve deep-linking in a documentation site that mirrors drupal.org's style.
- Link to a specific lesson section on a curriculum page.
- Hide the visible permalink from anonymous users while keeping it for editors (via the permission).
- Turn off id generation on admin pages to avoid interfering with the back end.
- Give staff a reliable way to link colleagues to "the bit about refunds."
