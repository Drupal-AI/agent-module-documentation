<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Email TFA works (flow & extension points)

There is no public service API to call — the module works through route overrides, hooks, and the
private tempstore. This explains the moving parts so you can predict/debug behaviour.

## Route overrides (`EmailTfaRouteSubscriber`)

`alterRoutes()` rewrites two core routes:

- `user.login` → its `_form` becomes `\Drupal\email_tfa\Form\EmailTfaLoginForm`.
- `user.login.http` (REST) → its `_controller` becomes `EmailTfaRestLoginController::login`.

Own routes: `email_tfa.email_tfa_login` (`/tfa/login`) and
`email_tfa.email_tfa_verify_login` (`/tfa/verify/{uid}/{hash}`, `_custom_access` +
`no_cache`, maintenance-accessible). Anonymous-only.

## The code lifecycle

1. `hook_user_login()` seeds the private tempstore (`email_tfa` collection) with
   `email_tfa_send_mail` = `send_mail` and `email_tfa_user_verify` = 0.
2. The login/verify forms generate a numeric code of `security_code_length` digits, store it in the
   tempstore under a hash, and email it. The hash comes from
   `_email_tfa_hash($uid, $name, $pass)` = `Crypt::hashBase64($uid.$name.$pass.hash_salt)` — so
   `settings.php` **must** define `hash_salt`.
3. Email is sent via `hook_mail` key `send_email_tfa`; `[user:email_tfa]` is replaced with the code
   (`email_tfa_mail_tokens`). Subject/body come from config.
4. The user enters the code at `/tfa/verify/{uid}/{hash}` before `timeouts` seconds elapse; flood
   control (`flood_threshold`/`flood_window`) limits attempts. `delete_temp_store($hash)` clears the
   tempstore keys on completion.
5. If `dev_mode` is on, the code is shown on the page instead of requiring the email.

## Who is challenged

`_email_tfa_in_array_any()` implements the role logic: with `role_exclusion_type = force_for`, only
users holding an `ignore_role` are challenged; with `disable_for`, those users are skipped. In
`optionally_by_users` mode, only users whose `email_tfa_status` base field is TRUE are challenged
(`_email_tfa_user_current_status()`). `user_one` can exempt user 1.

## Extension points

- **User opt-in field**: `hook_entity_base_field_info()` adds the boolean `email_tfa_status` field
  to the `user` entity (label "Active"), shown on the account form only in optional mode.
- **Block**: plugin `EmailTfaUserLoginBlock` (`src/Plugin/Block/`) provides an Email-TFA user-login
  block you can place via Block layout.
- **Excluded routes**: the `routes` config lists route names that should not trigger the TFA
  interrupt (e.g. `user.logout`).
- **Gin Login**: `hook_gin_login_route_definitions_alter()` +
  `hook_theme_suggestions_page_alter()` (suggestion `page__email_tfa`) + `hook_preprocess_html()`
  style the verify page to match `gin_login` when that module is present.

No hooks are *invited* for other modules (no `email_tfa.api.php`); customization is via config and
overriding the templates/blocks above.
