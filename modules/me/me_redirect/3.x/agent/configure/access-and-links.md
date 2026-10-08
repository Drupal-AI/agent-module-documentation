# Access and exposing `/me` links

There is **no settings form, config entity, or config schema** — the module works the moment it is
enabled. "Configuring" it means (a) understanding the access gate and (b) placing `/me` links where
you want them. Enable with `drush en me_redirect -y`.

## Who can use `/me`

- The route `me_redirect.me` requires the core **`access content`** permission (granted to
  Authenticated, and to Anonymous, by default).
- The controller adds the real gate: only a **logged-in** user (non-empty uid) is redirected;
  anonymous requests get **HTTP 403** (`AccessDeniedHttpException`). So in practice `/me` is an
  authenticated-only convenience.
- The redirect only ever points at the caller's **own** `/user/{uid}/…` page. It does **not** grant
  access to the target — the destination page (e.g. `/user/{uid}/edit`) enforces its own permissions.
  A user who cannot edit their own account is redirected to `/user/{uid}/edit` and then denied there
  by that route, exactly as if they had typed the URL.

There are no module-provided permissions to assign, and nothing at `/admin`.

## Exposing `/me` paths

Link to `/me` (or any `/me/<tail>`) wherever you would otherwise need the current user's account URL
but don't have their uid — menus, blocks, templates, body content, or even links from another site:

- Menu link: add a custom menu item with path `/me` or `/me/edit`.
- Block / template: hardcode `<a href="/me">My account</a>` — it resolves per logged-in user.
- Any `/me/<tail>` maps to `/user/{uid}/<tail>`, so `/me/edit`, `/me/cancel`, `/me/contact`, etc.
  all work if the corresponding `/user/{uid}/<tail>` route exists.

## Behavior notes

- Redirects are **302** (temporary) by design.
- Anonymous visitors following a `/me` link receive a 403 Access Denied response (the module throws
  `AccessDeniedHttpException`; whether that renders as a 403 page or a login redirect depends on your
  site's 403 handling, not on this module).
- Nothing to configure means nothing to export: the module contributes no config to
  configuration management.
