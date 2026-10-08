<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `campaign_monitor_rest_client` service (API access)

## Install / enable

```
composer require drupal/campaign_monitor_rest_client
drush en campaign_monitor_rest_client -y
```

Composer pulls the library `ilrwebservices/campaign-monitor-rest-api-client:^1.0.0`
(namespace `CampaignMonitor\`). No Drupal module dependencies.

## Getting the client

Static (quick):

```php
$client = \Drupal::service('campaign_monitor_rest_client');
```

Injected (preferred) — the service id is `campaign_monitor_rest_client`:

```yaml
services:
  my_module.cm_helper:
    class: Drupal\my_module\CmHelper
    arguments: ['@campaign_monitor_rest_client']
```

The returned object is a `CampaignMonitor\CampaignMonitorRestClient`, a subclass of
`GuzzleHttp\Client`, so it exposes the full Guzzle API (`get`, `post`, `put`, `delete`,
`request`, `requestAsync`, …). Paths are relative to the base URI:

```php
$response = $client->get('clients.json');       // GET https://api.createsend.com/api/v3.2/clients.json
$data = $response->getData();                    // decoded JSON (DataAwareResponse)
$client->post('subscribers/{listid}.json', ['json' => ['EmailAddress' => 'a@b.com']]);
```

## How the client is constructed

`CampaignMonitorRestClientFactory::fromOptions()`
(`src/Http/CampaignMonitorRestClientFactory.php`) builds the Guzzle config, mirroring core's
`ClientFactory::fromOptions()`:

- `verify => TRUE` — certificate verification on (uses the OS CA bundle).
- `timeout => 30`.
- `headers['User-Agent']` = `Drupal/<version> (+https://www.drupal.org/) <guzzle default UA>`.
- `handler` = `@http_handler_stack` (the shared core Guzzle handler stack, so core middleware applies).
- `proxy => ['http'=>NULL,'https'=>NULL,'no'=>[]]` — explicitly ignores environment proxy vars.
- `api_key` = `campaign_monitor_rest_client.settings:api_key`.

It then deep-merges (`NestedArray::mergeDeep`) in this order:
`$default_config` ← `Settings::get('http_client_config', [])` ← the `$config` passed to
`fromOptions()`. So a site can override client options globally via `$settings['http_client_config']`
or per-call when instantiating the factory directly.

## Auth and base URI (from the vendored library)

`CampaignMonitor\CampaignMonitorRestClient::__construct()`
(`vendor/ilrwebservices/campaign-monitor-rest-api-client/src/CampaignMonitorRestClient.php`):

- Throws `Exception('Missing api_key config option.')` if `api_key` is empty.
- Sets `headers['Authorization'] = 'Basic ' . base64_encode($api_key . ':x')` — the key travels in
  an HTTP **header**, not in the URL.
- Defaults `base_uri` to `https://api.createsend.com/api/v3.2/`. If a `base_uri` is supplied it
  **must** start with `https://api.createsend.com/api`, else it throws — the host is pinned to
  createsend over HTTPS.
- Pushes `Middleware::mapResponse(...)` that returns a `Psr7\DataAwareResponse`, whose `getData()`
  auto-decodes the response body by declared format (e.g. JSON).

## Enabled vs disabled

The factory checks `campaign_monitor_rest_client.settings:status`:

- status truthy → returns a real `CampaignMonitorRestClient`.
- status falsy → returns `CampaignMonitorRestClientDisabled`, which overrides `requestAsync()` to
  `throw new \Exception('Campaign Monitor REST Client is disabled.')`. Because every Guzzle call
  funnels through `requestAsync()`, **all** requests throw while disabled. Wrap calls in try/catch
  in code that must tolerate the disabled state.

See [../config/settings.md](../config/settings.md) for configuring the key and status.
