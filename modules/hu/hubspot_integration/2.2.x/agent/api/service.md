<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# hubspot_integration — HubspotAPI & endpoints

**Service** `hubspot_integration.api` (`\Drupal\hubspot_integration\Services\HubspotAPI`):
- `getCookie($name='hubspotutk')` — returns the cookie; for the
  `hubspot_integration` cookie it parses `hubspot_<tid>_<tid>...`, keeps only
  authorised tids and re-serialises (sanitisation before use).
- profile lookup calls `contacts/v1/contact/utk/<cookie>/profile` on HubSpot.
- `getUserTids()` — term ids representing the current contact.
- `getAnonymousContactNumber()`, `getConfig('anonymous_max_contact')`,
  `getAnonymousContactMailTemplate($hub_cookie)`.

**Public endpoints** (all `_access: TRUE`, GET, `no_cache`):
- `/hubspot_integration/ajax/is-contact` → `{is_contact, cookie}` from the
  caller's own tids.
- `/hubspot_integration/ajax/is-limit-reached` → `{is_limit_reached}`.
- `/set-persona/{persona_id}` → sets `hubspot_integration` cookie
  `hubspot_<persona_id>`, redirects to `destination` (slash-prefixed
  `Url::fromUserInput`) or `<front>`.

These reflect only the requesting visitor's own state — reviewed as SOUND
(no open redirect, no cross-user data exposure).
