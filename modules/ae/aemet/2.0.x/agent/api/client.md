<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# aemet API client

Service `aemet.client` (`Drupal\aemet\Client`), args `@http_client @config.factory @cache.default @datetime.time`.

```php
/** @var \Drupal\aemet\Client $client */
$client = \Drupal::service('aemet.client');
$predictions = $client->predictionsSpecific();   // Clients\PredictionsSpecific
$ok = $client->ping();                            // bool healthcheck
$key = $client->getApiKey();                      // from aemet.settings
```

Mechanics (`Clients\ClientBase::doRequest()`):
1. Cache lookup by `aemet.request.<md5(path.model_class)>`.
2. `GET {BASE_URL}{basePath}{path}?api_key=<key>` → the response JSON contains a `datos` URL.
3. `GET {datos}` → the real payload, decoded (`mb_convert_encoding` UTF-8 fix + `json_decode`), wrapped in a model implementing `AemetModelInterface`, and cached until `now + requests_max_age`.

Extend by subclassing `Clients\ClientBase` (implement `getBasePath()`) and adding a `Model\*` class. Config keys: `api_key`, `requests_max_age` (3600 / 43200 / 86400 / -1). All calls use the shared Guzzle client with default TLS verification.
