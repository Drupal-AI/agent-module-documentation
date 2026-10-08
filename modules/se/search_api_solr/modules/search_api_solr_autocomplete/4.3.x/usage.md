Bridges Search API Solr with the Search API Autocomplete module, providing Solr-powered typeahead suggestions, term completion, and spellcheck-based "Did you mean?" hints for search boxes.

---

This submodule implements Search API Autocomplete **suggester plugins** backed by Apache Solr. It offers three complementary strategies: **Terms** (complete the word being typed using Solr's terms component), **Spellcheck** (suggest corrections/completions via Solr's spellchecker, powering "Did you mean?"), and a general **Suggester** (Solr's suggester component for phrase suggestions). Suggestions are generated server-side by Solr, so they are fast and relevance-aware even on very large indexes. Developers can fine-tune each strategy with dedicated alter hooks (`hook_search_api_solr_terms_autocomplete_query_alter()`, `…_spellcheck_…`, `…_suggester_…`) and with dispatched events (`PreSpellcheckQueryEvent`, `PreSuggesterQueryEvent`) before the query hits Solr. You enable it per search display in the Search API Autocomplete settings and pick which suggester to use. It requires both `search_api_autocomplete` and `search_api_solr`.

---

- Add Solr-powered autocomplete to a site search box.
- Complete the partial word a user is typing (Terms suggester).
- Offer "Did you mean?" corrections via the Spellcheck suggester.
- Suggest full phrases with Solr's Suggester component.
- Provide fast typeahead even on multi-million-document indexes.
- Improve search UX and reduce zero-result queries.
- Configure suggestions per search display/view.
- Localize suggestions per language using Solr field types.
- Alter the terms autocomplete query in custom code.
- Alter the spellcheck autocomplete query via hook or event.
- Alter the suggester query before it reaches Solr.
- Boost or filter suggestions by content type.
- Surface popular search terms as completions.
- Reduce typos leading to empty result pages.
- Combine spellcheck + terms for richer dropdowns.
- Tune the number of suggestions returned.
- Integrate with an exposed Views search form.
- Power a headless search box via the autocomplete endpoint.
- Debug suggestion queries with the dispatched pre-query events.
- Give editors instant feedback while searching admin listings.
