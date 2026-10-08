<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LDAP SSO logs users into Drupal from an identity the web server has already authenticated — typically Kerberos or NTLM handled by Apache/IIS — instead of showing a Drupal login form.

---

On a corporate intranet the browser has usually already authenticated the user at the network level, so asking them to type a username and password into Drupal is redundant. The standard arrangement is that the web server performs the authentication and exposes the resulting identity in a server variable; this module reads that variable (by default `REMOTE_USER`, configurable to e.g. `REDIRECT_REMOTE_USER`) and resolves it against the configured LDAP directory through `ldap_servers` and `ldap_authentication`, then establishes a Drupal session with `user_login_finalize()`. There are two ways it fires: a user visiting `/user/login/sso` directly, or — when "automated single sign-on" (`seamlessLogin`) is enabled — an event subscriber on the request that redirects anonymous visitors to that route for any non-excluded path. Optional handling covers splitting `user@realm`, stripping a domain, excluding paths and hosts, a logout redirect, and a confirmation message. Account provisioning and role mapping are delegated to `ldap_authentication`/`ldap_user`; this module only reads the identity and finalizes login. It requires `drupal/ldap ^4.4` on Drupal `^10.3 || ^11`, and the LDAP server must use a service-account bind (not the user's own credentials, which are never available under SSO). This is an intranet integration, not a public-internet SSO provider — for that, look at SAML/SimpleSAMLphp modules.

---

- Log intranet users in automatically without a login form.
- Use Kerberos (`mod_auth_kerb`) authentication with Drupal.
- Use NTLM (`mod_auth_sspi`) authentication on Windows/IIS with Drupal.
- Avoid a second password for staff already on the domain.
- Integrate Drupal login with Active Directory.
- Authenticate only on `/user/login/sso` while leaving the rest of the site public.
- Require domain authentication for the whole site by extending the auth location.
- Turn on seamless SSO so anonymous visitors are logged in on any page.
- Read a custom server variable such as `REDIRECT_REMOTE_USER`.
- Split `user@realm` identities into a bare username.
- Strip a domain prefix/suffix to avoid duplicate accounts vs. manual login.
- Exclude `cron.php` and other paths from automated SSO.
- Exclude specific hostnames on a multi-hostname site.
- Redirect users to a non-SSO path on logout.
- Let a user opt out of auto-login for a browser session via the stop cookie.
- Keep a manual login fallback for accounts not in the directory.
- Provision Drupal accounts from LDAP on first SSO login (via ldap_authentication).
- Map LDAP groups to Drupal roles (via ldap_authentication/ldap_user).
- Support a mixed SSO-and-local-login site.
- Reduce password-reset support requests for staff.
- Meet a policy requiring domain authentication for an internal tool.
- Support a university or agency intranet backed by LDAP.
- Show or suppress the "successfully authenticated" confirmation message.
- Provide desktop single sign-on without deploying SAML infrastructure.
