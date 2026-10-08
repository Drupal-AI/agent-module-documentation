<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CMRF Key Authentication authenticates a request against a key that is generated and validated by CiviCRM (over CiviMRF/`cmrf_core`), producing a virtual Drupal user whose fields are mapped from the CiviCRM record. It suits CiviCRM-driven "magic link" logins where the authority for who a user is lives in CiviCRM, not Drupal.

It registers a global authentication provider (priority 200): if a request carries a key — as a URL query param, a signed JWT (HS256, verified with a configured secret), or via the login forms `/user/civicrm_login[_request]` — the provider asks CiviCRM to look up the key (an API call filtered by key + email or user id). Authentication succeeds only when CiviCRM returns exactly one matching record; the key comparison is performed **inside CiviCRM**, not by a local string compare, so there is no local `==`/`hash_equals` timing surface and an empty/absent key simply yields no CiviCRM match (`applies()` returns false). The resulting `Account` is not a stored Drupal user: CiviCRM field values are mapped in (including a roles field and token exposure), cached in the session with an inactivity expiry (`logout_after`), and cleared on logout. A page-cache request policy disallows caching for key-auth requests.

Configure entity/action/field mappings, the JWT secret, URL parameter names, the login-code API and inactivity timeout at `/admin/config/services/cmrf_key_authentication` (`administer site configuration`). Operationally note that keys travelling in URL query strings can leak via logs, browser history and Referer headers — prefer the JWT or POSTed login form where possible.
---
Wire the CiviCRM API/field mappings and secret, then let users authenticate via a CiviCRM-issued key (URL, JWT or login form).
---
- Log a user in from a CiviCRM-issued key in a URL
- Authenticate via a signed JWT carrying the key
- Provide a "request a login code" form for users
- Provide a key-entry login form
- Map CiviCRM contact fields onto the virtual Drupal user
- Assign Drupal roles from a CiviCRM roles field
- Expose CiviCRM field values as user tokens
- Set an inactivity timeout that clears the session
- Configure the CiviCRM API entity/action used for lookup
- Configure the key/email/user-id field names
- Send the client IP to CiviCRM for the lookup
- Add extra API parameters (with token replacement)
- Use CiviCRM API v3 or v4 for the lookup
- Email a login code to a user via a CiviCRM API action
- Disable page caching for key-authenticated requests
- Log out and clear the mapped CiviCRM session data
- Restrict configuration to site administrators
- Choose URL parameter names for key/email/user id/JWT