<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API block adds a configurable "Search API form" block that renders a lightweight search input which submits (by default via GET) to a Search API search page — the replacement for core's Search block, which is incompatible with Search API.

---

The module provides a single Block plugin (`search_api_form_block`) and the form it renders (`SearchApiForm`). Unlike core's search block, it does not run a search itself: you point it at the path of an existing Search API view page (its "Search page" / `action_url`) and name the input after that view's exposed keyword filter (`input_name`, e.g. `keys`), so submitting the block navigates to the search page with the keyword in the query string. The block's settings form lets you choose the submit method (GET or POST), a placeholder, submit-button label, an optional visible label with a visibility mode, and whether to forward any existing GET parameters from the target URL as hidden fields (`pass_get_params`). A `hook_form_FORM_ID_alter` strips `form_build_id`, `form_token` and `form_id` from the markup so the resulting search URL stays clean. Text fields (path, input name, labels, placeholder) support tokens when the Token module is installed, resolved against an optional block "entity" context. All settings are stored on the block config entity under `block.settings.search_api_form_block`, and a theme suggestion `input__search_api_block` is provided for theming the input. There is no admin settings page or configure route — everything is configured per placed block.

---

- Add a site-wide search input in a region (header, sidebar) that submits to a Search API search view page.
- Replace core's Search block on a site that uses Search API instead of core Search.
- Point a header search box at a `/search` view and pass the typed keyword as the `keys` exposed filter.
- Rename the input to match a custom exposed filter machine name (e.g. `query`, `search`, `q`).
- Submit the search via GET so results pages are shareable/bookmarkable with the query in the URL.
- Submit via POST when you do not want the keyword to appear in the URL.
- Show a placeholder like "Search products…" in the input.
- Customize the submit button label (e.g. "Go", "Find").
- Add a visible or screen-reader-only label to the input, with before/after/attribute visibility.
- Forward existing GET parameters on the target search URL as hidden inputs so pre-set facets/filters survive.
- Place multiple search blocks, each pointing at a different search view (e.g. products vs. articles).
- Use a token in the Search page path so the block submits to a context-dependent search page.
- Restrict a search block's visibility to certain pages using core block visibility conditions.
- Provide a compact search box in the footer that links to the full faceted search page.
- Theme the search input specifically via the `input__search_api_block` template suggestion.
- Give editors a reusable search widget without building a custom form or block.
- Drive a search results View's exposed keyword filter from any page on the site.
- Offer language- or section-specific search boxes by placing separate blocks per path.
- Add a search input to a landing page built with Layout Builder or block layout.
- Keep search URLs clean (no `form_build_id`/`form_token`) for caching and sharing.
- Prototype a search UX quickly by wiring a block to an existing Search API view.
- Expose a "search this site" box that deep-links into an Algolia/Solr/database-backed Search API index page.
