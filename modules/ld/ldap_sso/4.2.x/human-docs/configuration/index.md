# Configuration

LDAP SSO has a small settings form of its own (`ldap_sso.admin_form`, under
**Configuration → People → LDAP**), but most of the real work of a successful
setup happens in two places outside that form: your **web server** and the rest
of the **LDAP suite**. This page walks through all three, and then the trust
model you must get right — the security of the whole arrangement rests on it.

## Before you open the form: the LDAP suite must work first

LDAP SSO does not connect to your directory itself. It hands the SSO username to
`ldap_authentication`, which resolves it against a server defined in
`ldap_servers`. So the order of operations is:

1. In **`ldap_servers`**, define your directory connection. Point it at your LDAP
   or Active Directory host, and — importantly — use **LDAPS or StartTLS** so the
   connection is encrypted. Store the **bind credentials** (the account Drupal
   uses to read the directory) as a **secret** rather than in plain
   configuration; on this project, prefer a Key entity backed by an environment
   variable set with `ddev dotenv set`.
2. In **`ldap_authentication`**, confirm ordinary LDAP login works and that
   accounts provision and map to roles the way you expect. Get this solid before
   layering SSO on top — SSO only removes the password prompt; it does not change
   how accounts are created or authorised.

## The LDAP SSO settings form

Open **Configuration → People → LDAP** and find the LDAP SSO settings. This is
where you turn seamless single sign‑on on and tell it which behaviour you want —
for example whether login happens automatically or via the `/user/login/sso`
link, and how the SSO login integrates with the ordinary login form. Because SSO
depends on your directory and web‑server setup rather than on a Drupal
permission, the login route is protected by a request‑aware access check and is
never cached, so a session is established correctly.

Save the form, then test from a domain‑joined browser.

## The trust model — read this carefully

This is the part that determines whether your SSO deployment is secure.

- **The web server is the authenticator, not Drupal.** The server negotiates
  Kerberos or NTLM and passes the resulting identity to PHP in a server
  variable. Drupal *trusts* that variable — it does not re‑verify a password,
  because with SSO there is no password to verify.
- **Therefore the web server configuration is part of your security boundary.**
  If a proxy or misconfiguration lets a *client* supply the header/variable the
  module reads, an attacker can claim to be anyone. Make sure the edge **strips**
  any inbound copy of the header the origin trusts, and that only your
  authenticating layer can set it.
- **Keep a non‑SSO login path.** Administrative and directory‑external accounts
  still need `/user/login`. Do not remove it.

## Save

Click **Save configuration**, then verify: an authenticated domain user reaching
`/user/login/sso` is logged in without a form, while the standard login page
still works for everyone else.
