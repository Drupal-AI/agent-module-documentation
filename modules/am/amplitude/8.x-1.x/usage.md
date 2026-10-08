<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Amplitude gives Drupal a UI to load the Amplitude JavaScript SDK and define tracking events that fire on matching pages.

---

The module attaches the `amplitude/amplitude-events` library on every page (`hook_page_attachments`) and exposes the configured API key, debug flag, config options and token-replaced user properties to `drupalSettings.amplitude`. Amplitude events are stored as `amplitude_event` config entities; each event has request-path visibility conditions (`request_path` condition plugin), an event trigger (page load, click, etc.), an optional CSS selector and data-capture properties. On each request the module evaluates every event's path condition and passes the matching events to the JS, which calls the Amplitude SDK. Token replacement (via the required token module) lets user properties and event properties be built from route entities.

The exposed `api_key` is Amplitude's public client-side project key (it is meant to ship to the browser), so it is not a secret. Configuration lives at `/admin/config/system/amplitude` behind the `administer amplitude settings` permission; events are managed from a list builder with add/edit/delete forms.

---
- Load the Amplitude SDK site-wide without writing JavaScript
- Set the Amplitude project API key from the settings form
- Toggle Amplitude debug mode
- Pass extra SDK config options through to the client
- Track a custom event on specific page paths
- Fire an event on page load
- Fire an event on a click of a CSS selector
- Capture data attributes from a clicked element
- Attach token-based user properties to every event
- Build event properties from the current route entity via tokens
- Restrict an event to a set of paths using request-path conditions
- Add a new Amplitude event config entity
- Edit an existing event's trigger and properties
- Delete an event
- Send the current user's UUID as the Amplitude device/user id
- Segment events by content type using path patterns
- Review the list of configured events in the admin UI
- Grant a role permission to administer Amplitude settings
- Combine multiple events firing on the same page
- Instrument a campaign landing page with a conversion event