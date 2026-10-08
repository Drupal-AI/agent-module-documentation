<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Login page, Connected Accounts & logout flow

## Login form theming & button/help alters (`cilogon_globus_auth.module`)

- `hook_theme()` registers `form__user_login_form` → `templates/form--user-login-form.html.twig`;
  `hook_theme_suggestions_form_alter()` adds the suggestion for `user_login_form`. The template
  renders an "OR" divider and a collapsible **"Sign in with a local account"** section (local
  username/password form hidden by default). openid_connect prints the SSO buttons before this
  template via the form `#prefix`.
- `hook_form_user_login_form_alter()` attaches the JS library `cilogon_globus_auth/login-toggle`
  (`.libraries.yml` → `js/login-toggle.js` + `css/login.css`, deps `core/drupal`, `core/once`). The
  behavior `cilogonGlobusAuthLoginToggle` reveals the local form on button click, and auto-expands it
  if it contains a `.error` (so validation errors are visible).
- `hook_form_openid_connect_login_form_alter()` iterates the SSO submit buttons
  (`openid_connect_client_*`): sets each label from `button_texts[client]` or `button_text_default`
  (with `@client_title` = the client's label, via `TranslatableMarkup`); styles the Globus button
  (`ospgascigw`) as `#button_type = 'primary'`; and prepends rendered help text
  (`login_help_texts[client]` or the global `login_help`) via `#type => processed_text` wrapped in
  `<div class="cilogon-globus-auth-help">`. Merges the config cache tags so the form invalidates when
  settings change.

## Connected Accounts (`src/Form/OSPOpenIDConnectAccountsForm.php`)

- Route `openid_connect.accounts_controller_index` → `/user/{user}/connected-accounts`, custom access
  `\Drupal\openid_connect\Form\OpenIDConnectAccountsForm::access` (inherited from openid_connect).
- `OSPOpenIDConnectAccountsForm extends OpenIDConnectAccountsForm`: after the parent builds the form,
  rewrites each connected provider fieldset's status markup from "Connected as …" to
  **"Connected to {provider label}"** (label taken from the fieldset title, stripping the
  "Provider: " prefix).
- `hook_form_openid_connect_accounts_form_alter()` does the same for the base accounts form using the
  IdP name stored in the authmap `data` (`idp_name`), falling back to the authname.

## Logout flow

- `RouteSubscriber` (`src/Routing/RouteSubscriber.php`, priority **-300** so it runs after
  openid_connect): reroutes both `user.logout` and `openid_connect.logout` to
  `OSPLogoutController::logout`, and — when `hide_user_register` is set — sets `_access: 'FALSE'` on
  `user.register`.
- `OSPLogoutController::logout()` (`src/Controller/OSPLogoutController.php`): calls core
  `user_logout()` for an authenticated user, then redirects to `<front>` with `?logged-out=1`. It
  deliberately does **not** trigger an IdP end-session (federated apps end only their own session).
- `LogoutConfirmSubscriber` (`src/EventSubscriber/LogoutConfirmSubscriber.php`, services-injected):
  - `onRequest` (priority 30): for anonymous users, turns `?logged-out=1` into a "You have been
    logged out." status and `?logged-out=already` into "You are already signed out."
  - `onException` (priority 60): redirects an anonymous `AccessDeniedHttpException` on
    `user.logout`/`user.logout.confirm` (matched by route name or path) to `<front>` with
    `?logged-out=already`, avoiding a bare "Access denied" on stale logout clicks.
- `hook_openid_connect_redirect_logout_alter()`: for the Globus client (`ospgascigw`), rewrites the
  Globus web-logout redirect (`auth.globus.org`) from the OIDC-standard `post_logout_redirect_uri`
  into Globus's own `redirect_uri` + `redirect_name` params (site name), returning a
  `TrustedRedirectResponse` so the user lands back on the site (configured logout redirect or front
  page) after signing out of Globus.
