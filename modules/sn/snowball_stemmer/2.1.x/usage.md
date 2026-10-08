Snowball stemmer provides a multilingual word-stemming service (via the wamania/php-stemmer library) plus a Search API processor and core-search integration, so searches match different inflections of a word (e.g. "running" ↔ "run").

---

The module wraps `wamania/php-stemmer` in a `snowball_stemmer.stemmer` service that supports English, French, German, Italian, Spanish, Portuguese, Russian, Romanian, Dutch, Swedish, Norwegian, Danish, Catalan and more. It ships a **Search API processor** (plugin id `snowball_stemmer`, "Snowball stemmer") that extends Search API's built-in Stemmer processor: enable it on an index to stem field values at index time (`preprocessIndexItems`) and stem query terms at search time (`preprocessSearchQuery`), per item/query language. It also implements `hook_search_preprocess()` so core's Search module gets stemming for the current language. The processor has one configuration key, `exceptions` — a map of words that should stem to a fixed value (overrides), stored in `plugin.plugin_configuration.search_api_processor.snowball_stemmer`. Because Drupal language codes do not always match the stemmer's, the module fires a `SetLanguageEvent` (`snowball_stemmer.set_language_code`) before choosing a stemmer; two shipped subscribers normalize codes — one strips region/locale suffixes (`pt-br` → `pt`) and one maps Norwegian `nb`/`nn` → `no`. Unsupported languages simply disable stemming (the processor's `supportsIndex()` returns FALSE when no site language is supported). There is no admin settings page or `configure` route; you configure it on the Search API index's *Processors* tab (or via the index config entity).

---

- Make a Search API index match "running", "runs", and "ran" to the stem "run".
- Add stemming to a multilingual Search API index that core's English-only stemmer cannot handle.
- Improve recall on a French, German, Spanish, or other non-English search index.
- Enable stemming on Drupal core's built-in Search module for the current language.
- Configure per-word stemming exceptions so a brand/term is not over-stemmed.
- Stem query terms so user searches match indexed stems even when phrased differently.
- Call the `snowball_stemmer.stemmer` service directly to stem words in custom code.
- Normalize localized language codes (`pt-br` → `pt`) before stemming via the SetLanguageEvent.
- Map Norwegian `nb`/`nn` to `no` so Norwegian content stems correctly.
- Add a custom SetLanguageEvent subscriber to map an unusual langcode to a supported stemmer.
- Combine with Search API's tokenizer for best results (run stemming after tokenizing).
- Reduce index size / improve match rate on a product catalog search.
- Provide multilingual stemming without switching to Solr's language-specific analyzers.
- Re-index after enabling the processor so existing content gets stemmed.
- Keep certain acronyms unchanged by adding them as identity exceptions (word → same word).
- Stem taxonomy/term-heavy content so singular and plural tags match.
- Improve autocomplete/search suggestions by matching stems.
- Apply stemming only on indexes whose language is supported (processor hides itself otherwise).
- Handle Catalan, Danish, Swedish, Dutch, Italian, Romanian, or Russian content search.
- Fall back gracefully (leave the word unchanged) on non-UTF-8 or unstemmed input.
- Override the resolved stemmer language from custom code by altering the language event.
- Provide a base stemming layer other search/relevancy tuning can build on.
