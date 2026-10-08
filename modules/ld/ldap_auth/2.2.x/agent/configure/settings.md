# Configuration

All admin routes are under `admin/config/people/ldap_auth/*` and require the core
`administer site configuration` permission (the module defines no permission of its own). Config
object: `ldap_auth.settings`. There is no Drush command; set values with `drush cset` or the forms.

## Admin pages (routes)

| Route / path | Form | Purpose |
|---|---|---|
| `ldap_auth.get_started` `/…/get_started` | `GetStarted` | Landing / overview (the `configure` route). |
| `ldap_auth.ldap_config` `/…/ldap_config` | `MiniorangeLDAP` | Server, service account, search base, username/email attribute; enable login. |
| `ldap_auth.attribute_mapping` `/…/attribute_mapping` | `AttributeMapping` | Map LDAP attributes → Drupal fields/roles. |
| `ldap_auth.signin_settings` `/…/signin_settings` | `MiniorangeGeneralSettings` | NTLM / Kerberos sign-in (licensed). |
| `ldap_auth.user_sync` `/…/user_sync` | `MiniorangeUserSync` | Drupal→LDAP provisioning. |
| `ldap_auth.settings` `/…/settings` | `MiniorangeAdvanceSetting` | Advanced settings, login field help text. |
| `ldap_auth.troubleshoot` `/…/troubleshoot` | `MiniorangeDebug` | Logs & Report. |
| `ldap_auth.licensing` `/…/licensing` | `MiniorangeLicensing` | Upgrade plans. |
| `ldap_auth.show_search_base` `/ShowLdapSearchBases` | `ShowLdapSearchBases` | Lists RootDSE naming contexts / OUs (admin-only). |
| `ldap_auth.test_configuration` `/testLdapConfig` | controller | Configuration test endpoint (fetches a user's LDAP attributes). |

## Key settings (`ldap_auth.settings`)

| Key | Default | Meaning |
|---|---|---|
| `miniorange_ldap_enable_ldap` | (unset) | Master switch: when set, LDAP validation replaces core login validation. |
| `miniorange_ldap_is_configured` | `0` | Whether config is complete (drives the "LDAP disabled" notice). |
| `miniorange_ldap_server` / `miniorange_ldap_server_address` | `''` | LDAP host / URI (e.g. `ldap://ad.example.com`). |
| `miniorange_ldap_server_port_number` | `389` | Server port (set at install). |
| `miniorange_ldap_server_account_username` | `''` | Service-account bind DN. |
| `miniorange_ldap_server_account_password` | `''` | Service-account password, **stored AES-256-CBC encrypted** (site private key). |
| `miniorange_ldap_search_base` | `''` | Base DN to search users under. |
| `miniorange_ldap_username_attribute` | `''` | Attribute used in the login search filter (e.g. `sAMAccountName`). |
| `miniorange_ldap_custom_username_attribute` | `samaccountName` | Default custom username attribute (set at install). |
| `miniorange_ldap_email_attribute` | `mail` | LDAP attribute holding the email, used to match/locate the Drupal account. |
| `miniorange_ldap_default_role` | `''` | Role assigned to provisioned users. |
| `miniorange_ldap_enable_logs` | `1` | Write to the audits/logs table. |
| `username_description` / `password_description` | (unset) | Help text injected under the login form fields. |
| `possible_ldap_search_bases` | (json) | Cached RootDSE naming contexts from base-discovery. |

Licence/customer keys (`miniorange_ldap_customer_*`, `miniorange_ldap_license_key`, etc.) are populated
by the trial/upgrade flow.

## Enable / disable behaviour

- With `miniorange_ldap_enable_ldap` set, `hook_form_alter` sets `$form['#validate']` /
  `$form['#submit']` to the module's handlers on the login forms — LDAP authenticates, with local
  Drupal fallback (see [api/auth.md](../api/auth.md)).
- With it unset but `miniorange_ldap_is_configured` true, a warning message ("LDAP login is currently
  disabled…") is shown on the login form and core login proceeds normally.

Install defaults are seeded by `ldap_auth_install()` (`miniorange_ldap_steps=0`, port `389`,
custom username attribute `samaccountName`). Update hooks `9211`/`9212` migrate the stored password to
the current site-private-key encryption.
