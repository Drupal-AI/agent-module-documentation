<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# alt_login — display name, tokens, username generation & basic auth

All in `alt_login.module` unless noted.

## Display name (`hook_user_format_name_alter`)
`alt_login_user_format_name_alter(&$name, $account)` rewrites the rendered display name:
- anonymous **account** → left as core's configured anonymous value (returns early).
- viewer is anonymous → `$name = token replace(display_anon, ['user'=>$account], ['clear'=>TRUE])`.
- otherwise, if `display` template is set → `token replace(display, ['user'=>$user], ['clear'=>TRUE])`.
- else fall back to `$account->getAccountName()`.
Results are memoized in a static keyed by uid (the hook isn't cached). `alt_login_module_implements_alter()`
forces this module's implementation to run **last** among `user_format_name_alter` implementers.
Available tokens per the form: `[user:uid]`, `[user:account-name]` (and any token-module tokens); the
settings form forbids `[user:display-name]` to avoid recursion.

## Token replacement (`hook_tokens_alter`)
`alt_login_tokens_alter()` rewrites `[user:name]` to the user's aliases joined by " OR " (via
`alt_login_get_user_aliases()`), for both `user` and `entity` token contexts.

## Account form integration
`alt_login_form_user_form_alter()`:
- Always appends `$form['#validate'][] = 'alt_login_validate_dedupe_aliases'`, which calls each active
  plugin's `dedupeAlias()` and sets a form error ("This alias is already taken.") if another account owns it.
- If `username` is an active alias: appends the other aliases to the name field description as a login hint.
- If `username` is NOT active: hides the name field (`#access = FALSE`). For a new user it registers the
  entity builder `alt_login_entity_builder()` which sets the username to the email. For existing users it
  shows the alias(es) they can log in with instead.

## Username auto-generation (`hook_user_presave`)
`alt_login_user_presave()` runs only for genuinely new accounts (not uid 1, not migrating-in accounts whose
created time predates the request):
- if `username` is not an accepted alias → derive the username from the email local-part (text before `@`),
  querying `users_field_data` for the highest existing `name LIKE '<local>%'` and appending `_<n>` to keep
  it unique; sets it with `setUsername()`.
- else if `address_name` is accepted → build the username from the address field's given + family name
  (logs an error via `logger.channel.alt_login` if the address field/value is missing).

## HTTP Basic Auth alias support
`AltloginServiceProvider::alter()` (`src/AltloginServiceProvider.php`) rebinds the core
`basic_auth.authentication.basic_auth` service to `Drupal\alt_login\Authentication\Provider\BasicAuth`.
That subclass's `authenticate()` reads the `PHP_AUTH_USER` header, runs it through
`alt_login_convert_alias()` (resolving email/uid/etc. to the real username), writes the resolved value back
into the header, then delegates to the parent basic-auth provider — so API clients can authenticate with any
configured alias. Requires the `basic_auth` module to be enabled for the override to have an effect.

## Utilities
- `alt_login_convert_alias($alias)` — alias → real username (see plugins/login-methods.md).
- `alt_login_get_user_aliases($user)` — aliases keyed by plugin id (labels for anonymous users).
- `alt_login_get_alias($user, $plugin_id)`, `alt_login_active_descriptions()` — helpers for export/UI.
- `alt_login_user_name_used()` — whether the `username` method is active.
- Note: `__alt_login_entity_base_field_info_alter()` is prefixed with `__`, so it is **not** an active hook;
  the core UserName uniqueness constraint on `user.name` is therefore left in place.

## `alt_login.install`
`alt_login_update_8001()` clears the obsolete `name_mode` config key.
