CAS integrates Drupal with a Central Authentication Service (Apereo/Jasig CAS) single sign-on server, letting users log in through your organization's identity provider and auto-provisioning matching Drupal accounts.

---

CAS makes Drupal a CAS client: it redirects users to a configured CAS server for login, validates the returned service ticket (CAS protocol 1.0/2.0/3.0 over http/https with configurable SSL verification), and logs the matching Drupal user in via the External Authentication (externalauth) module. New users can be auto-registered on first login, optionally following the site's account-registration policy, with email derived from a CAS attribute or a hostname pattern, and roles auto-assigned. Site builders configure everything at Admin → Configuration → People → CAS: the server connection, a "gateway" mode that silently checks for an existing SSO session on selected paths, "forced login" that requires CAS on selected paths, single-logout handling, and proxy authentication. Password and email management can be restricted for CAS-managed accounts, and normal Drupal login can be prevented. The module fires a rich set of events (pre/post login, pre-register, pre-validate, pre-redirect, pre-user-load) so custom code can deny logins, map attributes to fields, alter roles, or change the redirect. A Drush command links an existing Drupal user to a CAS username, and a bulk "add CAS users" admin form provisions accounts in advance.

---

- Enable single sign-on so users log in with a central university/enterprise account.
- Redirect the Drupal login link straight to the CAS server.
- Auto-create a Drupal account the first time a CAS user logs in.
- Map a CAS attribute to the user's email address on registration.
- Derive emails from a fixed hostname when the server sends none.
- Auto-assign roles to users provisioned through CAS.
- Force CAS login on specific paths (e.g. an intranet section).
- Use gateway mode to transparently log in users who already have a CAS session.
- Prevent local password login for CAS-managed accounts.
- Restrict CAS users from changing their email or password in Drupal.
- Allow admins to bypass those email/password restrictions.
- Support CAS single logout so signing out of CAS ends the Drupal session.
- Configure CAS protocol version and SSL certificate verification.
- Act as a CAS proxy client for downstream proxied services.
- Show a custom login link label and post-login success message.
- Bulk pre-provision CAS accounts from an admin form.
- Link an existing Drupal account to a CAS username via Drush.
- Deny login for users lacking a required attribute via an event subscriber.
- Copy CAS attributes into user profile fields on each login.
- Alter the post-login redirect destination in custom code.
- Follow the site's registration policy (e.g. admin approval) for CAS sign-ups.
- Require admin approval before a CAS-registered account is active.
- Recheck for an SSO session periodically on gateway paths.
- Customize CAS error messages shown to users.
- Integrate an existing user base with an institutional identity provider.
