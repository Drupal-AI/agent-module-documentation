# Snowball stemmer — agent index

Multilingual word stemming (wamania/php-stemmer) as a service + a Search API processor + core-search
integration. No admin settings page, no `configure` route, no Drush, no permissions.

- **Enable/configure the processor on a Search API index, the `exceptions` key, core-search use** →
  [configure/processor.md](configure/processor.md)
- **The `snowball_stemmer.stemmer` service and the `SetLanguageEvent` language-code mapping** →
  [api/service-and-events.md](api/service-and-events.md)

Key facts:
- Search API processor plugin id: **`snowball_stemmer`** ("Snowball stemmer"); extends Search API's
  own Stemmer processor. Enable it on an index's *Processors* tab, then re-index.
- Only config: `exceptions` (map of word → fixed stem), schema
  `plugin.plugin_configuration.search_api_processor.snowball_stemmer`.
- Service `snowball_stemmer.stemmer`: `setLanguage($langcode)` (returns FALSE if unsupported) then `stem($word)`.
- Event `snowball_stemmer.set_language_code` (`SetLanguageEvent`); shipped subscribers map `pt-br`→`pt` and `nb`/`nn`→`no`.
- Requires the external `wamania/php-stemmer` library (installed via Composer).
