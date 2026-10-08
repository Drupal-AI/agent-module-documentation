<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google Analytics Push is a developer API: other modules and Rules call its `ga_push_add_*()` functions to record a Google Analytics event, and GA Push dispatches it either into the browser's `dataLayer` (client-side) or as a GA4 Measurement Protocol hit sent from PHP (server-side).

---

GA Push is not a tag you drop on a page; it is a thin dispatcher other code calls. A module calls `ga_push_add_event()`, `ga_push_add_ecommerce()`, `ga_push_add_pageview()`, `ga_push_add_social()` or `ga_push_add_exception()` with an associative array, and GA Push routes it through a **method** — a callback registered by `hook_ga_push_method()`. Two methods ship. **`datalayer-js`** is client-side: the push is queued in `$_SESSION`, and on the next page render `hook_page_attachments()` emits a `dataLayer.push({...})` statement into an inline `<script>` in the head (the data still leaves the browser, so an ad blocker or a withheld consent script can still stop it). **`ga4mp-php`** is server-side: it builds a GA4 event with the `br33f/php-ga4-mp` library and POSTs it straight to Google's Measurement Protocol endpoint, bypassing the browser entirely — which means it also bypasses the visitor's ad blocker and any consent gate, so **not sending when the visitor declined tracking is a decision you make in code, not one the consent manager can make for you**. The GA4 path needs a measurement ID (`G-XXXXXXXXXX`) and a Measurement Protocol **api_secret**, both entered on the settings form at `/admin/config/system/ga-push` (`admin ga push` permission) which also picks the site-wide default method. This is version **3.0.0-alpha1**, an **alpha**: the shipped methods implement only a subset of the documented types (datalayer-js handles events only; ga4mp-php handles events and ecommerce), the GA4 event name is synthesised as `eventCategory_eventAction`, and other push types silently do nothing. Any event value that leaves the site — an order total, a search term, an email address embedded in a label — has been sent to Google, so treat event payloads as data you are publishing to a third party.

---

- Record an order completion server-side from Drupal Commerce, surviving ad blockers.
- Push a `dataLayer` event when a form passes validation.
- Send a GA4 ecommerce purchase (transaction + line items) via the Measurement Protocol.
- Track a file download as a server-side event.
- Record a user-registration event from a custom module.
- Measure a search that returned zero results.
- Fire an analytics event from a Rules reaction.
- Send an event after a cron job completes.
- Track a workflow/content-moderation state transition.
- Record a subscription start or payment outcome server-side.
- Push a booking or reservation confirmation to GA4.
- Emit a `dataLayer` event consumed by Google Tag Manager.
- Track a login event that never reaches client-side JS.
- Register a custom `hook_ga_push_method()` to route events to another endpoint.
- Choose per-call whether an event goes client-side or server-side via the `$method_key` argument.
- Set a site-wide default dispatch method on the settings form.
- Fall back to the `google_analytics` module's account ID when GA Push has none configured.
- Send events with a stable client ID derived from the visitor's `_ga` cookie.
- Log every GA4 request/response for troubleshooting by enabling debug mode.
- Attach conversion events that a thank-you-page URL could only approximate.
- Measure an API-driven or headless action that has no browser page view.
- Track a content-publication event for editorial analytics.
- Report a server-side exception/crash count to the property.
- Instrument any point in PHP where "what the server decided" matters more than "what the browser loaded".
