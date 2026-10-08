Adds an Elasticsearch-native completion suggester to Search API Autocomplete so typeahead is served by Elasticsearch's own `suggest`/`completion` API instead of an ordinary full-text query.

---

Elasticsearch Connector Suggester plugs a suggester plugin, "Elastic display live results", into Search API Autocomplete for indexes served by the Elasticsearch Connector backend. It ships a companion tokenizer processor and a set of event subscribers: on field mapping it declares the autocomplete field as an Elasticsearch `completion` field (choosing the analyzer from the suggester config), on config save it re-saves the index so the mapping is rebuilt, and on the autocomplete request it rewrites the outgoing Elasticsearch query body into a `suggest` request using the `completion` sub-field with prefix matching, duplicate skipping and a size of 10. Results are turned back into Search API items and rendered as live-result suggestions (respecting per-item access and, when configured, highlighted fields, keyword suggestions or a view mode). It requires the Elasticsearch Connector and Search API Autocomplete modules and works on Drupal 9, 10 and 11 (2.x targets Elasticsearch 8.x and Elasticsearch Connector 8.0.x).

---

- Serve autocomplete/typeahead from Elasticsearch's native completion suggester rather than a standard match query.
- Add fast prefix-based suggestions to a Search API index backed by Elasticsearch Connector.
- Improve the "clunky" default autocomplete behaviour when combining Search API, Elasticsearch Connector and Search API Autocomplete.
- Map a chosen fulltext field as an Elasticsearch `completion` field automatically via the field-mapping event subscriber.
- Pick the completion analyzer (standard, simple, whitespace, stop, keyword, pattern or fingerprint) per suggester in the autocomplete UI.
- Return live entity results as the visitor types, linking each suggestion to the item's URL.
- Show suggestions as suggested keywords instead of links via the "suggest keys" option.
- Render suggestions using an entity view mode per datasource/bundle when configured.
- Display highlighted matched text in suggestions when highlighting is enabled on the search.
- Cap autocomplete responses at 10 completion options with duplicate skipping for concise dropdowns.
- Enforce per-result access so users only see suggestions for items they may view.
- Drop shorter/invalid tokens from indexed and query text through the bundled tokenizer processor (minimum word size).
- Rebuild the Elasticsearch index mapping automatically whenever the autocomplete search config is saved.
- Power a site-search box that suggests matching nodes, media, users or other indexed entities.
- Add product-name typeahead to a Commerce or catalogue search built on Elasticsearch.
- Provide instant "did you mean / matching titles" completion for a knowledge base or documentation search.
- Let other modules override the autocomplete route name via the `RouteNameEvent`.
- Let other modules rewrite the matched field name via the `FieldNameEvent` before the suggest query is built.
- Let other modules alter the search keys/prefix sent to Elasticsearch via the `KeysEvent`.
- Reuse an existing Search API Autocomplete configuration by simply switching its suggester to "Elastic display live results".
- Combine with the "Elasticsearch Connector Suggester Tokenizer" processor to tune how indexed text is split for completion.
