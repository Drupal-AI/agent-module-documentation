# Solr autocomplete suggesters

Suggester plugins live in `src/Plugin/search_api_autocomplete/suggester/`:

| Plugin | Class | Solr feature | Use |
|---|---|---|---|
| Terms | `Terms.php` | Terms component | Complete the current partial word. |
| Spellcheck | `Spellcheck.php` | Spellcheck component | Corrections / "Did you mean?". |
| Suggester | `Suggester.php` | Suggester component | Phrase / lookup suggestions. |

`BackendTrait.php` provides shared Solr backend access. Enable and pick one on a search
display at Search API Autocomplete's settings (`/admin/config/search/search-api/…/autocomplete`).

## Extending
Alter the outgoing Solarium query per strategy:
- `hook_search_api_solr_terms_autocomplete_query_alter(QueryInterface $query)`
- `hook_search_api_solr_spellcheck_autocomplete_query_alter(Query $solarium_query, QueryInterface $query)`
- `hook_search_api_solr_suggester_autocomplete_query_alter(Query $solarium_query, QueryInterface $query)`

Or subscribe to events (`src/Event/`): `PreSpellcheckQueryEvent`, `PreSuggesterQueryEvent`
(constants on `SearchApiSolrAutocompleteEvents`). Config schema in `config/schema/`.
