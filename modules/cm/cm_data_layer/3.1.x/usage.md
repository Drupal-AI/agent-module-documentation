<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A developer-facing service for pushing events and data into the client-side `window.dataLayer` (as used by Google Tag Manager) from server-side Drupal code.

---

The `cm_data_layer.data_layer` service exposes `push($data)`, which behaves like Drupal's messenger: queued items survive until the next response and are then flushed. Storage adapts to the user — for a request with an active session it uses PrivateTempStore keyed to the user/session; for anonymous, session-less requests it uses a static array. A response event subscriber (`DataLayerSubscriber`) attaches queued data on the way out: for a normal `HtmlResponse` it adds the payload to `drupalSettings.cm_data_layer` and a JS behavior loops it into `window.dataLayer`; for an `AjaxResponse` it emits one `dataLayerPush` AJAX command per item that calls `dataLayer.push()` client-side. On login, `hook_user_login()` migrates any anonymous-collected data into the now-authenticated PrivateTempStore so events survive the session transition.

Data is delivered through `drupalSettings` (JSON-encoded by Drupal) and handed to `dataLayer.push()` — the client behavior never writes it into the DOM as HTML — so the transport itself does not introduce an XSS sink. Payload contents are whatever server-side code chooses to push; the module performs no filtering, so callers pushing user-controlled values are responsible for their own sanitization at the point they eventually render, but nothing here injects raw markup into the page. Typical use is calling the service (often from an event subscriber) to record events like page views, cart actions, or form submissions for a tag manager to consume.
---
- Push a GTM-style event from PHP into the client dataLayer
- Record analytics events server-side without inline script
- Queue data that flushes on the next page load
- Emit dataLayer events from an AJAX response
- Track cart or checkout actions for Google Tag Manager
- Fire a custom event after a form submission
- Inject the service into an event subscriber as a dependency
- Collect events for anonymous visitors via static storage
- Persist per-user events using PrivateTempStore
- Migrate anonymously-collected events across login
- Deliver payloads through drupalSettings safely (JSON-encoded)
- Push multiple events in one request; they flush together
- Force a session so data persists with `push($data, TRUE)`
- Feed page-view data to a tag manager on each load
- Send conversion events without theming changes
- Decouple analytics event generation from front-end code
- De-duplicate identical queued events before delivery
- Attach the push behavior only when there is data to send
- Support both full-page and AJAX-driven event delivery
- Centralize dataLayer population in one reusable service