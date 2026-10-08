<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CMRF Key Authentication (cmrf_key_authentication) — agent index

**CiviCRM key auth provider**: authenticates a request from a key that CiviCRM validates (via CiviMRF), mapping CiviCRM fields to a virtual Drupal user. Key can arrive as a URL param, an HS256 JWT, or via login forms.

**Version:** 1.2.x (1.2.0). Core: `^9 || ^10 || ^11`. Depends on `cmrf_core`.

Auth provider `cmrf_key_auth.authentication.cmrf_key_auth` (global, priority 200). Service `cmrf_key_auth` (`KeyAuth`): `getKey()` reads query/JWT/session; `getUserByKey()` calls CiviCRM (`callCiviCRMApi`) and accepts only `count == 1`. Routes: settings `/admin/config/services/cmrf_key_authentication` (`administer site configuration`); `/user/civicrm_login_request` + `/user/civicrm_login` (`_user_is_logged_in: FALSE`, `no_cache`). Page-cache policy `DisallowKeyAuthRequests`. Config `cmrf_key_authentication.settings` (api entity/action, field maps, `secret_key`, url param names, `logout_after`, mapping/roles field). Virtual `Account` (not a stored user), session-cached with inactivity expiry.

**Security (reviewed):** key validation is delegated to CiviCRM (remote `count==1` check) — no local loose `==`/`hash_equals`, and an empty/missing key yields no match (`applies()` false, not a bypass). JWT uses HS256 with a configured secret. **Observation (not a code flaw):** keys can be passed in URL query params (`KeyAuth::getKey`, src/KeyAuth.php:120-128), so they may leak via access logs / Referer / history — prefer JWT/POST. Config route admin-gated; no TLS-disabled or unverified-callback issues in this module (transport handled by cmrf_core).

See [configure/settings.md](configure/settings.md).