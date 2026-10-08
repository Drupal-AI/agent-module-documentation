<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — simplesamlphp_auth

All config is the single config object **`simplesamlphp_auth.settings`** (schema in
`config/schema/`). UI at `/admin/config/people/simplesamlphp_auth`, three tabs:
Basic (`simplesamlphp_auth.admin_settings`, `BasicSettingsForm`), Local authentication
(`…_local`, `LocalSettingsForm`), User info and syncing (`…_sync`, `SyncingSettingsForm`).
Edit fastest with `drush config:set simplesamlphp_auth.settings <key> <value>`.

Prerequisite (outside Drupal): a working SimpleSAMLphp SP, either via the Composer-installed
`vendor/simplesamlphp/simplesamlphp` or a standalone install pointed to by
`$settings['simplesamlphp_dir']` in settings.php. SP `store.type` must NOT be `phpsession`
(the login controller refuses to run if it is).

## Key settings (defaults from config/install)

- `activate` (bool, default **false**) — master switch. While false the module does nothing;
  `hook_requirements` shows an INFO notice.
- `auth_source` (default `'default-sp'`) — the SimpleSAMLphp auth source name.
- `unique_id` (default `'eduPersonPrincipalName'`) — SAML attribute used as the **authname**
  (the stable identity linking to the Drupal account). Must be unique and non-empty.
- `user_name` (default `'eduPersonPrincipalName'`) — attribute used as the Drupal username.
- `mail_attr` (default `'mail'`) — attribute used as the email.
- `register_users` (bool, default **true**) — auto-create a Drupal account on first login.
  When false, an unknown SAML user is logged straight back out with a message.
- `autoenablesaml` (bool, default **false**) — when true, a successful SAML login whose
  authname equals an existing Drupal username (or an existing user returned by
  `hook_simplesamlphp_auth_existing_user`) links that account and logs in as it. When false,
  a username collision **aborts** the login instead of hijacking the account.
- `role.population` (string) — role-map rules, see below. `role.eval_every_time` (bool) —
  re-run role sync on every login.
- `sync.mail` / `sync.user_name` (bool, default true) — overwrite email/username from SAML on
  each login.
- `allow.default_login` (bool, default true) — permit local (non-SAML) Drupal logins.
  `allow.default_login_users` (comma string, default `'1'`) and `allow.default_login_roles`
  (list) whitelist who may still log in locally when SAML is active. If default_login is off,
  the login page redirects straight to `/saml_login`.
- `allow.set_drupal_pwd` (bool, default true) — let SAML users set/keep a local password;
  when false, password fields are hidden on their user form.
- `login_link_show` / `login_link_display_name` (default `'Federated login'`) — the login-form
  link. `logout_goto_url` — post-logout redirect. `secure` / `httponly` — flags on the
  `simplesamlphp_auth_returnto` cookie. `header_no_cache`, `debug`.

## Role-map syntax (`role.population`)

`roleid:key,op,value;key,op,value|roleid:key,op,value` — `|` separates roles, `;` separates
OR-ed rules, a rule matches a SAML attribute `key` against `value` with `op`:
`=` (value is in the attribute array), `@=` (part after `@` in the first attribute value
equals value), `~=` (value is a substring of any attribute value). Matched role ids are
assigned; with `eval_every_time` on, unmatched non-locked roles are also removed.

## Install side effects

On enable the module sets `user.settings register` to `admin_only` (saving the old value in
`user_register_original`) and revokes "change own password" from authenticated users; both are
restored on uninstall.
