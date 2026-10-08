Ajax Wrapper provides an `ajax_wrapper` render element whose content is produced by a callback and re-rendered over AJAX when links or forms inside it are used, so overviews update without a full page reload.

---

The module ships a single render element, `ajax_wrapper` (`src/Element/AjaxWrapperElement.php`), that you place in a render array with an `#ajax_callback` pointing at a function/method that returns a render array. On first render the callback builds the wrapper's content; the module also attaches `js/ajax_wrapper.js`, which binds click handlers to `<a>` links and submit handlers to `<form>`s found inside the configured wrapper CSS classes. Interacting with them POSTs to the `ajax_wrapper.refresh` route (`AjaxWrapperController::refresh`), which rebuilds the request for the clicked/submitted URL, re-runs the callback, and returns an `AjaxResponse` that replaces the wrapper's markup. A `StoreHistoryCommand` (`js/history.js`) pushes the new URL into `window.history` so the browser back/forward buttons restore previous states. It is a developer-facing utility (no admin UI, no permissions of its own, no config) — you use it in custom code, controllers, blocks, or `hook_theme`/preprocess output.

---

- Build a paged listing that loads the next/previous page over AJAX instead of reloading the whole page.
- Add AJAX filtering to an overview: wrap an exposed-filter form so submitting it refreshes only the results region.
- Refresh a custom block's content in place when a link inside it is clicked.
- Turn a table of records with sort links into a live-sorting table without a full navigation.
- Keep the browser URL and history in sync while AJAX-updating a region (back button restores prior content).
- Wrap a search-results region so typing/submitting a query updates just the results.
- Provide a "load more" style pager for a custom view-like listing.
- Re-render a facet/category navigation region after a selection without leaving the page.
- Build a dashboard panel that refreshes its content from a callback on demand.
- Add AJAX pagination to a custom controller's render output.
- Wrap a form whose submission should update a sibling results area over AJAX.
- Provide keep-scroll-position overviews where clicking a link only swaps the list contents.
- Update a calendar/agenda region when month/day navigation links are clicked.
- Refresh a cart-summary or notification region via a callback-produced render array.
- Give editors a filterable admin listing that updates inline.
- Reuse one callback to render a region both on initial page load and on every AJAX refresh.
- Wire up front-end-only AJAX overviews without writing a bespoke `Drupal.ajax` command.
- Attach the wrapper to specific inner CSS classes so only links/forms in those areas trigger refresh.
- Choose the DOM update method (`html`, etc.) per wrapper via `#ajax_method`.
- Point multiple wrappers on one page at different callbacks, each refreshing independently.
