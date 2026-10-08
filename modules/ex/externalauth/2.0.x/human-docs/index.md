# External Authentication — manual setup guide

**External Authentication** (`externalauth`) is a low‑level helper module that
maps Drupal user accounts to identities from an external service — LDAP, OAuth,
SAML, "sign in with X", or any other single sign‑on provider. It keeps an
"authmap" that remembers, per provider, which external identifier (the
*authname*) belongs to which Drupal user, and it handles the common
login / register / link plumbing so that an authentication module only has to
supply the verified external identity.

This is a **developer building block, not an end‑user feature**. You will rarely
install it on its own — it is a dependency that many SSO and identity modules
pull in for you. It exposes two services: `Authmap` stores, reads, and deletes
the identifier mappings, and `ExternalAuth` implements the reusable flows
(`load()`, `login()`, `register()`, `loginRegister()`, `linkExistingAccount()`,
`userLoginFinalize()`). It also dispatches events so other modules can react
when a user logs in or is registered, or alter the authmap data before it is
saved, and it ships migrate plugins for importing legacy authmap rows.

The module works the moment you enable it — there is **nothing to configure**.
It has no settings page of its own. Its only visible surface is an administrative
listing of stored mappings under **People**, plus two permissions that gate who
can view and delete those mappings. It requires Drupal 10.1+ or 11 and has no
other module dependencies.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent — the service APIs, events, and
permissions in code — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

External Authentication has **no configuration form** (`configure` is null). Once
enabled, the only place it surfaces in the UI is the stored‑mappings listing at
**People → Authmap** (`/admin/people/authmap`), where an administrator can review
and delete individual external‑auth entries.

## How to use it

Because this is a developer helper, you "use" it from code — usually from an
authentication module that depends on it:

- **Register or log in an externally‑authenticated user** — after your provider
  has verified an identity, call `ExternalAuth::loginRegister($authname,
  $provider, …)` to log the matching Drupal user in, creating the account on
  first sign‑in. Use `login()` or `register()` if you want just one half of that
  flow, and `userLoginFinalize()` to finalize the session.
- **Link an existing account** — `linkExistingAccount()` attaches an external
  identity to an already logged‑in Drupal user.
- **Look up a mapping** — `Authmap::getUid($authname, $provider)` returns the
  Drupal user id for a given external identifier, so you never create duplicate
  accounts for the same person.
- **React to events** — subscribe to `externalauth.login` or
  `externalauth.register` to run your own logic when a user signs in or is
  created, or to `externalauth.authmap_alter` to change what gets stored.
- **Control access** — grant the `view authmap` and `delete authmap`
  permissions to trusted administrators so they can manage the mappings listing.
