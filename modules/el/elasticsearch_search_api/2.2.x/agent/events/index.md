# Index-preparation events

`src/EventSubscriber/InitializeIndexEventSubscriber.php` subscribes to two events dispatched by the
`elasticsearch_connector` module when it (re)creates an index on the ES server. It is registered as an
`event_subscriber`-tagged service in `services.yml.example` (id
`elasticsearch_search_api.event_subscriber.initialize_index`, arg `@…factory.index`).

| Event constant | Method | Effect |
|---|---|---|
| `PrepareIndexEvent::PREPARE_INDEX` | `prepareSearchIndex()` | Sets `settings.analysis` on the index config: an `ngram_tokenizer` (type `ngram`, min/max gram 3) and an `ngram_analyzer` (custom, ngram_tokenizer + lowercase). |
| `PrepareIndexMappingEvent::PREPARE_INDEX_MAPPING` | `prepareMapping()` | Adds a `title.ngram` sub-field (type `text`, `ngram_analyzer`) to the index mapping. |

Net effect: the `title` field gains an n-gram sub-field for partial-word matching straight out of the box,
which the params builders query as `title.ngram`.

## Graceful degradation without elasticsearch_connector

`src/SearchServiceProvider.php` (a `ServiceProviderBase`) runs at container build. If the
`elasticsearch_connector` module is NOT enabled, it removes the index event subscriber and replaces
`elasticsearch_connector.client_manager` with `src/Fake/FakeClientManager.php` (returns `NULL` clients) and
`elasticsearch_connector.index_factory` with a bare `stdClass`, so the site can boot with this module
enabled before its dependency is configured. When the dependency IS present these fakes are not used.
