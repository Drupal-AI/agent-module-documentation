# Templates & login theming

**Theme switch:** service `gin_login.theme.negotiator` (`Theme\ThemeNegotiator`, tagged
`theme_negotiator` priority 1000) forces the login-family routes to render with the Gin theme.
`_gin_login__check_path()` gates all the styling so it only applies on those routes.

**Templates** (in `templates/`, registered dynamically by `gin_login_theme()` from the route
definitions returned by the `gin_login.route` service):

| Template | Page |
|---|---|
| `page--user--login.html.twig` | `/user/login` |
| `page--user--register.html.twig` | `/user/register` |
| `page--user--password.html.twig` | `/user/password` |
| `page--user--logout-confirm.html.twig` | logout confirm |
| `page--user--general.html.twig` | other user auth pages |

Override any of these by copying it into your theme. `gin_login_theme()` builds the theme
registry entries `page__user__login` etc. from `GinLoginRouteService::getLoginRouteDefinitions()`,
so new definitions added via the alter hook automatically get a template + preprocess wired up.

**Attached assets** (`gin_login_page_attachments_alter`): library `gin_login/login` (CSS,
weight -99) always; `gin_login/wallpaper` (JS, depends on `core/once`) when a default random
wallpaper is used. When Gin is active it also attaches `gin/gin_init`, `gin/gin`,
`gin/gin_accent`, optional `gin/gin_custom_css`, and exposes Gin's darkmode/accent/focus/
high-contrast values to `drupalSettings`.

**Form tweaks** (`gin_login_form_alter`): adds a `more-links` container with "Create new
account" and "Forgot your password?" on login, a "Log in" back-link on register/password,
relabels the password form submit to "Reset", and marks the submit button `button--primary`.
`gin_login_preprocess_html` adds the `gin-login` body class plus Gin accent/focus/contrast
attributes.
