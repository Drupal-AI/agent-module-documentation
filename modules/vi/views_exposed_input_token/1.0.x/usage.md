<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Exposed input token adds one global Views token, `[view:exposed-input]`, that resolves to the view's current exposed input rendered as a URL query string (for example `?id=3&page=1`), so a link can carry the visitor's active exposed-filter selections to another URL.

---

The recurring need is a "view more" or "see all" link that keeps the filters the visitor already chose: a block or teaser display shows a few filtered rows, and its footer link should open the full page display with the same exposed values still applied. Views core solves the same-view case with the `display_link` area handler, but there is no token, so linking to an arbitrary path — a different route, an RSS feed, a printed view — means a preprocess function or a custom area plugin. This module supplies the piece as a token: `hook_token_info_alter()` registers `[view:exposed-input]` under the `view` token type, and `hook_tokens()` returns the current exposed input built by `http_build_query()` on `$view->getExposedInput()`, prefixed with `?` when non-empty (empty string otherwise). The current pager page is appended as `page=N` when past page 0, and internal Views routing keys (`view_name`, `view_dom_id`, the AJAX/wrapper parameters, and so on) are stripped so only real exposed values remain. Because it is an ordinary token it works in any Views context that exposes the `view` object to token replacement — Global text areas (header, footer, empty text), the view title, link-building area handlers. Values are URL-encoded by `http_build_query()`, which is what makes the output safe to append to an `href`. The whole module is five files with core `views` as its only dependency, PHP 8.1+, core `^10.3 || ^11`, and no configuration, permissions, routes or `src/` of its own.

---

- Build a "view more" link that preserves the visitor's active exposed filters.
- Link a block display of a view to its full page display with the same filters applied.
- Carry the current exposed input to a different route or listing page.
- Append the active filters to an RSS/feed URL so the feed matches the on-screen result set.
- Link a summary/teaser view to a detail listing keeping the chosen category or term.
- Add a "see all results" call-to-action under a filtered listing.
- Preserve the current pager page in an outbound link (`page=N` is included).
- Produce a shareable/bookmarkable URL that reproduces the current filtered view.
- Pass exposed filter state from a homepage promo block to the archive page.
- Keep a keyword/date-range selection when jumping from one display to another.
- Build a link to a print or PDF version of the current filtered result set.
- Replace a custom preprocess function that hand-assembled the exposed-input query string.
- Avoid a bespoke Views area plugin just to reconstruct the exposed query string.
- Link from an empty-results area to a broader listing while keeping the query string.
- Add the current filters to a "report a problem with these results" support link.
- Point a canonical/alternate link at the same filtered state on another display.
- Chain from a faceted block to a full search page carrying the selected facets.
- Generate the query-string portion of a URL inside any token-aware Views text area.
- Mirror Views' `display_link` behaviour but targeting an arbitrary path, not just another display.
- Keep exposed filter selections across a language or domain switch link.
- Feed the current exposed input into an analytics or tracking URL parameter set.
- Build a "load next batch" link that includes both filters and the pager offset.
