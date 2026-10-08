Views Row Insert is a Views **style plugin** (`row_insert`) that interleaves an extra "inserted" row — either a rendered Drupal block or arbitrary custom HTML — into a view's results after every Nth row.

---

The module adds one Views style plugin, "Row Insert", selectable from a view display's *Format* section. Its options let you pick the inserted content as either a **Block** (any block plugin or a `block_content` custom block, chosen from a select list) or **Custom content** (a free-text/HTML textarea). You then set *Insert after every Nth row* (`rows_number`), and optionally start the output with an inserted row (`row_header`), append one at the bottom (`row_footer`), and cap the total number of inserted rows per page (`row_limit_flag` + `row_limit`). Class options let you add a wrapper class to inserted rows (`class_name`), a class to each original row (`row_class`), and re-add the default Views row classes / striping (`default_rows`, `strip_rows`). All rendering happens in `template_preprocess_views_row_insert()` and the `views-row-insert.html.twig` template, which outputs each row's content with Twig `raw`. The typical use is injecting in-feed ads (Google AdSense) or promo blocks between listing rows. The custom-content textarea is explicitly **unrestricted** — whatever HTML/JS you type is rendered verbatim to every visitor.

---

- Insert a Google AdSense ad unit after every 3rd row of a content listing view.
- Interleave a promotional "block_content" custom block between search-result rows.
- Add a call-to-action banner as a custom-HTML row every 5 items in a news feed.
- Place a newsletter-signup block partway down a long article list.
- Show a sponsored message block after the first row only (using the row limit = 1).
- Start a view's output with an inserted header row before any results.
- Append a "load more / see all" promo row at the bottom of a paged list.
- Cap in-feed ads to a maximum of 2 per page while still listing many rows.
- Break up a grid/list of products with an inserted marketing block.
- Inject a related-content block into a taxonomy term listing.
- Add custom HTML dividers between groups of rows every Nth item.
- Re-add default Views row classes (`views-row`, `views-row-N`) that a lighter template dropped.
- Apply odd/even striping and first/last classes to the combined (original + inserted) row set.
- Give every original row a shared CSS class for custom styling.
- Wrap each inserted row in a named CSS class for targeting ads/blocks in CSS.
- Insert a "featured" block into an events listing after the second event.
- Place a donation-appeal block between rows of a nonprofit's story list.
- Add an inline social-follow block into a blog index every few posts.
- Interleave contextual blocks (e.g. "Popular this week") into a river of posts.
- Render an author-bio block after a fixed number of article teasers.
- Show a survey/poll block once near the top of a listing via the header option.
- Override `views-row-insert.html.twig` to fully control the inserted-row markup.
- Toggle the plugin on/off per display while keeping the style configured (`use_plugin`).
- Insert a video-embed custom HTML row between text-only listing rows.
