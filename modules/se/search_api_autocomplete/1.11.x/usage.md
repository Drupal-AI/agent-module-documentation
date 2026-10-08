Search API Autocomplete adds type-ahead autocomplete suggestions to Search API searches (Views-backed searches, Search API Pages, and custom searches), showing users completions and live results as they type.

---

The module hooks into searches built on the Search API framework and offers autocomplete dropdowns on their fulltext keyword fields. Each autocomplete-enabled search is stored as a `search_api_autocomplete_search` config entity, configured per index at the index's Autocomplete tab. It defines two plugin types: **search** plugins that describe where an autocomplete-capable search lives (Views filters, Search API Pages), typically discovered via derivers, and **suggester** plugins that actually produce the suggestions. Bundled suggesters include Server (backend-provided completions, e.g. Solr autocomplete), Live results (renders matching result items directly in the dropdown), and a Custom script suggester. Which suggesters run, how many suggestions show, minimum keystrokes/characters, and delay are all configurable per search. Suggestions can be altered in code via hooks, and access is gated by an `administer search_api_autocomplete` permission plus per-search view permissions. It relies on a search backend that supports autocomplete (such as Solr) for server-side suggestions, while Live results works with any backend. Everything is exportable configuration, so autocomplete setups deploy between environments like other Search API config.

---

- Add a type-ahead dropdown to a Search API Views search form.
- Provide autocomplete on a Search API Pages search box.
- Show live result items (title + link) inline as the user types.
- Surface Solr server-side term completions in the search field.
- Let users pick a suggested keyword to run a search faster.
- Limit suggestions to a maximum count to keep the dropdown tidy.
- Require a minimum number of characters before suggesting.
- Add a delay so suggestions fire only after the user pauses typing.
- Enable autocomplete only for specific searches on an index.
- Combine multiple suggesters (server + live results) on one search.
- Deploy autocomplete configuration between dev and prod as config.
- Restrict who can administer autocomplete via a dedicated permission.
- Gate individual searches so only permitted users see suggestions.
- Provide a custom-script suggester for bespoke suggestion logic.
- Build a new suggester plugin backed by an external suggestion API.
- Add autocomplete support to a custom Search API search via a search plugin.
- Alter or reorder suggestions in code before display.
- Filter which Views fulltext fields feed autocomplete.
- Give an ecommerce catalog search instant product suggestions.
- Improve findability on a large content site with typeahead.
- Offer recent/popular query completions from the search server.
- Match Search API index fields for suggestion generation.
- Theme the suggestion dropdown via the module's templates.
- Disable a search's autocomplete quickly without deleting config.
- Prototype autocomplete on a demo Search API Page search.
