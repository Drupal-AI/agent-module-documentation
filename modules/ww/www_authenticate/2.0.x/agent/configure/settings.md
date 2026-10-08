<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WWW Authenticate — configuration & enforcement

**Settings:** `/admin/config/system/www-authenticate`
(`WwwAuthenticateSettingsForm`, `administer www_authenticate`).
**Log:** `/admin/reports/www-authenticate-log` (`view www_authenticate log`).

## Decision order (`WwwAuthenticateService::isAuthRequired()`)
1. `enabled` off → no auth.
2. `maintenance_mode_only` and site not in maintenance → no auth.
3. `allow_cli` / `allow_drush` / `allow_cron` bypasses.
4. `bypass_api` → `isApiRequest()` (paths `/jsonapi/`,`/rest/`,`/api/` **or**
   `Accept`/`Content-Type` containing `application/vnd.api+json` **or**
   `Accept` containing `application/json`) → bypass. **Broad** — avoid on
   sensitive sites.
5. IP allowlist match → bypass; IP denylist match → force auth.
6. Role bypass: logged-in user with a role in `bypass_roles` → bypass.
7. `time_restriction_enabled` and outside window → force auth.
8. Path rules: settings + log pages always excluded; then `path_mode`
   `include` (only listed protected) or `exclude` (all but listed).

## Credentials
- `credentials` — list of `{username, password}` pairs, **plaintext in config**.
- Read from `PHP_AUTH_USER`/`PHP_AUTH_PW` or parsed `Authorization: Basic`.
- `validateCredentials()` uses strict `===` (not `hash_equals`) — not
  constant-time; acceptable for a shared shield but note the side-channel.

## Notes for agents
- This shield is **additive**; it never replaces Drupal's login/authentication.
- IP rules depend on `Request::getClientIp()` — ensure reverse-proxy/trusted-host
  settings are correct or allowlisting can be spoofed via forwarded headers.
- Logging (`logging_enabled`) writes to `www_authenticate_log`, trimmed to
  `log_max_entries`.
