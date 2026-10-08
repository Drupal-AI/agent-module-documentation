# Nice Login — theming & form alters

All logic lives in `nice_login.module` (no `src/`). It affects only the three core account routes.

## Theme hooks (`hook_theme`)
Three render-element theme hooks, each with a matching template:

| Theme hook | Template | Applied to form |
|---|---|---|
| `nice_login__login` | `templates/nice-login--login.html.twig` | `user_login_form` |
| `nice_login__pass` | `templates/nice-login--pass.html.twig` | `user_pass` |
| `nice_login__register` | `templates/nice-login--register.html.twig` | `user_register_form` |

Each template receives the standard `form` render element. Override by copying the template into
your theme (Drupal's normal theme override rules) — no theme suggestion machinery needed.

## What each form alter does
`hook_form_FORM_ID_alter()` for each form:
- sets `$form['#theme']` to the matching hook above;
- wraps the form: `#prefix = '<div class="wrapper-nice-login <state>-form">'`, `#suffix = '</div>'`
  (state class: `login-form`, `reset-password-form`, `create-account-form`);
- attaches `$form['#attached']['library'][] = 'nice_login/form'` (loads `css/nice_login.css`).

Injected links (built with `Link::createFromRoute`, each given `class` attributes):
- **login form**: `reset_password_link` → `user.pass` (classes `nice-login nice-login-reset-password`);
  `register_link` → `user.register` (classes `nice-login nice-login-create-account`), with
  `#access = (user.settings:register !== REGISTER_ADMINISTRATORS_ONLY)` so it hides when
  self-registration is off.
- **pass form**: `login_link` → `user.login`.
- **register form**: `login_link` → `user.login`, prefixed with the text "You have already an account?".

## Removing the tabs
`hook_preprocess_block()` sets `$variables['content'] = []` for the `local_tasks_block` plugin when
the current route is `user.login`, `user.pass` or `user.register` — this blanks the Login/Reset/Create
tabs on those pages only. If your theme renders local tasks by another mechanism, hide them there too.

## Library / CSS
`nice_login.libraries.yml` defines one library `form` with `css/nice_login.css` (theme layer). The CSS
is intentionally minimal; the README expects you to style `.wrapper-nice-login` in your active theme
(e.g. add column/flex rules to center the form).
