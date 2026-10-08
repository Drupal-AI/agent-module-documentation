# index_now — alter hooks

Declared in `index_now.api.php`. Both are invoked from the `IndexNow` service while building a
submission, and are aimed at headless/decoupled and multi-domain setups.

## `hook_index_now_url_alter(string &$url, array $context): void`

Rewrite the **page URL** that will be submitted to the search engine. Called in
`IndexNow::sendRequest()` *before* de-duplication and queueing, so your altered URL is what gets
sent (and dedup'd).

```php
function my_module_index_now_url_alter(string &$url, array $context): void {
  // $context['entity'] is the ContentEntityInterface that triggered the ping (when available).
  // Example: map the internal Drupal URL to the decoupled front-end URL.
  $url = str_replace('https://cms.example.com', 'https://www.example.com', $url);
}
```

`$context` is read-only; it may contain `entity` (the entity that triggered the ping).

## `hook_index_now_key_location_url_alter(string &$key_location): void`

Rewrite the **KeyLocation** URL — the public URL of the key-verification file that the engine will
fetch to confirm ownership. Called in `IndexNow::buildUrl()` after the default/`Settings`-based
location is computed.

```php
function my_module_index_now_key_location_url_alter(string &$key_location): void {
  // Serve the key file from a specific host/CDN.
  $key_location = 'https://www.example.com/index_now_api_key_' . $api_key . '.txt';
}
```

(For a static base URL you can instead set `$settings['index_now.base_url']` in `settings.php`
without implementing this hook.)

## Plugin-manager alter (advanced)

`hook_index_now_entity_indexer_info_alter(array &$definitions)` — alter discovered EntityIndexer
plugin definitions (see the plugins doc). Rarely needed.
