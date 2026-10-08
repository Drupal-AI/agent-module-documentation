# Configuration

All of this module's screens live under **Configuration → People → LDAP / Active
Directory** (`admin/config/people/ldap_auth/...`) and require the core **Administer
site configuration** permission. The settings are stored in the `ldap_auth.settings`
config object; there's no Drush command, but you can set individual values with
`drush cset` if you prefer.

## The admin screens

- **Get Started** (`/get_started`) — the landing/overview page. This is the
  `configure` link from the modules list.
- **LDAP Configuration** (`/ldap_config`) — the main connection screen: server,
  service account, search base, username/email attribute, and the switch that
  enables LDAP login. Most of your setup happens here.
- **Attribute Mapping** (`/attribute_mapping`) — map LDAP attributes to Drupal
  profile fields and (in the paid tier) directory groups to Drupal roles.
- **Sign‑In Settings** (`/signin_settings`) — NTLM / Kerberos integrated sign‑on
  (licensed feature).
- **User Sync** (`/user_sync`) — provision users from Drupal into LDAP on account
  create/update/delete (Drupal→LDAP sync).
- **Advanced Settings** (`/settings`) — miscellaneous options, including custom help
  text shown under the login form's username and password fields.
- **Logs & Report** (`/troubleshoot`) — the audit log of login attempts and errors.
- **Licensing** (`/licensing`) — trial/upgrade plans for the paid features.

## Setting up the connection (LDAP Configuration screen)

Work through these fields:

- **Server / server address** — the LDAP host or URI, for example
  `ldap://ad.example.com` (use `ldaps://` for TLS).
- **Port** — the directory port; defaults to **389** (use 636 for LDAPS).
- **Service account username (bind DN)** — the dedicated account the module binds
  with to search the directory. A read‑only service account is ideal.
- **Service account password** — the password for that bind account. It is stored
  **encrypted at rest** (AES‑256‑CBC, derived from your site's private key), not in
  plain text.
- **Search base** — the base DN under which users are searched, for example
  `OU=Staff,DC=example,DC=com`. The **Show Search Bases** helper
  (`/ShowLdapSearchBases`) can list the directory's naming contexts to help you
  pick one.
- **Username attribute** — the attribute used in the login search filter, for
  example `sAMAccountName`, `uid`, or `cn`. This is what a person types into the
  Drupal username field.
- **Email attribute** *(default `mail`)* — the LDAP attribute holding the user's
  email, used to match or locate the corresponding Drupal account. Sites often fall
  back to `userPrincipalName` when `mail` is absent.
- **Default role** — a role assigned to users provisioned through LDAP login.
- **Enable logs** *(on by default)* — write login attempts and errors to the audit
  table shown on the Logs & Report screen.

You can also set custom **help text** under the login form's username and password
fields from the Advanced Settings screen.

## Enabling (and disabling) LDAP login

There's a master switch for LDAP login on the configuration screen:

- **When it's on**, the module replaces the Drupal login form's validation with its
  own: submitted credentials are checked against the directory, and if LDAP doesn't
  recognize the user (or can't be reached), it falls back to normal Drupal login so
  local accounts still work.
- **When it's off but the module is already configured**, the login form shows a
  notice ("LDAP login is currently disabled…") and core login proceeds as usual —
  handy for temporarily pausing LDAP without losing your configuration.

Blocked Drupal accounts are rejected even if LDAP would authenticate them.

## Test before you rely on it

Use the module's test flow to fetch a real user's attributes from the directory and
confirm the connection, service account, search base, and attributes are all
correct before enabling login for everyone.
