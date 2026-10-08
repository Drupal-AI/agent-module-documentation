<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Route & UX alterations

How the module rewires core's login/reset routes and cleans up the surrounding UI. Three moving
parts: a route subscriber, a kernel-request redirect subscriber, and a hook class. Plus one custom
route defined in `dripyard_simple_login.routing.yml`.

## Custom route — `dripyard_simple_login.routing.yml`

- `dripyard_simple_login.login_password` — path `/login-password`,
  `_form: '\Drupal\user\Form\UserLoginForm'` (core's standard username/password form),
  `_title: 'Log in with password'`, requirement `_user_is_logged_in: 'FALSE'`,
  options `_maintenance_access: TRUE`, `no_cache: TRUE`. This is the password fallback the
  magic-link form's "Use password" button redirects to.

Note: the file's header comment says `user.pass` is "blocked (requirement set to FALSE)". That
comment is inaccurate — nothing in this module sets a FALSE requirement on `user.pass`; the block is
implemented as a redirect (see `PassRedirectSubscriber` below).

## `RouteSubscriber` — `src/Routing/RouteSubscriber.php`

`extends RouteSubscriberBase`, registered as `event_subscriber`. `alterRoutes(RouteCollection)`:

- **`user.reset.login`** → `_controller` set to
  `'\Drupal\dripyard_simple_login\Controller\UserResetController::resetPassLogin'`, `_title` set to
  `'Logging you in...'`. (Only the controller/title change; access + params stay core's.)
- **`user.login`** → `setPath('/login')`, `_form` set to
  `'\Drupal\dripyard_simple_login\Form\MagicLinkLoginForm'`, `_title` `'Log in'`.

It does **not** modify `user.pass` at all.

## `PassRedirectSubscriber` — `src/EventSubscriber/PassRedirectSubscriber.php`

`implements EventSubscriberInterface`; DI: `current_route_match`, `messenger`, `string_translation`.
Subscribes to `KernelEvents::REQUEST` at **priority 31**. In `onKernelRequest()`:

- if the matched route name is **`user.pass`**, it builds `Url::fromRoute('user.login')`, sets a
  warning message ("To set or reset a password for login, use the 'send login link' form…"), and
  responds with a `RedirectResponse(..., HTTP_MOVED_PERMANENTLY)` (301) to the login form.

This is a fixed internal route redirect (`Url::fromRoute`), not a user-supplied destination, so the
standard "request new password" page is simply funneled to `/login`.

## `DripyardSimpleLoginHook` — `src/Hook/DripyardSimpleLoginHook.php`

`final class` using core's `#[Hook(...)]` attribute hooks (no `.module` file):

- `#[Hook('local_tasks_alter')]` `menuLocalTasksAlter()` — `unset($local_tasks['user.pass'])` so the
  "Request new password" tab no longer appears on the login page.
- `#[Hook('gin_login_route_definitions_alter')]` `ginLoginRouteDefinitionsAlter()` — registers
  `dripyard_simple_login.login_password` with Gin Login (`page__user__login` template +
  `gin_login_preprocess_ginlogin`) so the password page gets the same styled treatment as `/login`.
- `#[Hook('theme_suggestions_page_alter')]` `themeSuggestionsPageAlter()` — adds the
  `page__user__login` suggestion when on the `dripyard_simple_login.login_password` route.
- `#[Hook('form_alter')]` `formAlter()` — for `user_login_form` on the `login_password` route only,
  adds `button--primary` / `button-login` classes to the submit button.

The three Gin-related hooks are purely cosmetic and only take effect when the Gin Login module/theme
is present; they have no functional impact on authentication.
