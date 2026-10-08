<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events: PageView and adding your own

## The built-in PageView flow
1. `meta_conversions_api_page_attachments()` (in `.module`) runs on every non-admin page. It:
   - bails on admin routes (page views must not fire in the admin),
   - writes `drupalSettings.meta_conversions_api.enabled` and a map of
     `drupalSettings.meta_conversions_api.events` (event name → enabled bool) — **no access token or
     pixel ID is ever exposed to JS**,
   - adds cache tags `config:meta_conversions_api.settings` and `config:meta_conversions_api.events`,
   - always attaches the `meta_conversions_api/page_view` library.
2. `js/meta_conversions_api.page_view.js` runs once per page (via `once`). If
   `Drupal.meta_conversions_api.shouldSend('PageView')` is true — module enabled, event enabled, and
   the overridable `allowedCallback()` returns true — it GETs `/ajax/page-view?url=<current URL>`.
3. `PageViewController::pageView()` (route `meta_conversions_api.page_view`, permission
   `access content`, `no_cache: TRUE`) calls
   `MetaClient::sendRequest(['event_name' => 'PageView', 'event_id' => <id>, 'event_source_url' => <url>])`.
   The `event_id_callback` route default is fixed to `PageViewController::eventId` (a random per-hit id);
   it is not user-supplied. The response body is empty and unused.

The `url` query parameter is only echoed back to Meta as `event_source_url`; it is not fetched or
otherwise dereferenced server-side (no SSRF). The endpoint has no CSRF token (it is a fire-and-forget
analytics beacon).

## Consent gating
Two layers, both should be used together:
- **Server** (authoritative): implement `hook_meta_conversions_api_allowed()` returning
  `AccessResult::forbiddenIf(!$consent)`. `sendRequest()` refuses to send when forbidden, so even a
  forged `/ajax/page-view` request is blocked.
- **Client** (optimisation): override `Drupal.meta_conversions_api.allowedCallback` in your own JS to
  avoid making the request at all when consent is absent. If you gate on a cookie/session, also add a
  cache context in your own `hook_page_attachments()`.

## Adding a custom event
1. (Optional) declare it so it is toggleable/renamable:
   ```php
   function mymodule_meta_conversions_api_event_names() {
     return ['Purchase'];
   }
   ```
   Clear cache so it appears in the events form (names are cached permanently).
2. Send it from your own code (order-complete subscriber, form handler, etc.):
   ```php
   \Drupal::service('meta_conversions_api.meta_client')->sendRequest(
     ['event_name' => 'Purchase', 'event_id' => 'order-' . $id],
     ['email' => $email],
     ['currency' => 'USD', 'value' => $total]
   );
   ```
3. Deduplicate with the browser pixel by using the same `event_id` on both sides.

## Renaming / disabling
- Rename with `hook_meta_conversions_api_event_names_alter()`.
- Disable per event in `/admin/config/system/meta-conversions-api/events`
  (config `meta_conversions_api.events` → `event_toggles`). Only events set explicitly to false are
  suppressed; unknown/new events default to enabled.
