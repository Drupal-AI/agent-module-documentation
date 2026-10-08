Ajax link loads the content of a clicked link into the current page's DOM via AJAX instead of a full page navigation, and can drive infinite scroll.

---

Ajax link is a themer/developer helper: mark any `<a>` with the `ajax-link` class and a `data-ajax-link-selector`, attach the `ajax_link/ajaxLink` library, and clicking the link fetches the linked route, extracts the markup matching your selector, and replaces or appends it into the page — no custom `AjaxResponse` code per case. Loading is done by a single generic route (`/ajax/ajax_link`) that re-renders the target page in the current user's session (so the fetched content still enforces its own access) and returns only the selected fragment. Data attributes control the target selector, the replace/append method, whether browser history is updated, and whether the link is removed after use. An `ajax-link-auto` variant auto-clicks the link when it scrolls into view, giving infinite scroll. There is no admin UI and nothing to configure in the database — everything is driven by classes and `data-*` attributes in your markup or Twig.

---

- Load the next page of a listing into the same area without a full reload.
- Build an infinite-scroll pager with `ajax-link-auto` (auto-clicks when visible).
- Replace a content region in place using `data-ajax-link-method="replace"` (default).
- Append fetched content to a region using `data-ajax-link-method="append"`.
- Add "load more" buttons to product, article, or search-result lists.
- Load a tab/panel's content on demand from its own route.
- Fetch a partial view page and drop it into a `.products-list` container.
- Keep the browser URL/history in sync with `data-ajax-link-history="1"`.
- Hide the trigger link with the `ajax-link-hidden` class while keeping auto-load.
- Keep a reusable link after loading by setting `data-ajax-link-remove-after-execution="false"`.
- Turn any Views "Pager: Load more" style link into an AJAX in-place loader.
- Attach the behavior in a preprocess hook via `$variables['#attached']['library'][] = 'ajax_link/ajaxLink';`.
- Attach the behavior in Twig via `{{ attach_library('ajax_link/ajaxLink') }}`.
- Group several links under a `.ajax-links-wrapper` so shared settings apply to all of them.
- Progressively enhance normal links so they still work if JS is disabled (href is a real page).
- Load additional comments or replies into a thread without leaving the page.
- Swap dashboard widgets or report fragments by pointing selectors at their wrappers.
- Reduce full-page reloads to improve perceived performance on long listings.
- Re-attach Drupal behaviors to newly loaded content automatically after each AJAX call.
- Load content into a specific CSS selector chosen entirely from the markup, no PHP required.
- Provide a lightweight alternative to writing a custom controller + AjaxResponse per feature.
