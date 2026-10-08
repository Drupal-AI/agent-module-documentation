DiBa SAML adds corporate single sign-on to a DiBa Drupal site by layering login-policy business rules and IdP/SP configuration helpers on top of the samlauth module, which performs the actual SAML protocol validation.

---

The submodule (`diba_integration_saml`) provides a settings form at `/admin/config/people/diba_saml` and a diagnostics page at `.../status`. Its `SamlManager` service centralizes policy: a validation mode (0 = local Drupal only, 1 = combined, 2 = hybrid), an allowed corporate-domain list, an exempt-usernames "escape" list, attribute mapping (uid/mail/display name), auto-provisioning, and building the SAML login URL. `SamlFormHooks` (`#[Hook]`) alters `user_login_form` — in hybrid mode a corporate-domain user's submission is rerouted to SAML login (`/saml/login?username=…&return_to=…`) by `LoginFormValidator`, which replaces the core credential validators; in combined mode local auth is tried first and SAML is the fallback. It also alters `user_pass` to show a themed recovery message and block corporate users from resetting their Drupal password. `IdpMetadataParser` extracts IdP entity ID, SSO/SLO URLs and the X.509 certificate from pasted metadata XML (DOMDocument/XPath, `LIBXML_NONET`). On save, `SamlSettingsForm::syncSamlauthConfiguration()` writes the resolved values into `samlauth.authentication` (entity IDs, ACS/SLS URLs, certs, attribute mapping, create/link-users). `SamlSpMetadataController` serves combined multi-environment SP metadata XML at `/diba-saml/metadata`. Permissions: `administer saml` (restricted) and `access saml` (diagnostics).

---

- Enable corporate SAML SSO on a DiBa site while delegating protocol validation to samlauth.
- Import raw IdP metadata XML and auto-populate IdP entity ID, SSO URL, SLO URL and X.509 certificate.
- Choose a login policy: local Drupal only, combined (Drupal + SAML), or hybrid (SAML for corporate emails, Drupal for others).
- Automatically redirect corporate-domain users to the SAML login endpoint when they submit the Drupal login form.
- Keep an escape list of usernames that always use local Drupal authentication (e.g. break-glass admin accounts).
- Auto-provision Drupal accounts from SAML assertions with a configurable default role.
- Link SAML logins to existing Drupal accounts matched by username or email.
- Add a discreet "Accés restringit usuaris corporatius" SSO link to the standard login form.
- Hide the local username/password fields entirely when local login is disallowed in non-local modes.
- Block corporate users from resetting their Drupal password and point them to the corporate portal.
- Generate multi-environment SP metadata XML (one ACS/SLS endpoint per configured environment URL) to hand to the IdP team.
- Restrict corporate authentication to specific email domains (e.g. `diba.cat`, `diba.es`).
- Map SAML attributes to Drupal username, email and display name by FriendlyName or OID.
- Review a SAML status/diagnostics page showing IdP/SP configuration and the effective samlauth settings.
- Sync all SAML settings into `samlauth.authentication` from a single DiBa-oriented form.
