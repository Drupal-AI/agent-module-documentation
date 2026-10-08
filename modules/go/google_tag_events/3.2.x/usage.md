<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google Tag Manager: Events adds a PHP API on top of the `google_tag` module for pushing server-side events into GTM's `dataLayer` — the piece the main module leaves each site to build itself.

---

The `google_tag` module puts the container snippet on the page; what it does not solve is how a server-side occurrence — a form submitted, an order placed, a login completed — reaches the data layer, especially when the code runs just before a redirect. This module's answer is a service, `google_tag_events` (shortcut `google_tag_events_service()`), whose `setEvent($name, $data)` queues an event; the queue is stashed in a private tempstore so it survives a redirect, and for anonymous visitors a cookie-backed store (`PrivateTempStoreCookie`) carries it across requests and is merged into the real tempstore on login. At render time `hook_page_bottom` emits the queued events through a lazy builder (keeping the page cacheable), `hook_page_attachments` attaches the `google_tag_events/tracking` library, and `hook_ajax_render_alter` covers events raised during AJAX; the front-end behavior then reads them and calls `window.dataLayer.push()` in weight order. Event payloads can be shaped by a `google_tag_event` plugin whose id matches the event name. There is no admin UI for defining events — the only setting is a Debug-mode toggle at `/admin/config/services/google-tag/events/settings` (permission `administer google_tag_container`) that lets events fire without a configured container for testing. Dependencies are `google_tag ^2.0` and `js_cookie ^1`.

---

- Push a server-side event into GTM's data layer from PHP.
- Fire a conversion event after a form submit and redirect.
- Record an event for an anonymous visitor across a redirect.
- Track login or registration completion in GTM.
- Emit an event from a `hook_entity_view` or `hook_page_bottom`.
- Encapsulate event-data preparation in a `google_tag_event` plugin.
- Order several queued events with a plugin `weight`.
- Queue an event raised during an AJAX request so it still pushes.
- Keep event injection compatible with page caching via the lazy builder.
- Push the same event name multiple times in one request.
- Report an e-commerce / purchase event to GTM.
- Trigger a remarketing tag on a specific server-side action.
- Test event pushing locally with Debug mode and no container.
- Measure a multi-step funnel with named events.
- Attach arbitrary data-layer variables to an event payload.
- Standardise event names across a site through plugins.
- Push an event after a Views display renders.
- Send a 403/404 event to analytics.
- Build analytics events without hand-written inline JavaScript.
- Reuse event definitions across several modules.
