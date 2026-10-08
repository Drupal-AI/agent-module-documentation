<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Analytics Push (ga_push) — agent index

A **developer API** for recording Google Analytics events from PHP. Other modules and Rules call
`ga_push_add_*()`; GA Push routes each event through a **method** — a callback registered by
`hook_ga_push_method()` — that either pushes into the browser `dataLayer` (client-side) or sends a
GA4 Measurement Protocol hit from the server. Version **3.0.0-alpha1** — **alpha**. Core `^10.3 || ^11`.
Not a plugin type: methods are a hook-based registry, not annotated/attribute plugins.

## What it actually is
- **Entry points (functions in `ga_push.module`):** `ga_push_add()` (generic) plus type wrappers
  `ga_push_add_event()`, `ga_push_add_ecommerce()`, `ga_push_add_pageview()`,
  `ga_push_add_social()`, `ga_push_add_exception()`. Each takes an associative push array, an optional
  `$method_key`, and `$options`.
- **Method registry:** `hook_ga_push_method()` returns method definitions keyed by machine name, each
  with a `callback`, the push types it `implements`, its `side` (client/server) and `tracking_method`.
  `ga_push_get_methods()` collects them via `invokeAllWith`. When a call passes no method (or
  `default`), GA Push uses `ga_push.settings:default_method`.
- **Two shipped methods** (`ga_push_ga_push_method()`):
  - `datalayer-js` — **client-side**, callback `DataLayerService::pushData`. Implements **event** only.
  - `ga4mp-php` — **server-side**, callback `GA4MPService::sendEvent`. Implements **event** and
    **ecommerce**. Available only when `ga_push_method_GA_GA4_available()` returns true (note: that
    availability function is referenced but **not defined in this codebase** — treat GA4 availability
    as unresolved in 3.0.0-alpha1).

## Mechanism (confirmed from source)
- **Client-side (`DataLayerService`):** `pushData()` appends the push to
  `$_SESSION['ga_push_datalayer-js']`. On the next render, `hook_page_attachments()` calls
  `generateScript()`, which builds `var dataLayer = dataLayer || [];` plus one
  `dataLayer.push(<json_encode($push)>);` per queued event, then clears the session key. The string is
  attached as the `#value` of an inline `<script>` in `html_head`. Only `GA_PUSH_TYPE_EVENT` is
  rendered; other types log a warning and emit nothing.
- **Server-side (`GA4MPService`):** builds a `br33f/php-ga4-mp` `BaseRequest` with a client ID taken
  from the visitor's `_ga` cookie (falls back to a random UUIDv4), constructs a `BaseEvent` named
  `"{eventCategory}_{eventAction}"` (setting any `set<Key>()` that exists), and `send()`s it to
  Google's Measurement Protocol endpoint. `sendEcommerceTransaction()` builds a `PurchaseEvent` from
  `trans` + `items`. Endpoint and TLS are handled entirely by the library (fixed Google host).
- **`GaIdService`** resolves the tracking ID: GA Push's own `google_analytics_id`, else the
  `google_analytics` contrib module's `account` if that module is enabled.

## Configuration & access
- Settings form `GAPushSettingsForm` at `/admin/config/system/ga-push`, route `ga_push.settings`,
  gated by the single permission **`admin ga push`**.
- Config `ga_push.settings`: `default_method`, `google_analytics_4_id` (`G-XXXXXXXXXX`),
  `google_analytics_secret` (GA4 Measurement Protocol api_secret), `debug`.
  (The install default `default_method: 'analytics-js'` does not match any shipped method key — the
  real keys are `datalayer-js` / `ga4mp-php`.)
- **Services:** `ga_push.datalayer`, `ga_push.ga4mp`, `ga_push.google_analytics_id`.

## Caveats worth flagging to callers
- **Alpha, partial:** only event (client) and event+ecommerce (server) actually dispatch; pageview,
  social and exception wrappers exist but the shipped methods do not implement them.
- **`ga_push_add()` reads `$push['params']`** but only sets `type`/`method_key`/`options` — a
  `hook_ga_push_add` alter implementation is expected to populate `params`, otherwise the call is a
  no-op. This is a real rough edge of the alpha API.
- **Data leaving the site:** any label/value passed becomes data sent to Google. Server-side hits
  bypass ad blockers and consent scripts — suppressing tracking for a non-consenting visitor is a
  code decision here, not something the consent manager can withhold.

## Read next
- `agent/api/push-api.md` — full call reference: functions, push array shapes, method selection,
  registering a custom method, and the two services.
