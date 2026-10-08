Views Load More adds a "Load more" pager plugin to Views: instead of numbered page links, the view shows a button that AJAX-appends the next page of results to the bottom of the existing list.

---

The module registers a single Views pager plugin (`id: load_more`) that extends core's Full pager, so it inherits items-per-page, offset and exposed-pager behavior but replaces the page-number links with a themed "Load more" button. It works with Views' built-in AJAX: when AJAX is enabled on the display and the Load More pager is selected, the module attaches its JS library and a `hook_views_pre_render()` hook wires it up. On each AJAX page request a response event subscriber (`VLMEventSubscriber`) intercepts the standard Views `insert/replaceWith` command, strips the `scrollTop`/`viewsScrollTop` scroll commands, and swaps in a custom `viewsLoadMoreAppend` AJAX command that appends the new rows (with optional jQuery fade/slide effect) rather than replacing the whole view. The pager options let you set the button label ("Load more text"), an optional "Finished text" shown when the last page is reached, jQuery effect type/speed, and advanced CSS selectors (`content_selector`, `pager_selector`) for themes that override the default markup. It ships a `views_load_more_pager` theme hook and Twig template that renders a `pager--load-more` nav element. Special handling exists for `html_list` (ul/ol) and `table` styles so rows land in the right container. No settings form, configure route, permissions, or Drush commands — everything is configured per view display in the Views UI.

---

- Add a "Load more" button to a blog listing so readers append older posts without leaving the page.
- Replace numbered pagination on a news feed with progressive AJAX loading.
- Build an infinite-scroll-style product grid (pair with the Waypoints module to auto-trigger on scroll).
- Show a "No more results" message once the final page of a view is loaded.
- Customize the button label per display (e.g. "Show me more", "View older comments").
- Append rows with a fade-in or slide-down jQuery effect for a smoother UX.
- Keep already-loaded results on screen instead of reloading the whole view on each page.
- Use on a masonry/card layout where replacing the DOM would cause a visible flash.
- Add load-more paging to a table-style view (module targets the `tbody` correctly).
- Add load-more paging to an unordered/ordered list style view.
- Override the row wrapper selector when using a custom Views row template.
- Override the pager selector when a theme moves or restyles the pager markup.
- Provide a non-JS fallback: the button is a real link, so it degrades to normal paging without AJAX.
- Configure items-per-page and offset the same way as the standard Full pager.
- Load additional search results incrementally on a Search API view.
- Append more gallery images below the fold on demand.
- Reduce initial page weight by loading only the first N rows and fetching the rest on click.
- Combine with exposed filters so filtered result sets also append instead of paginating.
- Present activity streams / feeds that grow downward as the user requests more.
- Export the pager configuration in the view's config for deployment across environments.
- Give editors a code-free way to switch a view from numbered pages to a load-more button.
- Localize the button and finished text through the standard translatable option values.
