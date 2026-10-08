# Configuration

Open the settings form at **Administration → People → LDAP servers → LDAP SSO
Auth** (`/admin/config/people/ldap/sso-auth`). It requires the **Administer site
configuration** permission. Before you touch it, make sure the LDAP suite is
already working: `ldap_servers` must define a directory connection (over **LDAPS
or StartTLS**, with the **bind credentials stored as a secret**), and
`ldap_authentication` must be able to log an LDAP user in. This module only
supplies the identity; the suite does the directory work.

## The settings, field by field

- **SSO variable** — the server variable the module reads to learn who the user
  is. The default **`REMOTE_USER`** is correct for a Kerberos or NTLM setup; some
  configurations expose it as **`REDIRECT_REMOTE_USER`** instead. Set it to
  whatever variable your web server actually populates with the authenticated
  username — the settings form prints the current live value beneath the field to
  help you confirm which one that is.
- **Seamless login** — controls whether login happens automatically on each
  request (the seamless behaviour) as opposed to being triggered more explicitly.
  Leave it on for the "already logged in when I arrive" experience this module is
  built for.
- **Split user / realm** — when your directory delivers names as `user@realm`
  (common with Kerberos), enable this to strip the `@realm` suffix before the
  LDAP lookup, so the bare username is what gets matched.
- **Strip domain name from the remote user** — similarly, strips a Windows‑style
  domain prefix from the remote username before the lookup. Use whichever of this
  and the realm split matches the format your web server actually delivers.
- **Excluded paths** — a list of paths where SSO handling should not apply. Use
  this to keep specific routes out of the automatic‑login flow.
- **Excluded hosts** — a list of hostnames where SSO handling should not apply,
  for sites served under more than one host where only some should do SSO.
- **Redirect on logout** — when enabled, sends the user to a specific place after
  they log out (useful so they are not immediately re‑authenticated straight back
  in).
- **Logout redirect path** — the destination used when "redirect on logout" is
  on.
- **Enable login confirmation message** — toggles the "you are now logged in"
  message. Turn it off for a fully silent, seamless login.

## How the login is resolved

- **The web server establishes the identity; the module maps it to a Drupal
  account.** There is no password step in this flow, by design — that is what
  makes it single sign-on.
- **The LDAP server's bind method matters.** The form refuses to run SSO against a
  server configured to bind as the *user* (or as an anonymous‑then‑user), because
  with SSO the user's own credentials are never available to bind with. Configure
  the LDAP server with a service‑account (fixed‑credential) bind for SSO to work.
- **The LDAP suite does the directory work.** Whether a name is a real directory
  user, and how the matching Drupal account is provisioned and given roles, is
  decided by `ldap_authentication`; this module only supplies the username.

## A known issue to be aware of

If a logged‑in user is **deleted from Drupal** while their browser still holds a
valid session cookie, this module sees the existing session and does not
re‑create the account — the person gets "access denied" instead of being
re‑provisioned. The workaround is for that user to clear cookies or use a fresh
incognito window so a new session (and a fresh SSO login) begins.

## Save

Click **Save configuration**, then verify from a domain‑joined browser that
seamless login works, and from an incognito window that the site behaves the way
you expect for visitors who are not authenticated by the web server.
