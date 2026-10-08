# SspHandler service and the login / return / logout flow

The module is glue between Drupal's session and a co-hosted SimpleSAMLphp IdP. Its moving parts:

- Service **`drupalauth4ssp.ssp_handler`** → `Drupal\drupalauth4ssp\SspHandler`
  (`@config.factory`, `@path.matcher`, `@request_stack`).
- Service **`drupalauth4ssp.event_subscriber`** → `EventSubscriber\DrupalAuthForSSPSubscriber`
  (`@current_user`, `@drupalauth4ssp.ssp_handler`).
- Controller `Controller\RedirectController` (route `drupalauth4ssp.redirect`).
- Procedural hooks in `drupalauth4ssp.module`.

`RedirectController::SESSION_PARAM = 'drupalauth4ssp.ReturnTo'` — the session key used to carry a
`ReturnTo` across a two-factor-authentication (TFA) detour.

## SspHandler public methods

| Method | Returns | Behavior |
|---|---|---|
| `returnPathIsAllowed(string $path)` | `bool` | `$this->pathMatcher->matchPath($path, implode(PHP_EOL, $config->get('returnto_list')))`. The one allowlist gate for every `ReturnTo`. |
| `getSspBasePath()` | `string` | `SimpleSAML\Configuration::getInstance()->getBasePath()`. |
| `saveIdToState($id, $stateId)` | `void` | Loads the SimpleSAMLphp auth state (`SimpleSAML\Auth\State::loadState($stateId, External::DRUPALAUTH_EXTERNAL, TRUE)`), sets `$state[External::DRUPALAUTH_EXTERNAL_USER_ID] = $id`, and `State::saveState()`. This is how the authenticated Drupal **user ID** is handed to the SimpleSAMLphp `drupalauth` `External` authsource so `External::resume()` can complete the SAML assertion. |
| `saveIdToStat($id, $stateId)` | — | **Deprecated** in 2.1.0 (removed in 3.0.0); a typo'd alias that triggers `E_USER_DEPRECATED` and delegates to `saveIdToState()`. |
| `logout()` | `void` | Expires the SimpleSAMLphp session (see logout flow below). |

`External` is `SimpleSAML\Module\drupalauth\Auth\Source\External`, from the required
`drupalauth/simplesamlphp-module-drupalauth` SimpleSAMLphp module.

## Login → return-to-SP flow

1. An SP sends the user to the SimpleSAMLphp IdP; the `drupalauth` `External` authsource
   redirects the browser to Drupal's `user.login` with a `?ReturnTo=<resume URL>`, where the
   resume URL itself carries a `?State=<ssp state id>`.
2. `drupalauth4ssp_form_user_login_form_alter()` appends `drupalauth4ssp_user_login_submit` to
   the login form's `#submit` handlers.
3. On successful login `hook_user_login` (`drupalauth4ssp_user_login`) runs: it reads `ReturnTo`
   (from `query` normally, or from the session `SESSION_PARAM` when `tfa` is enabled and that
   key is set), and if `returnPathIsAllowed($returnTo)` it parses the `State` out of the
   `ReturnTo` URL and calls `saveIdToState($account->id(), $stateId)` — binding the just-logged-in
   Drupal account to the SSP state.
4. `drupalauth4ssp_user_login_submit()` then sets the post-login redirect:
   - If the form is already redirecting to `tfa.entry` or `tfa.overview`, it stashes `ReturnTo`
     in the session (`SESSION_PARAM`) and does **not** interfere with the TFA redirect.
   - Otherwise, if `\Drupal::currentUser()->isAuthenticated()` **and**
     `returnPathIsAllowed($returnTo)`, it `$form_state->setRedirectUrl(Url::fromUri($returnTo))`
     — sending the browser back to the SSP resume URL, which completes the assertion.
5. **Already-logged-in (cookie) case:** if an authenticated user hits `user.login?ReturnTo=…`,
   there is no form submit, so `DrupalAuthForSSPSubscriber::saveIdToState()` handles it on
   `KernelEvents::RESPONSE`: when `_route === 'user.login'`, the response is a 302, and a
   `ReturnTo` is present, it extracts `State`, calls `SspHandler::saveIdToState(current uid, state)`,
   `setTargetUrl($returnTo)`, and `stopPropagation()`.

## TFA detour

- `drupalauth4ssp_form_tfa_entry_form_alter()` adds `drupalauth4ssp_tfa_entry_submit`, which after
  a successful TFA code redirects to the stored `SESSION_PARAM` `ReturnTo` (if allowed) and clears
  it.
- `drupalauth4ssp_form_tfa_base_overview_alter()` — when TFA setup interrupted the journey and the
  user is now TFA-ready (`TfaUserController::isReady()`), it shows a status message linking route
  `drupalauth4ssp.redirect` so the user can resume.
- `RedirectController::redirectToServiceProvider()` (route `drupalauth4ssp.redirect`,
  `_user_is_logged_in: 'TRUE'`): reads `SESSION_PARAM`; if present and `returnPathIsAllowed()`,
  clears it and returns `new TrustedRedirectResponse($returnTo)`; otherwise redirects to `<front>`.

## Logout flow

1. `hook_user_logout` (`drupalauth4ssp_user_logout`) calls `SspHandler::logout()`.
2. `logout()` gets the SimpleSAMLphp session (`Session::getSessionFromRequest()`) and expires each
   authority (`setAuthorityExpire($authority, 1)`), then computes a destination stored in
   `drupal_static('drupalauth4ssp_user_logout')`:
   - **No `ReturnTo`** (IdP-initiated): destination =
     `getSspBasePath() . 'saml2/idp/SingleLogoutService.php?ReturnTo=' . $idp_logout_returnto`,
     where `$idp_logout_returnto` falls back to `base_path()` when the config value is empty.
   - **`ReturnTo` present** and `returnPathIsAllowed()`: destination = that `ReturnTo`.
3. `DrupalAuthForSSPSubscriber::checkRedirection()` (also `KernelEvents::RESPONSE`) intercepts the
   post-logout 302 to the front page and, if the static destination is set, rewrites the target to
   it and `stopPropagation()`.

## Attributes exposed

This module only writes the Drupal account **user ID** into the SSP auth state. Which Drupal
user fields/roles are turned into SAML attributes is configured on the SimpleSAMLphp side, in the
`drupalauth` authsource entry in `authsources.php` (`attributes`, `attributes.username`, etc.) —
not in Drupal.
