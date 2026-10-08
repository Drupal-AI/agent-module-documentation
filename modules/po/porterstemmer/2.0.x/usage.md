Porter-Stemmer improves English-language searching in Drupal's core Search module by reducing words to their root stem (e.g. "blogging"/"blogs"/"blogger" → "blog") so variants match each other. It implements the Porter2 (Snowball English) algorithm in pure PHP, using the PECL `stem` extension automatically if available.

---

The module has a single job: implement `hook_search_preprocess()`. For English text (`langcode == 'en'`) it lowercases the text, normalizes curly apostrophes, splits on a word-boundary regex (`PORTERSTEMMER_BOUNDARY = "[^a-zA-Z']+"`, preserving delimiters), and replaces each word with its stem before reassembling the string. This preprocessing runs both when content is indexed and when a query is parsed, so indexed terms and search terms are stemmed consistently and match despite grammatical variation. Stemming uses `Porter2::stem()` (a self-contained PHP port of the Snowball Porter2 algorithm with the standard exception list) unless the PECL `stem` extension's `stem_english()` is loaded, in which case that is used for speed (identical output). Non-English text is returned unchanged. The Drupal 11 implementation registers the hook via the `#[Hook('search_preprocess')]` attribute on the autowired service `Drupal\porterstemmer\Hook\PorterstemmerHooks`, with a `#[LegacyHook]` shim in `porterstemmer.module`. There is no configuration, no permissions, no admin UI — enabling the module is the entire setup. Note: only affects core Search; Search API has its own processors.

---

- Make "running", "runs", and "ran"-style variants match "run" in core Search.
- Match singular and plural forms (e.g. "cat"/"cats") in search results.
- Improve recall for content search without manual synonym lists.
- Stem both the search index and the query so they align automatically.
- Add English stemming to a site using core Search + the core search page.
- Rely on the PECL `stem` extension for faster stemming when it is installed.
- Fall back to a pure-PHP Porter2 implementation when PECL `stem` is absent.
- Leave non-English (non-`en`) search content untouched.
- Reduce index size conceptually by collapsing word variants to a common stem.
- Provide the Snowball Porter2 algorithm to other code via `Porter2::stem($word)`.
- Normalize curly/smart apostrophes before stemming so contractions behave.
- Improve relevance of American-English searches (algorithm tuned for US spelling).
- Drop-in enhancement for the core Search module with zero configuration.
- Use as the stemming layer for a simple content search page.
- Preprocess arbitrary English text into stems programmatically for custom search features.
