Disable Login Page blocks anonymous access to Drupal's `/user/login` (and the `user.login.http` REST route) unless the request carries a configured secret key/value querystring, so bots and the public cannot reach the login features.

---

The module adds a route access check to `user.login` and `user.login.http` via `DisableLoginRouteSubscriber` (which sets the `disable_login_access_check` requirement on both routes) and the tagged access-check service `DisableLoginAccessCheck`. When protection is enabled, the checker reads four values from the `disable_login.settings` config object — `disable_login` (master on/off), `allow_secret` (whether a secret bypass is permitted at all), `querystring` (the parameter *name*) and `secret` (the required *value*). If `disable_login` is off the login page works normally; if it is on and `allow_secret` is off the login page is forbidden outright with no way in via URL; if it is on and `allow_secret` is on the page is forbidden unless the request has `?<querystring>=<secret>`. The comparison uses `hash_equals()` (constant-time), and failed key attempts are rate limited per client IP through the core flood service (`user.flood` `ip_limit`/`ip_window`, flood event `disable_login.failed_key_ip`) so the key cannot be brute forced — once an IP hits the limit the page stays blocked for the rest of the window even with the correct key. The secret can be altered at runtime by other modules through `hook_disable_login_key_alter(&$secret)`, letting you rotate keys programmatically; the settings form displays the altered value when a hook changes it. Settings live at *Configuration → Security → Disable Login Page* (route `disable_login.settings_form`, path `/admin/config/security/disable-login`, permission *administer site configuration*). The module ships **no default config**, so until you save the form protection is off. The module has no permissions of its own, no Drush commands, and no plugins.

---

- Hide the `/user/login` page from anonymous visitors on a corporate site or personal blog with no public sign-up.
- Require a secret bookmarkable URL (`/user/login?key=secret`) for staff to reach the login form.
- Block the login form entirely (no URL bypass) by enabling protection with the secret override turned off.
- Cut brute-force and credential-stuffing attempts by making the login form unreachable without the key.
- Rate-limit guessing of the secret key per IP so attackers cannot brute force the querystring value.
- Reduce login-form spam and bot traffic on the standard Drupal login route.
- Give editors a private login link while the public sees Access Denied at `/user/login`.
- Choose your own querystring parameter name (e.g. `?entry=` instead of `?key=`).
- Set and change the secret value from a simple settings form without code.
- Rotate the secret key programmatically (e.g. monthly) with `hook_disable_login_key_alter()`.
- Integrate an external secret source (env var, key store) by altering the key in custom code.
- Protect both the HTML login form and the `user.login.http` REST route in one step.
- Turn protection on or off per environment by toggling the `disable_login` config flag.
- Ship the login-protection config in a feature/recipe for consistent deployment.
- Keep the site's login entry point out of automated vulnerability scanners' reach.
- Provide a "secret door" login for a members-only intranet.
- Combine with other security modules (2FA, password policy) as an additional gate.
- Recover from a lockout by disabling protection via drush config-set or uninstalling the module.
- Prevent drive-by discovery of the login page by search engines and scrapers.
- Enforce that only people who know the key/value pair can even see the login form.
- Use different key/value pairs across multisite instances for per-site login URLs.
- Audit who has the login link by controlling distribution of the secret bookmark.
- Quickly restrict public login during an incident by enabling protection with a fresh secret.
- Add a hardened, constant-time secret check in front of the login page without custom code.
