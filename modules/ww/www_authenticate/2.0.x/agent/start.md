<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WWW Authenticate (www_authenticate) — agent index
**Configurable site-wide HTTP Basic Authentication shield with IP/path/role/time rules, layered over Drupal auth.**

- **Version:** 2.0.x (info.yml `2.0.0`)
- **Core:** ^10 || ^11 ; depends `user`, `block`, `path_alias`
- **Configure:** `www_authenticate.settings` — `/admin/config/system/www-authenticate` (`administer www_authenticate`, restrict access).
- **Log:** `/admin/reports/www-authenticate-log` (`view www_authenticate log`, restrict access).
- **Enforcement:** `WwwAuthenticateSubscriber` on kernel `REQUEST` → `WwwAuthenticateService::isAuthRequired()` → `extractCredentials()` → `validateCredentials()`; 401 + `WWW-Authenticate` header on failure.
- **Security posture:** This is an **add-on shield**, not a replacement for Drupal auth — bypassing it leaves core access control intact. Observations:
  - `validateCredentials()` compares with `===`, not `hash_equals` (`src/Service/WwwAuthenticateService.php`) → non-constant-time compare (minor timing side-channel).
  - Credential pairs stored plaintext in `www_authenticate.settings`.
  - `bypass_api` (opt-in): `isApiRequest()` exempts any request whose `Accept` header contains `application/json` → broad shield bypass if enabled.
  - IP allowlist relies on `Request::getClientIp()` (trust proxy config matters).
  - Admin/log routes are permission-gated with `restrict access: true`.

See [configure/settings.md](configure/settings.md)
