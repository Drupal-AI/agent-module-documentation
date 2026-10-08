Adds a "Serialization with Pager" Views style for REST Export displays that wraps the serialized rows together with pager metadata (current page, total items, total pages, items per page) in the JSON/XML output.

---

The module provides one Views style plugin, `views_serialization_pager` ("Serialization with Pager"), which extends core REST's `Serializer` style and is available on `data` display types (REST Export). Where the core serializer outputs a bare array of rows, this style returns a structured envelope: `{"rows": [...], "pager": {"current_page", "total_items", "total_pages", "items_per_page"}}`, then serializes the whole thing to the display's negotiated content type (JSON/XML/etc.). Pager values are read from the active Views pager object; `total_pages` is computed via `getPagerTotal()` except for the "Display all items" (`None`) and "Display a specified number of items" (`Some`) pagers (and mocked pagers in tests), where it is left at 0. You configure it by creating a REST Export view, choosing this style as the format, selecting accepted request formats, and setting a "Full" pager so page navigation works. It has no settings of its own beyond the inherited serializer format options, no permissions, no config schema, and no Drush.

---

- Return paginated REST Export results with page metadata for a decoupled/JS front end.
- Expose `current_page`, `total_items`, `total_pages`, and `items_per_page` alongside the data rows.
- Let a SPA build pagination controls from a Views REST endpoint without a separate count query.
- Serialize both rows and pager info to JSON in one response.
- Serialize the same structure to XML (or any registered format) via content negotiation.
- Drive "load more" / infinite scroll from `total_pages` on a headless site.
- Keep row data under a predictable `rows` key and pager data under a `pager` key.
- Add pagination to an existing REST Export view by switching its format to this style.
- Support a "Full" pager on a serialized view so `?page=N` returns the correct page and metadata.
- Provide total counts to clients that need to show "Page X of Y".
- Replace ad-hoc custom REST controllers that hand-roll pager metadata.
- Feed a mobile app list view with page-aware JSON from Drupal Views.
- Combine with the Data (entity) or Data (field) row plugins for entity or field-level output.
- Return an empty `rows` array with correct pager totals when a page is out of range.
- Standardize paginated API responses across multiple Views REST endpoints.
