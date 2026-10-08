# Porter-Stemmer — agent index

Adds English (Porter2/Snowball) stemming to Drupal **core Search** via `hook_search_preprocess`.
Zero configuration: no `configure` route, no permissions, no schema. Depends on core `search`.
Enabling the module is the whole setup.

- **The stemming hook and the `Porter2::stem()` API** → [api/stemming.md](api/stemming.md)

Key facts:
- Implements `hook_search_preprocess($text, $langcode)`; only acts when `$langcode == 'en'`, else returns text unchanged. Runs at both index and query time.
- Uses PECL `stem_english()` when the `stem` extension is loaded (`_porterstemmer_pecl_loaded()`), otherwise pure-PHP `Drupal\porterstemmer\Porter2::stem()`.
- Word boundary regex constant `PORTERSTEMMER_BOUNDARY = "[^a-zA-Z']+"`.
- D11 hook via `#[Hook('search_preprocess')]` on autowired service `PorterstemmerHooks`; only affects core Search (not Search API).
