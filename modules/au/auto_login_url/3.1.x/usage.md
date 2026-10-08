<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Auto Login URL generates cryptographically signed, time-limited URLs that log a specific user in without a password, then redirect to any destination. URLs are minted in code (`auto_login_url_create()`), via Drupal tokens, or from an admin form.

---

The module exposes a public route `/autologinurl/{uid}/{hash}`; hitting it with a valid token calls `user_login_finalize()` for that uid and redirects to the stored destination. Tokens are not guessable: `create()` builds each token as `substr(Crypt::hmacBase64($entropy, $key), 0, token_length)` where `$entropy` is `random_bytes(32)` plus uniqid/pid/time, and `$key = Settings::getHashSalt() . <module secret> . <user password hash>`; only a second HMAC of the token (`hmacBase64($token, $key)`) is stored in the `auto_login_url` DB table, and login re-derives that DB hash and looks it up by `uid`+`hash`. Because the user's current password hash is mixed into the key, changing a password invalidates all of that user's outstanding URLs. Each URL carries a creation timestamp and expires after a global `expiration` (default 30 days) or a per-URL `custom_expiration`; URLs can be single-use (`delete`/`one_time_use`), IP-locked (`validate_ip_address`), and creation is rate-limited per user (`max_urls_per_user_per_hour`, default 10) while login attempts are flood-protected per IP using core `user.flood` limits. The module secret is auto-generated with `random_bytes(48)` on first use and stored in config. Configuration lives at `/admin/people/autologinurl`; an admin UI also generates, lists, views, and bulk-deletes URLs, plus a usage-analytics table and a health-check endpoint. Two permissions (`administer auto login url`, `use auto login url`) are both `restrict access: true`. With the Token module, `[user:auto-login-url-token]` and `[user:auto-login-url-account-edit-token]` render ready-made login links for email templates. `hook_cron` prunes expired tokens, old rate-limit state, and analytics older than 6 months.

---

- Email an existing user a one-click login link to their account (`[user:auto-login-url-token]`).
- Send a "finish setting up your account" link to a freshly created user without a temporary password.
- Build a passwordless email-campaign link that drops the recipient onto a dashboard already logged in.
- Generate a short-lived (e.g. 5-minute), single-use link for a password-reset-style flow.
- Create a long-lived reusable link for a trusted internal integration.
- Hand off an authenticated session from a mobile app or external system into the Drupal site.
- Redirect the user to an arbitrary internal path (`user/123/edit`, `/dashboard`) after auto login.
- Redirect the user to an external URL after login via a trusted redirect.
- Convert every site URL inside a block of email text to a per-user auto-login URL (`auto_login_url_convert_text()`).
- Programmatically mint a login URL for a user from custom code, catching `AutoLoginUrlException` on failure.
- Override expiration and single-use behaviour per URL instead of using the global defaults.
- Lock a generated URL to the IP address that created it for higher-security scenarios.
- Rate-limit how many auto-login URLs each user can create per hour to curb abuse.
- Automatically invalidate a user's outstanding login links whenever their password changes.
- Generate a login URL for a user through the admin form at `/admin/people/autologinurl/generate`.
- Review, view, and bulk-delete expired auto-login URLs from the admin UI.
- Track and report how often auto-login URLs are used via the usage-analytics table.
- Expose a health-check endpoint (`/admin/reports/auto-login-url/health`) for uptime monitoring.
- Regenerate the module secret to invalidate every outstanding URL at once.
- Automatically clean up expired tokens and stale analytics with cron.
- Check whether a user is currently within their creation rate limit before minting (`auto_login_url_user_can_create()`).
- Pull per-user statistics (active URLs, total created, remaining attempts, usage count).
