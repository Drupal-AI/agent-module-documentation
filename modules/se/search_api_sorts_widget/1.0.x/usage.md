<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Sorts Widget rewrites the Search API Sorts block so its list of sort links becomes a single "Sort by" `<select>` dropdown with an optional Sort button.

---

`search_api_sorts` renders the active sort options for a Search API search page as a block (`search_api_sorts_block`, one derivative per Search API display) whose content is a list of links: relevance, date, title, each an anchor, the current one flagged `#active`. Every other control on a search page — the keyword box, the facets, the items-per-page selector — is a form element, so a row of links reads as navigation rather than as a control. This module does **not** add a block of its own: it implements `hook_block_view_search_api_sorts_block_alter()` to attach a `#pre_render` callback (`BlockViewAlter::preRender`) that swaps the block's rendered content for a form (`WidgetForm`). That form reads a `search_api_sorts_widget` config entity keyed to the block's display; if no entity exists or its `status` is off, the original link list is returned unchanged, so the widget is opt-in per display. When active it emits a `select` named `sort_by` whose options are the admin-entered ascending/descending labels (values `field|asc` and `field|desc`), defaulting to the inverse of the current sort so the option toggles direction, plus a "Sort" submit button. Two config flags shape submission: **Autosubmit** adds `onChange="this.form.submit();"` to the select, and **Hide submit button** hides the button with inline CSS — enable both together, or a keyboard/no-JavaScript visitor is left with a dead control. On submit the form finds the matching trusted sort link from the block, takes that link's own URL, sets its `order` query parameter to the chosen direction, and issues a redirect — so the chosen sort lives in the query string and the sorted page can be linked, bookmarked and reached with the back button. Configuration hangs off the Search API index under `administer search_api` (there is a "Sorts widget" local task and a `ManageSortFieldsForm` per display); the module also declares an `administer search_api_sorts_widget` permission that the current routes and config entity do not actually consult. Requires `search_api_sorts` and core `block`; version **1.0.0-beta5** on core `^10 || ^11`.

---

- Present Search API sorting as a "Sort by" dropdown instead of links.
- Replace the search_api_sorts link list with a select control.
- Make sorting look like the other form controls on a search page.
- Add a familiar e-commerce style "Sort by" select to a catalogue.
- Give each sort field a separate ascending and descending label.
- Let a visitor flip sort direction from one dropdown option.
- Auto-submit the sort so the page re-sorts on change without a button.
- Hide the Sort button when JavaScript auto-submit is enabled.
- Keep a visible Sort button as the no-JavaScript fallback.
- Configure the sort widget per Search API display, not globally.
- Turn on the widget for one display while leaving others as links.
- Keep the chosen sort in the URL query string for bookmarking and back-button.
- Reduce clutter on a search results page's sort area.
- Improve sorting usability on a mobile search results page.
- Order the sort options with drag-and-drop weights.
- Reuse the existing search_api_sorts block placement (no new block to place).
- Provide a "Sort by" control alongside a facets sidebar.
- Standardise sort presentation across a document or product search.
- Localise the ascending/descending labels via config translation.
- Fall back automatically to the original link list when the widget is left inactive.
