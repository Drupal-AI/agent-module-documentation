<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring redirect_anonymous_users

## Route / access
- Settings form: `/admin/people/redirect_anonymous_users/settings` (route `redirect_anonymous_users.settings`).
- Requires permission `administer redirect_anonymous_users configuration`.

## The exclusion list
- Field **Routes to Exclude**: one Drupal **route name** per line (e.g. `user.pass`, `user.register`, `entity.node.canonical`).
- Validation rejects any value containing `/` — these are route *names*, not URL paths. Find route names with `drush route` / Devel's Router info.
- On save the module stores both the raw text (`routes_to_exclude`) and a whitespace-split array (`routes_to_exclude_split`) in `redirect_anonymous_users.settings`.

## Behaviour
- On every request, `RedirectAnonymousSubscriber::checkAuthStatus()` checks: anonymous AND route != `user.login` AND route not in the exclusion list → `302` redirect to `user.login`.
- `user.login` is always reachable even if not listed.
- The subscriber redirects POST requests too and does not auto-exempt system routes, so add every route anonymous users legitimately need (password reset, registration, REST/JSON:API, cron, well-known files) or those flows break.

## Typical recipe (make a site private)
1. `drush en redirect_anonymous_users`.
2. Open the settings form, exclude at least `user.pass` and (if wanted) `user.register`.
3. Add any anonymous API/webhook route names.
4. Save; verify an anonymous browser is bounced to `/user/login`.
