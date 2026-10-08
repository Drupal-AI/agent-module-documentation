# Theming the auth pages

Better Login is entirely templates + hooks in `betterlogin.module`. There is nothing to configure.

## The four templates

Registered by `hook_theme()` and shipped in the module's `templates/`:

| Theme hook | Template | Page |
|---|---|---|
| `page__user__login` | `page--user--login.html.twig` | `/user/login` |
| `page__user__register` | `page--user--register.html.twig` | `/user/register` |
| `page__user__password` | `page--user--password.html.twig` | `/user/password` |
| `page__user__reset` | `page--user--reset.html.twig` | `/user/reset` |

Each is preprocessed by `betterlogin_preprocess_betterlogin()`, which sets these Twig variables:

- `site_name` — from `system.site:name`.
- `logo` — from the active theme's logo (`theme_get_setting('logo.url')`).
- `title` — the page title.
- `register_url` — the URL of `user.register`, **only set when that route is accessible** to the
  current (anonymous) visitor. So the "Register a new account" link shows only when public
  registration is allowed (`user.settings:register` ≠ `admin_only`).

## The hooks

- `betterlogin_form_alter()` — on `user_login_form`, `user_register_form`, `user_pass`,
  `user_pass_reset`: sets `autofocus` on the name field, unsets the name/password `#description`,
  and attaches `#attached['library'][] = 'betterlogin/betterlogin_css'`.
- `betterlogin_preprocess_html()` — sets the `<title>` to Login / Forgot your password? /
  Register / Reset password depending on the path.
- `betterlogin_local_tasks_alter()` — removes the `user.login`, `user.register`, `user.pass`
  local task tabs.
- Event subscriber `BetterLoginSubscriber` (priority 33 on `KernelEvents::REQUEST`) — redirects an
  anonymous request carrying a `?user=` query parameter to `user.login` with `destination=user`.

## Overriding the look

Two options, no admin UI:

1. **CSS only** — the library `betterlogin/betterlogin_css` loads `css/betterlogin.css`; override
   those styles in your theme.
2. **Markup** — copy `page--user--login.html.twig` (etc.) from the module's `templates/` into your
   theme's templates directory and edit; the theme copy wins. Rebuild caches after adding a template.

## Notes for an agent

- `configure` is null; do not look for a settings form. Enabling the module is the entire setup.
- The register-link visibility is driven by core `user.settings:register`, not by any module config.
