<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AlertsFetcher service & BE-Alert Live block

## Service `be_alert.alerts_fetcher`
Class `Drupal\be_alert\AlertsFetcher` (`src/AlertsFetcher.php`), constructed with
`@config.factory`, `@http_client` (Guzzle), `@language_manager`, `@logger.factory`
(`be_alert.services.yml`). Reads the immutable `be_alert.settings` config in its constructor.

### `fetchAlerts(string $environment = 'sandbox')`
1. `getEndpointVariables($environment)` returns `API_KEY` + hardcoded `FEED_URL`/`ALERT_URL`:
   - **sandbox**: `sandbox.api_key`, feed `https://sandbox.publicalerts.be/CapGateway/feed?channel=5fbec9b08010c466f7514fbc`.
   - **production**: `production.api_key`, feed `https://publicalerts.be/CapGateway/feed`.
   - any other value → empty strings.
2. Builds the language id (`languageManager->getCurrentLanguage()->getId()`); non-`en` gets a `-Be`
   suffix. Sets `map_url` = `https://publicalerts.be/CapGateway/#!/?lang=<rawLang>`.
3. Parses the feed URL with `UrlHelper::parse` / `Url::fromUri`, then adds query params `lang`,
   `outdated=false`, and (sandbox only) `datestart=1970-01-02T23:00:00.000Z` to widen the test window.
4. `httpClient->get($url, ['headers' => ['Content-Type' => 'application/json',
   'x-api-key' => API_KEY]])` — default Guzzle TLS verification, HTTPS endpoints.
5. On HTTP 200, `json_decode`s the body; iterates `feed->items`, skipping any item without a `title`,
   collecting the rest into `result['alerts']`. Empty items → returns **FALSE**. Otherwise returns
   `['map_url' => …, 'alerts' => [stdClass items]]`.
6. Any exception is caught and logged via the `be_alert` logger channel (`loggerFactory->error`);
   returns the partial `$result`.

## Block `be_alert_live` (`LiveBlock`)
`src/Plugin/Block/LiveBlock.php`, admin label "BE-Alert Live", category "BE-Alert". Implements
`ContainerFactoryPluginInterface`, injecting the fetcher service.
- `defaultConfiguration()` → `use_sandbox => 0`. `blockForm()` adds the "Use sandbox?" checkbox;
  `blockSubmit()` stores it.
- `build()` picks `sandbox`/`production` from `use_sandbox`, calls `fetchAlerts()`, and for each alert
  emits a `#theme => 'be_alert_item'` element with `#map_url` and `#alert`. Returns an empty array
  when there are no alerts.
- `getCacheMaxAge()` returns **0** — the block is never render-cached (always live).

## Theme
Hook `be_alert_item` (`be_alert.module` `be_alert_theme()`), template
`templates/be-alert-item.html.twig`, vars `map_url` + `alert`. Renders
`<time datetime="{{ alert.startDate }}">…</time>` and `<a href="{{ map_url }}">{{ alert.description }}</a>`
using Twig auto-escaping. Override the template in a theme to customize alert markup.

## Programmatic use
```php
$alerts = \Drupal::service('be_alert.alerts_fetcher')->fetchAlerts('production');
// $alerts === FALSE when the feed has no items; otherwise ['map_url' => …, 'alerts' => […]].
```
Alert item fields follow the CapGateway JSON feed
(`getJsonFeed` docs at sandbox.publicalerts.be), e.g. `title`, `description`, `startDate`.
