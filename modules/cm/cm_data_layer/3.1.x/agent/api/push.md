<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using the data layer service

## Basic push
```php
\Drupal::service('cm_data_layer.data_layer')->push([
  'event' => 'myEvent',
  'data' => ['some_key' => 'some_value'],
]);
```

## Injected (preferred)
Inject `@cm_data_layer.data_layer` into your service/subscriber and call `$this->dataLayer->push([...])`.

## Signature
`push($data = '', $start_session = FALSE)`
- `$data` — string or array; array items become individual `dataLayer.push()` calls client-side.
- `$start_session = TRUE` — force session storage (PrivateTempStore) even when no session is active yet.

## Delivery
- **HtmlResponse:** payload attached as `drupalSettings.cm_data_layer`; `Drupal.behaviors.dataLayerPush` loops each item into `window.dataLayer`.
- **AjaxResponse:** one `dataLayerPush` command per item, calling `dataLayer.push(response.data)`.
- Data is flushed once read (`getData()` de-duplicates via `array_unique(..., SORT_REGULAR)`), so each event is delivered once.

## Storage model
- Active session → `PrivateTempStore('user')['cm_data_layer']`.
- No session (anonymous) → static array for the request.
- `migrateAnonData()` runs on `hook_user_login` to carry anon-collected events into the authenticated store.

## Note for callers
The module does not sanitize payloads. Because delivery is via drupalSettings + `dataLayer.push()`, there is no HTML injection here, but if you push user-supplied values ensure they are safe wherever a downstream tag/template renders them.
