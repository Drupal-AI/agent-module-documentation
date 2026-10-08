Disable Login Page blocks anonymous access to Drupal's `/user/login` page unless the request carries a configured secret key/value querystring, so bots and the public cannot reach the login form.

---

The module adds a route access check to `user.login` (and `user.login.http`) via a `RouteSubscriber` and a tagged access-check service. When protection is enabled, the checker (`DisableLoginAccessCheck`) reads three values from the `disable_login.settings` config object — `disable_login` (on/off), `querystring` (the parameter *name*) and `secret` (the required *value*) — and returns *forbidden* for the login page unless the incoming request has `?<querystring>=<secret>`. So with `querystring=key` and `secret=abc123`, `/user/login` gives Access Denied but `/user/login?key=abc123` shows the form. The secret can be altered at runtime by other modules through `hook_disable_login_key_alter(&$secret)`, letting you rotate keys (e.g. per month) programmatically; the settings form shows the altered value when a hook changes it. Settings live at *Configuration → Security → Disable Login Page* (route `disable_login.settings_form`, path `/admin/config/security/disable-login`, permission *administer site configuration*). The module ships **no default config**, so until you save the form or write config, protection is off. A commented `return TRUE;` in the access checker is documented as the manual escape hatch if you lock yourself out. It has no permissions of its own, no Drush, and no plugins.

---

- Hide the `/user/login` page from anonymous visitors on a corporate site or personal blog with no public sign-up.
- Require a secret bookmarkable URL (`/user/login?key=secret`) for staff to reach the login form.
- Cut brute-force and credential-stuffing attempts by making the login form unreachable without the key.
- Reduce login-form spam and bot traffic on the standard Drupal login route.
- Give editors a private login link while the public sees Access Denied at `/user/login`.
- Choose your own querystring parameter name (e.g. `?entry=` instead of `?key=`).
- Set and change the secret value from a simple settings form without code.
- Rotate the secret key programmatically (e.g. monthly) with `hook_disable_login_key_alter()`.
- Integrate an external secret source (env var, KMS) by altering the key in custom code.
- Add a light layer of security-through-obscurity in front of the login page.
- Protect both the HTML login form and the `user.login.http` route in one step.
- Turn protection on or off per environment by toggling the `disable_login` config flag.
- Ship the login-protection config in a feature/recipe for consistent deployment.
- Keep the site's admin/login entry point out of automated vulnerability scanners' reach.
- Provide a "secret door" login for a members-only intranet.
- Combine with other security modules (flood control, 2FA) as an additional gate.
- Recover from a lockout using the module's documented escape hatch (uncomment `return TRUE;`).
- Present a custom Access Denied experience for unauthorised login attempts.
- Prevent drive-by discovery of the login page by search engines and scrapers.
- Enforce that only people who know the key/value pair can even see the login form.
- Use different key/value pairs across multisite instances for per-site login URLs.
- Audit who has the login link by controlling distribution of the secret bookmark.
- Quickly disable public login during an incident by enabling protection with a fresh secret.
