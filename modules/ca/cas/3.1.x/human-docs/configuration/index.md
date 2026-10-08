# Configuration

All of CAS's settings live on one form at **Configuration → People → CAS**
(`/admin/config/people/cas`, route `cas.settings`), stored in the `cas.settings`
config object. You need the **Administer site configuration** permission to reach
it. The form is grouped into the sections below.

## CAS server connection

Point Drupal at your identity provider:

- **Version** — the CAS protocol version your server speaks: `1.0`, `2.0`, or
  `3.0`.
- **Protocol** — `http` or `https`. Use `https` in production.
- **Hostname** — the CAS server's hostname, for example `sso.example.edu`.
- **Port** — the port the CAS server listens on.
- **Path** — the URI path to the CAS endpoint on that server.
- **SSL verification** — how strictly to verify the CAS server's certificate. Keep
  full verification on in production; the looser options exist only for testing
  against self‑signed certificates.
- **Certificate** — the path to a PEM certificate file, when you need to supply one
  for verification.

## Gateway — transparent SSO check

Gateway mode silently checks whether a visitor already has an active CAS session
and, if so, logs them in without them clicking anything:

- **Enabled** — turn gateway checking on.
- **Recheck time** — how often (in minutes) to re‑check for an SSO session.
- **Paths** — the paths on which gateway checks run.
- **Method** — whether the check happens **server side** or **client side**.

## Forced login — require CAS on paths

- **Enabled** — turn forced login on.
- **Paths** — the paths that require a CAS login. A visitor hitting one of these
  paths without a session is sent to the CAS server first. Good for an intranet
  section.

## User accounts — provisioning

Controls how Drupal accounts are created and managed for CAS users:

- **Prevent normal login** — stop CAS‑managed accounts from logging in with a local
  Drupal password.
- **Auto‑register** — create a Drupal account automatically the first time a CAS
  user logs in.
- **Follow registration policy** — when auto‑registering, respect the site's normal
  account‑registration policy (for example, requiring admin approval).
- **Email assignment strategy** — where a new user's email comes from: a CAS
  **attribute** or a fixed **hostname**.
- **Email hostname** — the hostname to build emails from when using the hostname
  strategy.
- **Email attribute** — the CAS attribute that carries the user's email when using
  the attribute strategy.
- **Auto‑assigned roles** — roles granted to every user provisioned through CAS.
- **Restrict password management** / **Restrict email management** — stop
  CAS‑managed users from changing their password or email inside Drupal.
- **Admin bypass** — let administrators bypass those password/email restrictions.

## Other sections

- **Login link** — whether to show a CAS login link, its label, and the success
  message shown after login.
- **Error handling** — customize the error messages shown to users when CAS login
  fails.
- **Logout** — single‑logout handling, so signing out of CAS also ends the Drupal
  session.
- **Proxy** — proxy authentication settings for acting as a CAS proxy client to
  downstream services.
- **Advanced** — additional lower‑level options.

Save the form when done. You can also read and set values from the command line,
for example:

```bash
drush config:get cas.settings
drush config:set cas.settings server.hostname sso.example.edu -y
drush config:set cas.settings user_accounts.auto_register true -y
```

## Bulk‑adding CAS users

Beyond this form, a separate **add CAS users** admin page
(`cas.bulk_add_cas_users`) lets you pre‑provision Drupal accounts for a list of CAS
usernames in advance, rather than waiting for each user's first login.
