<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Me Redirect (me_redirect) — agent index

Gives the site a stable `/me` URL space that 302-redirects the **current** user to their own
`/user/{uid}` account pages. A single route `me_redirect.me` (`/me/{user_path}`) sends every request
under `/me/...` to `MeController::me`, which reads the user id from `\Drupal::currentUser()->id()`
(session-derived, never from request input), builds `/user/{uid}[/{tail}]`, and returns a
`RedirectResponse(..., 302)`. Anonymous users (empty uid) get an `AccessDeniedHttpException` (403).
So `/me` → `/user/123`, `/me/edit` → `/user/123/edit`, `/me/edit/foo` → `/user/123/edit/foo`.

Because Drupal routing can't capture a slash-containing tail in a single `{user_path}` parameter, an
inbound **path processor** service (`me_redirect.path_processor`, tag `path_processor_inbound`,
priority 250) rewrites `/me/a/b/c` into `/me/a:b:c` before routing; the controller then swaps the
colons back to slashes when rebuilding the destination. The redirect target is always literally
prefixed with `/user/{uid}/`, so it stays same-origin and can only ever point at the caller's own
account — there is no request-supplied destination and no request-supplied uid.

- Depends on: nothing (`dependencies` absent in info.yml). Core: `^10 || ^11`. Package: `Other`.
- No settings page / `configure` route, no config schema, no config entities — nothing to configure.
- Provides **no** permissions; the route is gated by the core `access content` permission and the
  controller's own logged-in check. No drush commands, no plugin types, no hooks, no fields, no libraries.
- Surface is one route + one controller + one inbound path-processor service.

## What you'd do → where

- **Understand/enable access, expose `/me` links (menu, block, content), the 302 & anonymous behavior** →
  [configure/access-and-links.md](configure/access-and-links.md)
- **The route, controller method, path processor and how `/me/*` resolves to `/user/{uid}/*`** →
  [api/routing.md](api/routing.md)

## Key facts (real machine names)

- Route: `me_redirect.me` — path `/me/{user_path}`, default `user_path: ''`, requirement
  `_permission: 'access content'`, `_controller: '\Drupal\me_redirect\Controller\MeController::me'`.
- Controller: `Drupal\me_redirect\Controller\MeController::me($user_path)` (`src/Controller/MeController.php`)
  — `RedirectResponse('/user/' . currentUser()->id() . '/' . $user_path, 302)`; anonymous → `AccessDeniedHttpException`.
- Service: `me_redirect.path_processor` → `Drupal\me_redirect\PathProcessor\MePathProcessor`
  (`InboundPathProcessorInterface`), tagged `path_processor_inbound` priority `250`. Rewrites `/me/a/b`
  to `/me/a:b` (slashes → colons) so one route param captures the whole tail.
- No permissions, no config keys, no services other than the path processor, no drush, no plugins.
