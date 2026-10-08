<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure SAML Drupal Login

Admin: `/admin/config/people/saml_sp/login` (route `saml_sp_drupal_login.config`, form
`SamlSpDrupalLoginConfig`, permission `configure saml sp`). All state is the
`saml_sp_drupal_login.config` config object.

## Initiating login

Send users to `/saml/drupal_login/{idp}` (route `saml_sp_drupal_login.login`), where `{idp}` is an
`idp` config entity machine name from saml_sp. The controller calls `saml_sp_start()` with this
module's callback; on the IdP's response `saml_sp_drupal_login__saml_authenticate()` runs.

## Config keys (`saml_sp_drupal_login.config`)

| Key | Type | Default | Effect |
|---|---|---|---|
| `idp` | sequence | (unset) | Which registered IdP(s) are enabled for login |
| `logout` | bool | `false` | Single logout — also log out of the IdP when logging out of Drupal |
| `logged_in_redirect` | string | `<front>` | Where to send an already-logged-in user who hits the login route |
| `force_authentication` | bool | `false` | Require IdP re-authentication even with an existing SSO session |
| `force_saml_only` | bool | `false` | Bypass the Drupal login form: `/user` auto-redirects anonymous users to SAML |
| `account_request_request_account` | bool | `false` | Allow users with no account to request one |
| `account_request_create_account` | bool | `false` | Auto-create an account on successful auth, no admin approval |
| `no_account_authenticated_user_role` | bool | `false` | Log unmatched authenticated users into a shared account |
| `no_account_authenticated_user_account` | int | `null` | UID of that shared authenticated-only account |
| `update_email` | bool | `false` | Update the Drupal email from the IdP if it differs |
| `update_language` | bool | `false` | Update the account language from an IdP `language` attribute |

### Read / write with drush

```bash
drush cget saml_sp_drupal_login.config
drush cset saml_sp_drupal_login.config force_saml_only 1 -y
drush cset saml_sp_drupal_login.config account_request_create_account 1 -y
drush cset saml_sp_drupal_login.config logged_in_redirect '/user' -y
```

## Account matching & provisioning order

`saml_sp_drupal_login__saml_authenticate()` resolves the user in this order:

1. Match an existing account by NameID/email (`saml_sp_drupal_login_get_user()`), using the IdP's
   `nameid_field` (usually `mail`) then falling back to any email attribute.
2. Else, if core registration allows visitors **or** `account_request_create_account` is TRUE →
   create and activate a new account.
3. Else, if `no_account_authenticated_user_role` + `no_account_authenticated_user_account` are set →
   log in as that shared account.
4. Else → deny, or redirect to request an account (`account_request_request_account` /
   core "visitors + admin approval") at `/user/saml_sp_drupal_login_register`.

On success, `hook_saml_sp_drupal_login_user_attributes()` fires (see hooks/user-attributes.md).
