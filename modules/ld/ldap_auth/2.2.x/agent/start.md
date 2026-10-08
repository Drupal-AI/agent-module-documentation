# miniOrange LDAP / Active Directory Integration — agent index

Authenticates the Drupal login form against LDAP/AD, with a fallback to local Drupal credentials.
miniOrange freemium module (advanced features — NTLM/Kerberos, role mapping, sync — are licence-gated).
Config UI under `admin/config/people/ldap_auth/*` (`configure` `ldap_auth.get_started`), all gated by
core `administer site configuration`. No custom permissions, no Drush. Provides config schema.

- **Config surfaces, all the `miniorange_ldap_*` settings keys, service account, search base,
  attribute mapping, enabling/disabling login** → [configure/settings.md](configure/settings.md)
- **The authentication flow and services — how a login is validated, the local fallback, encryption
  of the service password** → [api/auth.md](api/auth.md)
- **The `/testLdapConfig` diagnostic endpoint** → [api/auth.md](api/auth.md).

Key facts:
- Login is wired by `hook_form_alter` on `user_login` / `user_login_form` / `user_login_block`; when
  `miniorange_ldap_enable_ldap` is set the form's `#validate`/`#submit` are replaced with the module's.
- Core flow in `Drupal\ldap_auth\LDAPFlow::ldapLogin($username, $password)`:
  service-account bind → search by `miniorange_ldap_username_attribute` → credential bind as user DN.
- Username is `ldap_escape()`-d and empty user/pass rejected before binding (login form is safe).
- Service-account password encrypted AES-256-CBC via site private key
  (`Service\EncryptionService` / `Utilities::encrypt_data`).
- Route `/testLdapConfig` (`ldap_auth.test_configuration`) fetches a user's LDAP attributes for
  configuration testing.
