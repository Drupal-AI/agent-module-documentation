<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Show More Pager adds a "Show more" pager to Views: instead of numbered pages, the view shows a button that loads the next batch of results (appending or replacing), with an optional different item count for the first page.

---

The module provides a single Views **pager plugin**, `show_more` ("Show more pager"), selectable in a view's Pager section. It extends core's SQL pager, so you keep "items per page" (used as the per-click batch) but gain: an **initial** item count for the first page (0 = same as items-per-page), a customizable **Show more** button label (`show_more_text`), and a **result display method** — Append (add the next batch after existing rows; in AJAX mode this is a true load-more, in non-AJAX it refreshes) or Replace (swap the content). It works in both AJAX and non-AJAX view modes, but is designed for AJAX: a JavaScript library (`views_show_more/views_show_more`) and a response event subscriber (`ShowMoreEventSubscriber`) intercept the Views AJAX response, convert the default `replaceWith` insert into a custom `viewsShowMore` command that appends new rows into the right container (handling `html_list`, `table` and `grid` styles), drop the scroll-to-top command, and carry header/footer updates. Optional **animation** settings (none/fade/scroll/scroll+fade with slow/fast/custom speed and a scroll offset) and **advanced selector** overrides (content, pager, header, footer jQuery selectors — defaults `.view-content` and `.pager-show-more`) let you adapt it to custom markup. All settings are stored in the view's display pager options (schema `views.pager.show_more`). The `query()` method adjusts LIMIT/OFFSET so the initial page can differ from subsequent pages. It renders through the `views-show-more-pager.html.twig` template, has no admin settings page, permissions or Drush, and requires only core Views.

---

- Replace numbered Views pagination with a single "Show more" / "Load more" button.
- Load the next batch of results via AJAX without a full page reload.
- Show 12 items on the first page but load 6 per click afterwards (different initial count).
- Rename the button (e.g. "Load more articles", "See more").
- Append newly loaded rows beneath existing ones (infinite-scroll-style feed).
- Replace the current results with the next batch instead of appending.
- Add a fade-in animation as new rows load.
- Scroll the viewport to newly loaded content (with a configurable offset).
- Use a custom animation speed in milliseconds.
- Build a "latest news" block that grows as the user clicks show more.
- Provide a lightweight alternative to infinite scroll with explicit user action.
- Work with an unformatted list, HTML list, table, or grid view style (AJAX append targets each correctly).
- Override the content wrapper selector when using custom Views markup.
- Override the pager selector when the pager markup is themed differently.
- Update header/footer areas (e.g. result counts) as more items load.
- Keep the pager working in non-AJAX mode by falling back to page refresh.
- Hide the button automatically when the last page is reached.
- Use it on a block display embedded on a landing page.
- Cache-correctly per query string (the pager sets a `url.query_args` cache context).
- Give editors a modern "load more" UX without custom JavaScript.
- Combine an initial larger page with small subsequent batches for perceived performance.
- Theme the button by overriding `views-show-more-pager.html.twig`.
