# Enabling & configuring the stemmer

No settings page. Configuration is per Search API index (the processor), or nothing at all for core
Search (it just works once the module is enabled).

## Search API index processor

1. Edit your index → *Processors* tab (`/admin/config/search/search-api/index/<id>/processors`).
2. Enable **"Snowball stemmer"** (plugin id `snowball_stemmer`). It runs at the
   `preprocess_index`, `preprocess_query`, and `pre_index_save` stages. For best results enable it
   **after** the Tokenizer.
3. Save, then **re-index** existing content so it is stemmed.

The processor only offers itself when at least one site language is supported by the stemmer
(`supportsIndex()` checks each language via the service). Stemming is applied per item/query
language.

### The only config key: `exceptions`

`exceptions` is a map of `word: stem` overrides — the stemmer returns the fixed value instead of
stemming (useful to protect brand names or force a canonical stem). Stored on the index config
entity under the processor:

```yaml
# search_api.index.<id>
processor_settings:
  snowball_stemmer:
    exceptions:
      acme: acme          # never stem "acme"
      drupaling: drupal   # force this stem
    # (plus inherited fields_to_process / all_fields from the base Stemmer processor)
```

Schema: `plugin.plugin_configuration.search_api_processor.snowball_stemmer` (an `exceptions`
sequence). Set programmatically:

```php
$index = \Drupal\search_api\Entity\Index::load('my_index');
$index->addProcessor(\Drupal::service('plugin.manager.search_api.processor')
  ->createInstance('snowball_stemmer', ['exceptions' => ['acme' => 'acme']]));
$index->save();
```

## Drupal core Search module

Just enabling the `snowball_stemmer` module is enough — `hook_search_preprocess()` stems text for
the current language during core search indexing/querying. No configuration needed. (Core's own
tokenization runs after this hook.)
