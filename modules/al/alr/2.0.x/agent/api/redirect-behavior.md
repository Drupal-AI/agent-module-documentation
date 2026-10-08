<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# alr — runtime redirect behavior (hooks)

All runtime logic lives in `alr.module`. No services, no event subscribers, no plugins.

## Login path
- `alr_form_alter(&$form, $form_state, $form_id)` — implements `hook_form_alter()`. When `$form_id == 'user_login_form'` it appends the callback `alr__login_page_redirect_user_login_form_submit` to `$form['#submit']`.
- `alr__login_page_redirect_user_login_form_submit($form, $form_state)` runs after core authentication:
  1. `$request = \Drupal::service('request_stack')->getCurrentRequest();`
  2. `$config = alr_get_config('login');`
  3. `$roles = \Drupal::currentUser()->getRoles(); sort($roles);`
  4. If `$roles[0]` is truthy: `$redirect_url = $config[$roles[0]]['redirect_url'];`
  5. `if (!$request->get('destination')) { $request->query->set('destination', $redirect_url); }`

## Logout path
- `alr_user_logout(AccountInterface $account)` — implements `hook_user_logout()`. Same shape as the login handler but reads `alr_get_config('logout')` and sets the `destination` query param when none is present.

## Semantics & gotchas
- **First-role-only**: `sort($roles)` then `$roles[0]` picks the alphabetically first role machine name (e.g. `administrator` before `authenticated`). Only that role's `redirect_url` is used; there is no per-role priority merge, and the stored `weight` (used only for table ordering in the form) does not influence which role wins.
- **Existing destination wins**: the module never overrides an incoming `?destination=` param — a login/logout link that already carries one is respected, and Drupal's normal redirect handling (including core's sanitization of the `destination` value) applies.
- **No path validation at runtime or save**: the injected `PathValidatorInterface` is unused; `redirect_url` is whatever the admin typed.
- `alr_get_config($key)` returns `\Drupal::config('alr.settings')->get($key)` or `[]` when unset — so with no saved config the handlers set `destination` to `null` (a no-op) for the first role if a rule is missing.
- `hook_help()` (`help.page.alr`) documents that the module can redirect to internal/external URLs after login and after logout.
