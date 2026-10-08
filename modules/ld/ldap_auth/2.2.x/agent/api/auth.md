# Authentication flow & services

## Login wiring (`ldap_auth.module`)

`hook_form_alter` targets `user_login`, `user_login_form`, `user_login_block` for anonymous users.
When `miniorange_ldap_enable_ldap` is set it **replaces** the login form's `#validate` with
`ldap_auth_form_alter_submit` and `#submit` with `ldap_auth_form_submit`:

- `ldap_auth_form_alter_submit()` — `Html::escape()`s the username, bails if the form already has
  errors, then calls `LdapAuthenticationService::handleFormSubmit($username, $password, …)`.
- `ldap_auth_form_submit()` — if a `ldap_auth_uid` was set in form state, calls
  `user_login_finalize()` and redirects to `<front>`.

## Services (`ldap_auth.services.yml`)

- `ldap_auth.authentication` → `Service\LdapAuthenticationService` — orchestrates a login: runs the
  LDAP flow, and on `SUCCESS` loads the Drupal account by username then by email/UPN, rejects blocked
  accounts, and sets `ldap_auth_uid`. On `USER_NOT_EXIST_IN_LDAP` / `WRONG PASSWORD` /
  `LDAP_BIND_FAILED` it calls `handleLocalFallback()` → `@user.auth` `authenticate()` so local Drupal
  credentials still work.
- `ldap_auth.ldap_connection` → `Service\LdapConnectionService` — thin, mockable wrapper over the PHP
  `ldap_*` functions (`connect`, `bind`, `search`, `read`, `getEntries`, `escape`, …). `bind()` maps
  empty dn/password to `NULL` (anonymous) — but callers guard against empty credentials.
- `ldap_auth.user` → `Service\LdapUserService` — wraps `user_load_by_name` / `user_load_by_mail`.
- `ldap_auth.user_sync` → `UserSyncService` — Drupal→LDAP provisioning on user insert/update/delete
  (`hook_entity_insert/update/delete`).
- `ldap_auth.encryption` → `Service\EncryptionService` — AES-256-CBC using
  `hash('sha256', private_key)` as the key; random IV per value, base64(iv+ciphertext). Static
  `Utilities::encrypt_data()` / `decrypt()` wrap the same scheme (used by update hooks).

## Core flow — `LDAPFlow::ldapLogin(string $username, string $password): ?Mo_Ldap_Auth_Response`

1. Reject empty username or password (returns NULL, no bind).
2. `ldap_escape($username, '', LDAP_ESCAPE_FILTER)` — username is escaped before use in the filter.
3. Connect; on failure → `LDAP_CONNECTION_FAILED`.
4. Bind with the service account (`miniorange_ldap_server_account_username` +
   decrypted `…_account_password`); non-`success` → `LDAP_BIND_FAILED`.
5. Search under `miniorange_ldap_search_base` with filter
   `(&({username_attribute}={escaped_username})(|(objectClass=user)(objectClass=person)))`.
6. If no entry: try `@user.auth` local login, audit, return `USER_NOT_EXIST_IN_LDAP`.
7. Get the user's DN; `authenticate($userDn, $password)` performs a **credential bind as that DN**.
   Bind success → `SUCCESS` (and collect `mail` / `userprincipalname` into `profileAttributesList`);
   failure → try local `@user.auth`, audit `WRONG_PASSWORD`.

`Mo_Ldap_Auth_Response::success()/failure()` carry `statusMessage`, `userDn`, and attribute lists.

## Diagnostic controller

`Controller\miniorange_ldapController` exposes `test_configuration()` at **`/testLdapConfig`**. It
reads POST `user`/`pass`, calls `search_user_attributes()` — which binds with the service account and
searches for the POSTed username — then displays the user's LDAP attributes and stores them in config.
