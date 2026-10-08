Views AJAX History makes AJAX-enabled Views update the browser URL and history so the back/forward buttons and bookmarking work with exposed filters and pagers.

---

By default, when a View uses AJAX, changing an exposed filter or clicking a pager reloads the results in place but never touches the browser URL, so the back button leaves the page and the state can't be bookmarked or shared. Views AJAX History fixes this with a Views **display extender** plugin (`ajax_history`) that adds an "AJAX history" checkbox to the view's *Use AJAX* setting under **Advanced → Use AJAX**. When enabled on a view whose AJAX is on, `hook_views_pre_render()` attaches the `views_ajax_history/history` JS library plus `drupalSettings` (the current page, initial exposed input, and any excluded arguments) and adds the `url.query_args.pagers` cache context. The JavaScript overrides Drupal's core `Drupal.Ajax` methods (`beforeSerialize`, `beforeSubmit`, `beforeSend`) to call `history.pushState()` with a cleaned-up URL each time a filter is applied or a pager link is clicked, and binds a `popstate` handler that re-issues the Views AJAX request when the user navigates back or forward. An optional "Exclude query arguments from the URL" textarea lets you strip chosen query keys (matched by "starts with") from the pushed URL. It requires only the core Views module, defines a config schema for its two options (`enable_history`, `exclude_args`), and has awareness of Facets-driven views. On install it registers the `ajax_history` display extender in `views.settings`; on uninstall it removes it.

---

- Keep the browser URL in sync as users apply exposed filters on an AJAX view.
- Make the back button return to the previous filtered/paged state instead of leaving the page.
- Make the forward button re-apply a state the user backed out of.
- Let users bookmark a specific filtered result set of an AJAX view.
- Let users share a link that reproduces the exact exposed-filter selection.
- Preserve pager position in the URL so a paged AJAX view is deep-linkable.
- Enable history on an existing AJAX view by ticking "AJAX history" under Advanced → Use AJAX.
- Support multi-value exposed filters (checkboxes, multi-selects) in the pushed URL.
- Remove the page number from the URL when a new filter is applied so results start from page one.
- Strip specific query arguments from the history URL with the "Exclude query arguments" option.
- Keep tracking or unrelated query parameters intact while rewriting only the views-related ones.
- Reload the page on `pageshow` when restored from the browser bfcache so stale AJAX state is refreshed.
- Provide bookmarkable AJAX views without writing any custom JavaScript.
- Work alongside the Facets module, routing AJAX requests correctly when a view has facets.
- Add deep-linking to an AJAX exposed-filter search results page.
- Retain exposed-filter state through a full browser refresh via the initial exposed input snapshot.
- Improve UX of catalog/listing pages that use AJAX filtering and paging.
- Export the per-view history settings as configuration (schema-backed) between environments.
- Enable history selectively per view display rather than site-wide.
- Turn a single-page AJAX view into one with proper browser navigation semantics.
- Avoid full page reloads while still giving users real browser history entries.
- Clean duplicate and views-internal values out of the URL that gets pushed to history.
- Support HTML5 History API (`pushState`/`popstate`) navigation for Views.
- Handle the first page load correctly so the very first back click still restores the view.
- Give editors a checkbox-based toggle instead of requiring code to enable AJAX bookmarking.

