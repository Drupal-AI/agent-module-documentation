# Configuration

BasicShib's admin pages live under **Configuration → BasicShib**
(`/admin/config/basicshib`). Before any of this matters, make sure the Shibboleth
SP in front of Drupal is authenticating users and publishing attributes to the web
server (see [Installation](../installation/index.md)).

## Core settings

**Configuration → BasicShib → Core settings**
(`/admin/config/basicshib/coresettings`, permission *Administer basicshib*). This
is the main form (`basicshib.settings`). The important groups:

### Attribute map

This is the heart of the setup: it tells BasicShib which **web-server variables**
carry the identity. The defaults are:

- **name** → `eppn` — becomes the Drupal username.
- **mail** → `eppn` — becomes the Drupal email.
- **session_id** → `Shib-Session-ID` — the Shibboleth session id BasicShib tracks.

These names are looked up in `$_SERVER` (the server/environment variables your SP
sets), so change them to match your SP's release policy. You can also add extra
**optional** attributes as `{id, name}` pairs. If your SP publishes attributes
under different variable names, this is where you reconcile them.

### Handlers

The SP login and logout endpoints. Defaults:

- **Login handler** → `/Shibboleth.sso/Login`
- **Logout handler** → `/Shibboleth.sso/Logout`

### Plugins

Choose which plugin drives each behavior:

- **user_provider** (default `basicshib`) — how accounts are loaded and created.
- **grouper** (default `grouper_default`) — how groups map to roles.
- **auth_filter** (default `[basicshib]`) — a *list* of filters, all of which run.

Most sites leave these at the defaults unless they have written a custom plugin
(see the [`agent/`](../agent/start.md) plugin docs).

### Messages and redirect

- **Messages** — the user-facing error strings (generic failure, blocked account,
  disallowed, creation-denied, external-redirect refused). Edit them to match your
  site's tone.
- **Default post-login redirect path** (default `/user`) — where users land after a
  successful login when no `after_login` target is supplied. External targets are
  refused for safety (an open-redirect guard).
- **Login link label** (default `Shibboleth login`) — the text shown on the login
  block and menu link.
- **Extended logging** (logging / messaging, both off by default) — verbose
  diagnostics.

## The login link or block

Give users a way to start login, in one of two ways:

- A **menu link** to
  `/Shibboleth.sso/login?target=https://<your-site>/basicshib/login`, or
- The **Shibboleth login block** (`basicshib_login`) — place it in a region through
  **Block layout**. It builds the SP login URL for you (validating any internal
  target), is hidden from users who are already logged in, and uses your
  configured **Login link label**.

## Auth-filter settings — auto-create and role removal

The auth-filter controls what happens to accounts at login. **Every toggle here
defaults to OFF**, which is the safe starting point:

- **Allow user creation** — create a Drupal account automatically on a user's first
  SSO login. Leave off if only pre-provisioned users may log in.
- **Remove roles with no matching Grouper group** — strip Drupal roles at login
  that aren't backed by a Grouper group.
- **Remove the authenticated role** — remove the authenticated role at login if the
  user isn't in Grouper.
- **Remove the administrator role** — remove the administrator role at login if the
  user isn't backed by a Grouper policy. **Be careful:** if you have no Grouper
  policy that grants administrator, turning this on can strip admin from everyone.

Each toggle has an accompanying **error message** shown when the action is denied.

## Grouper — mapping groups to Drupal roles

Grouper is optional. Turn it on at **Configuration → BasicShib → Grouper settings**
(`/admin/config/basicshib/groupersettings`) by enabling Grouper and filling in the
group-to-role map. Once enabled, two more tabs appear:

1. **Policies** — each policy is a label plus a `;`-delimited set of Grouper group
   paths (and an optional description). Think of a policy as "membership in any of
   these groups."
2. **Authorizations** — map a **Drupal role → one or more Policies**. You can also
   assign policies directly from the role edit form under **People → Roles**
   (`/admin/people/roles`); BasicShib adds policy checkboxes there.

At each login, BasicShib reads the user's `isMemberOf` attribute (default server
variable `isMemberOf` / `HTTP_ISMEMBEROF`), splits it on `;`, compares it to your
policies, and adds or removes Drupal roles to match — saving the account only if
something changed.

## Session enforcement (automatic)

You do not configure this, but it is worth knowing: on **every** request BasicShib
checks that the tracked Shibboleth session id is still present and unchanged. If the
SP session disappears or changes, BasicShib logs the Drupal user out. This keeps the
Drupal session tied to the live SP session.

## A note on trust

Everything above assumes the attributes reaching Drupal come from your SP. Grant
*Administer basicshib*, *Administer authorization*, and *Administer policies* only
to fully trusted operators, since together they control how SSO identities become
Drupal roles (including who gets administrator).
