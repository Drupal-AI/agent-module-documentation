<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GA Push — API reference

All entry points are procedural functions defined in `ga_push.module`. There is **no plugin type**;
dispatch methods are a hook-based registry.

## Recording an event

```php
// Generic:
ga_push_add(array $push_params, $type = GA_PUSH_TYPE_EVENT, $method_key = NULL, array $options = []);

// Type wrappers (preferred):
ga_push_add_event(array $push, $method_key = NULL, array $options = []);
ga_push_add_ecommerce(array $push, $method_key = NULL, array $options = []);
ga_push_add_pageview(array $push = [], $method_key = NULL, array $options = []);
ga_push_add_social(array $push, $method_key = NULL, array $options = []);
ga_push_add_exception(array $push, $method_key = NULL, array $options = []);
```

`$method_key`:
- `NULL` or `GA_PUSH_METHOD_DEFAULT` (`'default'`) → use `ga_push.settings:default_method`.
- `'datalayer-js'` → client-side dataLayer push (events only).
- `'ga4mp-php'` → server-side GA4 Measurement Protocol (events + ecommerce).
- If the requested method is unavailable for the type, it falls back to the configured default.

> Important (alpha behaviour): `ga_push_add()` dispatches on `$push['params']`, which the function
> itself never sets — it only sets `type`, `method_key`, `options` and then invokes the
> `hook_ga_push_add` alter. Unless a `hook_ga_push_add` implementation populates `params`, the call
> does nothing. Calling the two services directly (below) avoids this.

### Push array shapes

- **Event** (`GA_PUSH_TYPE_EVENT`): `eventCategory`, `eventAction`, `eventLabel` (opt),
  `eventValue` (opt, non-negative int; coerced to `1` if non-numeric), `nonInteraction` (opt bool).
  For `datalayer-js`, include an `event` key (e.g. `'GAEvent'`) — it becomes the GTM event name.
  For `ga4mp-php`, the GA4 event name is synthesised as `"{eventCategory}_{eventAction}"`.
- **Ecommerce** (`GA_PUSH_TYPE_ECOMMERCE`, server-side only): `trans` = `{id, affiliation, revenue,
  tax, shipping, currency, ...}`; `items` = list of `{id, sku, name, category, price, quantity,
  currency}`.
- **Pageview / social / exception:** documented in the module's dockblocks but **not implemented** by
  either shipped method in 3.0.0-alpha1 (no-op / logged warning).

## Calling the services directly

```php
/** @var \Drupal\ga_push\GA4MPService $ga4 */
$ga4 = \Drupal::service('ga_push.ga4mp');
$ga4->sendEvent(['eventCategory' => 'LandingPage', 'eventAction' => 'Submit', 'eventLabel' => $url], GA_PUSH_TYPE_EVENT);
$ga4->sendEcommerceTransaction(['trans' => [...], 'items' => [[...]]]);

/** @var \Drupal\ga_push\DataLayerService $dl */
$dl = \Drupal::service('ga_push.datalayer');
$dl->pushData(['event' => 'GAEvent', 'eventCategory' => 'LandingPage', 'eventAction' => 'Submit'], GA_PUSH_TYPE_EVENT);
```

- `ga_push.ga4mp` (`GA4MPService`) — server-side. `sendEvent(array $event_data, string $event_type)`,
  `sendEcommerceTransaction(array $transaction_data)`. Uses `google_analytics_4_id` +
  `google_analytics_secret` from config; client ID from the `_ga` cookie or a random UUIDv4. All
  failures are caught and logged to the `ga_push` channel (never thrown to the caller).
- `ga_push.datalayer` (`DataLayerService`) — client-side. `pushData(array $push, string $type)` queues
  into `$_SESSION`; `generateScript()` (called by `hook_page_attachments()`) renders and clears it.
- `ga_push.google_analytics_id` (`GaIdService`, interface `GaIdServiceInterface`) —
  `getAnalyticsId()` (falls back to the `google_analytics` module's `account`), `getAnalytics4Id()`,
  `getAnalyticsSecret()`.

## Registering a custom dispatch method

```php
/**
 * Implements hook_ga_push_method().
 */
function mymodule_ga_push_method() {
  return [
    'my_endpoint' => [
      'name' => 'My endpoint',
      'machine_name' => 'my_endpoint',
      'callback' => [\Drupal::service('mymodule.sender'), 'send'], // callback($push, $type)
      'implements' => [GA_PUSH_TYPE_EVENT => TRUE],
      'side' => GA_PUSH_CLIENT_SIDE,          // or GA_PUSH_SERVER_SIDE
      'tracking_method' => GA_PUSH_TRACKING_METHOD_GOOGLE_ANALYTICS_4,
      'available' => TRUE,                     // bool, or a callable name returning bool
    ],
  ];
}
```

`ga_push_get_methods_option_list($type, $default)` turns the registry into a form options list (used
by the settings form and available to callers building their own selectors).

## Constants (defined in `ga_push.module`)

Methods: `GA_PUSH_METHOD_DEFAULT`, `GA_PUSH_METHOD_DATALAYER_JS`, `GA_PUSH_METHOD_GA4MP_PHP`.
Sides: `GA_PUSH_CLIENT_SIDE`, `GA_PUSH_SERVER_SIDE`.
Tracking: `GA_PUSH_TRACKING_METHOD_UNIVERSAL`, `GA_PUSH_TRACKING_METHOD_GOOGLE_ANALYTICS_4`.
Types: `GA_PUSH_TYPE_PAGEVIEW`, `GA_PUSH_TYPE_EVENT`, `GA_PUSH_TYPE_ECOMMERCE`,
`GA_PUSH_TYPE_EXCEPTION`, `GA_PUSH_TYPE_SOCIAL`.
