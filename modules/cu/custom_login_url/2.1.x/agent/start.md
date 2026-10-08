<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Login Url — agent index

Relocates Drupal's `/user/*` routes (incl. the login form) to a secret base path set in
`settings.php`, and 404s the default `/user`. Security-through-obscurity only; no UI, no config
entity, no permissions, no schema, no Drush. Depends on core `user`.

- **How to set the path and exactly which routes move** → [configure/settings.md](configure/settings.md)

Key facts:
- Configured ONLY via `$settings['custom_login_pattern']` in `settings.php` (default `/user/` = no
  change). Must be non-empty; auto-normalized to end with `/`. `configure` route is null.
- `Routing\RouteSubscriber::alterRoutes()` rewrites every route whose path starts with `/user/`
  to the custom pattern, and sets `user.login` path to the pattern minus its trailing slash.
  Example: pattern `secretlogin/` → login at `/secretlogin/login`.
- `KernelSubscriber` (on `KernelEvents::EXCEPTION`, priority 100) forces a `NotFoundHttpException`
  for the `user.page` route so the old `/user` no longer redirects/leaks.
- `Hook\TemplateSuggestions` re-adds `page__user` / `page__user__login` suggestions on the moved
  pages so theming is preserved.
- NOT authentication hardening — only hides the path. Pair with flood control / rate limiting / 2FA.
- Legacy note: `hook_help` still references an old machine name (`user_pass_refresh_security`); cosmetic only.
