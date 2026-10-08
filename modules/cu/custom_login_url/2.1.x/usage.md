<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom Login Url relocates Drupal's `/user/*` account routes (including the login form) to a secret base path you define in `settings.php`, so automated bots hitting the default `/user` login endpoint get a 404 instead.

---

This is a small security-through-obscurity module with no admin UI and no config entity — the secret path is set entirely via `$settings['custom_login_pattern']` in `settings.php` (default `/user/`, i.e. unchanged). A `RouteSubscriber` (`RouteSubscriberBase::alterRoutes`) rewrites every route whose path starts with `/user/` to start with your custom pattern instead, and repoints the `user.login` route's path to the pattern without its trailing slash. So with `custom_login_pattern = 'my_login_url/'`, the login form moves to `/my_login_url/login` and the account pages to `/my_login_url/*`. The pattern must be non-empty and is normalized to always end in a slash (a `CustomLoginSlashEndException` is caught internally to append one; an empty pattern or bare `/` throws). A `KernelSubscriber` on the `KernelEvents::EXCEPTION` event (priority 100) turns the `user.page` route into a hard `NotFoundHttpException`, so the old `/user` canonical no longer redirects and leaks nothing. A `TemplateSuggestions` hook keeps the normal `page__user` / `page__user__login` template suggestions on the relocated login and canonical user pages so theming still applies. Note this only hides the path — it is not authentication hardening: anyone who learns the secret path reaches the normal login form, and the change is invisible to config export (it lives in settings.php). Combine with real controls (rate limiting, flood control, 2FA) for genuine protection.

---

- Move the admin/login form off the well-known `/user` path to cut automated brute-force and credential-stuffing noise.
- Set a per-environment secret login path in `settings.php` (different on dev/staging/prod).
- Serve a 404 on the default `/user` and `/user/login` so scanners can't confirm a Drupal login exists there.
- Relocate all `/user/*` account routes (login, password reset, register, profile) behind one custom prefix.
- Keep the login path out of exported configuration (it lives only in settings.php).
- Reduce log spam from bots hammering the default login endpoint.
- Add a lightweight obscurity layer on top of flood control / rate limiting.
- Give a client a "hidden admin URL" they can share only with staff.
- Change the login path without touching the database or clearing content.
- Preserve login/user page theming (template suggestions) after moving the path.
- Rotate the secret login path quickly after a suspected exposure by editing one setting.
- Differentiate login URLs across multiple sites in a multisite codebase.
- Prevent the old `/user` canonical from redirecting authenticated-user probes.
- Pair with a WAF/edge rule that only allows the secret path through.
- Stop opportunistic `/user/login` POST attacks that never learn the new path.
- Provide a minimal, dependency-free alternative to heavier login-security suites.
- Enforce that the configured pattern ends in a slash automatically (no misconfiguration 500s).
- Use as a deployment convention so every site has a non-default, documented login path.
