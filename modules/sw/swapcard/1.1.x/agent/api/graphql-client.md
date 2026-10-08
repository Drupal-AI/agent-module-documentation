<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Swapcard GraphQL client (plugin API)

The base module exposes a plugin type for talking to Swapcard's GraphQL API.

**Plugin manager:** `plugin.manager.swapcard` (`Drupal\swapcard\Plugin\SwapcardPluginManager`).
**Annotation:** `@Swapcard` (`src/Annotation/Swapcard.php`) — declares `id`, `admin_label`, `description`, and a nested `fields` list.
**Base class:** `Drupal\swapcard\Plugin\SwapcardPluginBase` implements `queryString()` and `post()`.

Typical use:

```php
$config = \Drupal::config('swapcard.settings')->get('guzzle_options');
$events = \Drupal::service('plugin.manager.swapcard')->createInstance('swapcard_events', ['all']);
$graphql = $events->queryString('events');            // builds {"query":"{ events { ... }}"}
$response = $events->post($config['base_uri'], ['body' => $graphql]);  // decoded array
```

- The base class reads `swapcard.settings` in its constructor and injects `Authorization: <api_key>` and the `guzzle_options` into a Guzzle `Client`.
- `queryString($callback, $args, $fields, &$query_fields)` recursively assembles nested GraphQL field selections; passing `['all']` as configuration uses the plugin definition's full `fields` list.
- `post()` returns `Json::decode()` of the body on HTTP 200 (or the raw string), and surfaces exceptions via the messenger.
- Provided plugins: `swapcard_events` (`SwapcardEvents`) and `swapcard_fields` (`SwapcardFields`).

Extension points:
- `hook_swapcard_request_alter(&$fields, $callback, $callback_args)` — add/adjust requested fields before a query is built.
- The manager calls `alterInfo('swapcard')`, so `hook_swapcard_alter()` can alter plugin definitions.

Security notes: requests are outbound-only and use Guzzle's default TLS verification (not disabled). The API key lives in `swapcard.settings` config; treat exported config as sensitive.
