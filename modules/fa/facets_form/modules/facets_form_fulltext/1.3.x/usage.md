<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Facets Form Fulltext adds a "Fulltext (inside form)" facet widget — a free-text search box that lives inside a Facets Form and filters Search API results by the typed keywords.

---

The submodule provides the `facets_form_fulltext` Facets widget (`FulltextWidget`, extends the Facets `ArrayWidget`, uses `FacetsFormWidgetTrait`) and a matching Search API query type (`facets_form_fulltext_query_type`, `FulltextQueryType`), registered onto core Facets via `hook_facets_search_api_query_type_mapping_alter()`. The widget renders a single `textfield` with configurable label, placeholder, and a search operator (`=` for a phrase match, or `AND` where each whitespace-separated word must match). The typed value is carried as the facet's active item through a small `Fulltext` value object (which trims the input); on query, `execute()` either adds one condition on the facet's field for the whole phrase (`=`) or splits the string on whitespace and adds one AND-grouped condition per word. The summary renders "Contains <search>". Because it targets a Search API fulltext facet source field, it's typically used against an indexed fulltext field. It sets fake results when empty so the widget stays visible under Facets' empty behavior. Depends on `facets_form`.

---

- Add a keyword search box as a facet inside a submit-driven facets form.
- Let users combine a text search with checkbox/dropdown/date facets in one submit.
- Filter a Search API listing by a typed phrase (operator `=`).
- Require every typed word to match using the `AND` operator (word order independent).
- Customize the search field label per facet.
- Set a helpful placeholder (e.g. "Type a word") on the search box.
- Provide an accessible, Form-API text filter instead of instant-apply facet links.
- Preserve the typed query in the facet URL so searches are bookmarkable/shareable.
- Show a "Contains …" summary for the active text filter.
- Drive a Views + Search API results page from a co-located text + facets form.
- Trim stray whitespace from user queries automatically.
- Offer a lightweight alternative to a full search page for filtering a facet source.
- Combine free-text with structured facets for advanced search UX.
- Keep the text facet visible even when the current result set is empty.
- Search an indexed fulltext field (e.g. title/body aggregate) via a facet widget.
- Localize the label and placeholder via translation.
