# miniOrange Active Directory / LDAP Integration — manual setup guide

**miniOrange Active Directory / LDAP Integration** (`ldap_auth`) lets your users
log in to Drupal with their **LDAP or Active Directory** credentials. When LDAP
login is enabled, the module takes over validation of the standard Drupal login
form: it connects to your directory, binds with a configured service account,
finds the user, and verifies the submitted password by binding to the directory as
that user. If LDAP doesn't recognize the account (or the directory can't be
reached), it **falls back to normal Drupal login**, so local accounts keep working.

Beyond basic login it can look users up by attributes such as `sAMAccountName`,
`uid`, or `cn`, match them to Drupal accounts by their `mail`/UPN attribute, map
LDAP attributes to Drupal profile fields, and — in the paid tiers — map directory
groups to Drupal roles, provision users from Drupal into LDAP, and add
NTLM/Kerberos single sign‑on. This is miniOrange's freemium module, so several
screens advertise a trial/upgrade and gate the advanced features behind a licence.

A few honest notes on how it handles credentials and security:

- **Service account.** The module binds to your directory using a dedicated
  service account (a bind DN and password) that you enter on its configuration
  form. That password is stored **encrypted at rest** (AES‑256‑CBC, keyed from your
  site's private key), not in plain text.
- **Login form input.** The username is escaped before it goes into the LDAP
  search filter, and empty usernames/passwords are rejected before any bind.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the connection, service account,
   search base, attribute mapping, and how to enable LDAP login, screen by screen.

## Where it lives in the admin menu

All of the module's screens live under **Configuration → People → LDAP / Active
Directory** (`admin/config/people/ldap_auth/...`), and every one of them is gated
by the core **Administer site configuration** permission — the module adds no
permission of its own.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Enter your directory connection details, the service‑account bind DN and
   password, the search base, and the username/email attributes on the
   configuration screens (see [Configuration](configuration/index.md)).
3. Test the configuration against a real directory user.
4. Turn on **LDAP login** so the module authenticates the Drupal login form.
