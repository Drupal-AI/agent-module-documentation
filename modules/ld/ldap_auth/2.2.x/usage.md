miniOrange's LDAP / Active Directory Integration module lets users log in to Drupal with their LDAP or AD credentials, with attribute mapping, role/user provisioning, and (in paid tiers) NTLM/Kerberos. It authenticates the Drupal login form against an LDAP server and falls back to local Drupal credentials when LDAP does not recognise the user.

---

The module hooks the standard Drupal login form (`user_login`, `user_login_form`,
`user_login_block`) and, when LDAP login is enabled, replaces its validation so the submitted
username/password are authenticated against the configured directory. The flow (`LDAPFlow::ldapLogin`)
connects to the server, binds with a configured **service account**, searches for the user under a
search base using a username-attribute filter (e.g. `sAMAccountName`), then performs a **credential
bind as the found user DN** to verify the password; on success it loads the matching Drupal account by
name or by the LDAP `mail`/UPN attribute and finalises login. If LDAP does not know the user, the
password is wrong, or the service bind fails, it falls back to Drupal's own `user.auth` so local
accounts still work (the free-tier behaviour). The username is escaped with `ldap_escape()` before
being placed in the search filter, and an empty username or password is rejected before any bind.
Admin configuration lives
under `admin/config/people/ldap_auth/*` (all gated by the core `administer site configuration`
permission): server/connection, service account, search base discovery, username/email attribute,
attribute + role mappings, provisioning (Drupal→LDAP user sync on insert/update/delete), NTLM/Kerberos
sign-in settings, advanced settings, and a logs/report tab. The service-account password is encrypted
at rest with AES-256-CBC using a key derived from the site private key. The module also
registers a diagnostic endpoint `/testLdapConfig` that fetches a user's LDAP directory attributes for
configuration testing. This is the miniOrange freemium module; many surfaces advertise a
trial/upgrade and gate advanced features (NTLM/Kerberos, role mapping, sync) behind a licence.

---

- Let employees log in to Drupal with their Active Directory username and password.
- Authenticate against OpenLDAP or any LDAPv3 directory.
- Keep local Drupal accounts working via automatic fallback when LDAP rejects a login.
- Look users up by `sAMAccountName`, `uid`, `cn`, or a custom username attribute.
- Bind with a dedicated read-only service account to search the directory.
- Map the LDAP `mail` (or UPN) attribute to the Drupal user's email for account matching.
- Discover available LDAP search bases (namingContexts) from the server's RootDSE.
- Restrict authentication to users under a specific search base / OU.
- Map LDAP attributes to Drupal user profile fields.
- Assign Drupal roles based on LDAP group membership / attributes (paid tier).
- Provision users from Drupal into LDAP on account create/update/delete (Drupal→LDAP sync).
- Set a default role for users provisioned via LDAP login.
- Add NTLM / Kerberos (Windows integrated) single sign-on (paid tier).
- Show custom help text under the username/password fields on the login form.
- Encrypt the stored service-account password at rest (site-private-key-derived AES-256).
- Test a configuration by fetching a user's attributes from the directory.
- Review a Logs & Report tab and an audits table for login attempts and errors.
- Block login for users whose Drupal account is blocked even if LDAP authenticates them.
- Temporarily disable LDAP login while keeping the configuration (with a notice on the form).
- Migrate an intranet's authentication from local Drupal accounts to central AD.
- Support multi-attribute email lookup (fall back to userPrincipalName when `mail` is absent).
