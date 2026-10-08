<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Maintenance VIP Bypass

Allows chosen visitors to view a site that is in maintenance mode by visiting `/vip/<secret-token>`, which grants a cookie that a decorated maintenance-mode service honours.

- Decorates the core `maintenance_mode` service.
- Grants access via a signed cookie, not a role.
- Uses a configurable secret token in the URL.
- Provides a logout route to drop the cookie.

---

# Installing & configuring

- Enable the module (`drush en maintenance_vip`).
- Set the secret token and pass duration at `/admin/config/development/maintenance-vip`.
- Settings require `administer maintenance vip` (restricted permission).
- Token is stored in `maintenance_vip.settings` (`vip_token`).
- Share the `/vip/<token>` URL only with intended VIPs.

---

# Usage & behaviour

- `/vip/{token}` (`VipController::grantAccess`) is `_access: TRUE` and `_maintenance_access: TRUE`.
- It compares `$token !== $valid_token || empty($valid_token)` and throws 503 on mismatch/empty.
- An empty configured token cannot be bypassed (the empty check throws first).
- On success it sets an HttpOnly, secure-aware `Drupal_VIP_Access` cookie for 24h.
- A page-cache request policy prevents caching for cookie holders.
- The decorated maintenance-mode service treats cookie holders as exempt.
- `/vip-logout` clears the VIP cookie and returns to the front page.
- The redirect uses `TrustedRedirectResponse` with max-age 0.
- The token is a shared secret placed in the URL path (bearer-style).
- Comparison is exact (`!==`) but not constant-time; choose a long random token.
- Anyone with the token URL gets 24h of bypass, so treat it like a password.
- No user account is required to redeem the token.
- Only the maintenance bypass is affected; normal access control is untouched.
- The settings route is admin-only.
- Uninstalling removes the decorator and cookie policy.
- Suitable for previewing a site during scheduled maintenance windows.
