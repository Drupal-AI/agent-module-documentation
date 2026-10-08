<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Go Back History supplies a single block plugin that renders a "Go back" link driven by the browser's own history, placeable through the normal block layout.

---

Getting a visitor back where they came from is harder than it looks. A breadcrumb shows structural position, not the path actually taken; a hard-coded link to a listing page is wrong when the visitor arrived from search or from a related item. The browser's own history is the only thing that knows, and this module exposes it as a Drupal block so it can be placed per region, per theme, and restricted with the usual block visibility conditions. The block is deliberately minimal: it prints an anchor whose click handler calls `window.history.back()`, styled by default as a small round arrow button. There is no server-side configuration form — the button label is a fixed, translatable "Go back", and only the standard block settings (admin title/label, region, visibility) apply.

That makes it a decent fit for detail pages reached from many directions — a product from a category, a search result or a promotion; a document from several index pages; a step in a flow where the previous step varies. It also helps on mobile, where the browser's back affordance is less visible than on desktop.

Two things to be clear about with any history-based control. It depends on there being history to go back to: a visitor arriving directly on a deep link from an email or a search engine has none, and this module offers no fallback URL, so `window.history.back()` simply does nothing in that case — decide whether that is acceptable before placing the block prominently. And because the destination is the browser's, not the site's, it is not a navigation structure — keep breadcrumbs or a real parent link for the structural relationship, and use this for the "take me back" gesture.

---

- Add a "go back" link to detail pages.
- Return a visitor to the listing they came from without hard-coding the target.
- Give mobile users a visible back affordance separate from the browser chrome.
- Place the "Go back history block" in a specific theme region.
- Show the back link only on selected content types via block visibility conditions.
- Restrict the block to a path prefix or to specific pages.
- Restrict the block to one theme.
- Help visitors who reach a product from several different routes.
- Return to a search-result page after viewing an item.
- Add a back step to a multi-page flow where the previous step varies.
- Complement breadcrumbs on deeply nested content.
- Restrict the block to authenticated users via role visibility.
- Replace a hand-written inline JavaScript back link with a managed block.
- Set the block's display title (or hide it) through standard block settings.
- Style the button by overriding the default `.block-go-back-history` CSS.
- Override the markup by supplying your own `block--go-back-history.html.twig` template.
- Reuse the same back gesture across many pages by placing one block globally.
- Give editors a consistent back control they cannot misconfigure (no per-block options to get wrong).
- Add a back affordance to landing pages that are frequently arrived at from campaigns.
- Provide a back link on print/document views reached from multiple indexes.
