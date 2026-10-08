<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Meta Conversions API sends conversion events to Meta (Facebook) from the server rather than from the visitor's browser, as a replacement for or supplement to the browser Facebook pixel.

---

The browser pixel has been degraded from several directions at once: ad blockers strip it, Safari's tracking prevention truncates the cookies it relies on, and iOS App Tracking Transparency cut the identifiers it depended on. Advertisers responded by moving conversion reporting server-side, and this module supplies that path for Drupal. It wraps Facebook's official PHP Business SDK (`facebook/php-business-sdk:^15.0`, Graph API v15.0) in a `meta_conversions_api.meta_client` service whose `sendRequest()` method builds a server-side `Event` — user data, custom data, event name, source URL, timestamp, action source — and POSTs it to `https://graph.facebook.com/v15.0/{pixel_id}/events`, authenticated by an access token stored in the `meta_conversions_api.settings` config. A single event ships out of the box, **PageView**, which is fired by a JavaScript beacon (`/ajax/page-view`) on non-admin pages; everything else is added by other modules calling `sendRequest()` directly. PII you pass in the user-data array (email, phone, first/last name, and so on) is **SHA-256 hashed by the SDK before it leaves the site** — you pass raw values and the SDK normalises and hashes them per Meta's requirement; client IP and user agent are attached automatically and, per Meta's spec, are sent in the clear. Three integration points shape behaviour: `hook_meta_conversions_api_event_names()` declares named events (so they appear in the events toggle form), `hook_meta_conversions_api_event_names_alter()` renames them, and `hook_meta_conversions_api_allowed()` returns an `AccessResult` that can forbid sending — the intended hook for wiring cookie-consent so declined visitors are not tracked. The matching JS override `Drupal.meta_conversions_api.allowedCallback` and the Twig helpers `meta_api_is_enabled()` / `meta_api_is_allowed()` let templates and scripts respect the same gate. The privacy posture is the thing to be deliberate about: because the request originates on the server there is nothing in the visitor's browser to intercept or block, so consent must be enforced in site code, and a hashed email is still personal data under GDPR (pseudonymisation, not anonymisation) requiring a lawful basis and a privacy-notice entry. Configuration is a single admin form (access token, pixel ID, default action source, optional test event code and SDK logging) behind the `administer meta_conversions_api` permission, plus a second tab to enable/disable individual events.

---

- Report purchases to Meta server-side, bypassing ad blockers.
- Recover conversion data lost to browser tracking prevention.
- Supplement the browser Facebook pixel with a server-side signal.
- Send a server-side PageView event out of the box.
- Track conversions reliably after iOS App Tracking Transparency changes.
- Send custom conversion events (Purchase, Lead, CompleteRegistration) from PHP.
- Match conversions to people by SHA-256 hashed email or phone.
- Deduplicate browser-pixel and server events using a shared event ID.
- Gate all event sending on cookie consent via `hook_meta_conversions_api_allowed()`.
- Enforce consent in server code so declined visitors are never reported.
- Declare a new named event so editors can toggle it in the UI.
- Rename a Meta event name without changing the calling code.
- Disable a specific event (e.g. PageView) from the events config form.
- Test event delivery against Meta's Events Manager with a test event code.
- Attach a purchase value and currency as custom data on an order event.
- Fire conversion events from a decoupled/headless front end via the service.
- Send add-to-cart and checkout events from Commerce order workflows.
- Report a webform/lead submission as a server-side conversion.
- Improve ad campaign attribution and return-on-ad-spend measurement.
- Turn SDK request/response logging on temporarily to debug delivery.
- Check `meta_api_is_enabled()` in a Twig template before rendering a marker.
- Automatically include client IP and user agent for better event matching.
- Restrict who can configure tracking with the `administer meta_conversions_api` permission.
- Set a default action source (website, app, etc.) for events that omit one.
