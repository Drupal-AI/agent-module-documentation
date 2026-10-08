LDAP Authentication validates Drupal login credentials against one or more configured LDAP servers, letting users sign in with their directory username and password in either mixed (LDAP + local) or exclusive (LDAP-only) mode.

---

The submodule hooks into the Drupal login form: on submit, a login validator (`LoginValidatorLoginForm`, service `ldap_authentication.login_validator`) binds to the allowed LDAP servers, checks the supplied credentials, applies allow/exclude DN rules, and — via `ldap_user`'s `DrupalUserProcessor` — associates or provisions the matching Drupal account before completing login. A separate `LoginValidatorSso` supports single sign-on where an upstream module already asserts the username. Behaviour is controlled by the `ldap_authentication.settings` config object: `authenticationMode` (`mixed` or exclusive), the list of enabled server ids (`sids`, resolved through the `AuthenticationServers` helper), whitelist/blacklist by DN text (`allowOnlyIfTextInDn`, `excludeIfTextInDn`), an option to deny users who receive no authorizations (`excludeIfNoAuthorizations`), whether to skip administrator accounts, and how email and password fields behave on the login/registration UI (`emailOption`, `emailUpdate`, `passwordOption`, plus a full email-template subsystem). It also adds a self-service `/user/ldap-profile-update` form so users can supply a missing email, an event-subscriber-based route subscriber and email-template service, and a `hook_ldap_authentication_allowuser_results_alter()` hook so custom modules can approve or deny a login after inspecting the LDAP entry. Configuration lives at **Admin → Config → People → LDAP → Authentication** (`/admin/config/people/ldap/authentication`), gated by `administer ldap`. It requires `ldap_servers` and `ldap_user`.

---

- Let users log in with their corporate LDAP / Active Directory credentials.
- Run in mixed mode so both directory and local Drupal accounts can authenticate.
- Run in exclusive mode to force every login through LDAP.
- Restrict which configured LDAP servers are used for authentication.
- Allow login only for users whose DN contains specific text (whitelist).
- Deny login for users whose DN contains specific text (blacklist).
- Deny login to users who receive no authorizations (with `ldap_authorization`).
- Skip administrator accounts so they always authenticate locally (lockout safety).
- Provision or associate a Drupal account automatically on first successful LDAP login.
- Hide the password field's confirmation or messaging on the login UI.
- Control whether the email field is shown, hidden, or made read-only for LDAP users.
- Apply an email template (e.g. `@username@example.com`) when the directory has no mail attribute.
- Prompt or notify users when their email is updated from LDAP.
- Offer a self-service form for users to supply a missing email address.
- Support single sign-on when an upstream module has already authenticated the user.
- Customize the login form's username/password help text.
- Add a help link pointing directory users to password-reset or support pages.
- Approve or deny a login from custom code after examining the LDAP entry (hook).
- Keep the whole authentication policy in exportable Drupal config.
- Redirect users to an external help URL after login when required.
- Centralize authentication for an intranet on a single directory.
- Combine with `ldap_user` field mappings so profile data is refreshed at each login.
- Bind with the user's own credentials to verify the password directly against the directory.
- Prevent unauthorized directory users from ever creating a Drupal account.
