# Configuration

Setting up Simple OAuth has three moving parts: the **settings form** (signing
keys and global options), your **scopes** (what a token is allowed to do), and
your **consumers** (the client applications). This page walks the settings form
and explains how the pieces connect.

## Open the settings form

1. Log in as a user with the **Administer simple_oauth entities** permission.
2. Go to **Configuration → People → Simple OAuth**
   (`/admin/config/people/simple_oauth`).

## The settings form, field by field

- **Public key** — the filesystem path to the RSA public key, used to *verify*
  tokens.
- **Private key** — the filesystem path to the RSA private key, used to *sign*
  tokens. **Store this outside your web root** so it can never be downloaded.
- **Scope provider** — which system supplies your scopes. The default is
  `dynamic` (scopes are config entities you manage in the UI). Switch to `static`
  if you enabled the *Simple OAuth Static Scope* submodule and prefer YAML‑defined
  scopes.
- **Token cron batch size** — how many expired tokens are deleted on each cron
  run. `0` (the default) means no limit — every expired token is cleaned up each
  run. Set a number to spread the cleanup out on very busy sites.
- **Disable OpenID Connect** — leave unchecked to keep the OpenID Connect layer
  active (the usual choice). Check it only if you want pure OAuth 2.0 with no OIDC.

> **A note on token lifetimes.** Access, refresh, and authorization‑code
> expirations, "remember clients", and the implicit‑grant toggle are **no longer
> set here** — they moved to base fields on each **Consumer**. Set them per client
> when you create or edit a consumer, not globally.

## Generating the signing keys

You have three options:

- **From the UI** — the settings form has a *Generate keys* action that creates the
  RSA pair for you.
- **With Drush** — `drush simple-oauth:generate-keys /path/to/dir`.
- **By hand** — `openssl genrsa -out private.key 2048 && openssl rsa -in
  private.key -pubout > public.key`, then point the two path fields at the
  results.

## OpenID Connect settings

OpenID Connect has its own form at
`/admin/config/people/simple_oauth/openid-connect` for the OIDC‑specific options.

## Scopes — what a token can do

Scopes are the permissions model. With the default **dynamic** provider you create
scope entities in the UI; each scope maps, via a *granularity* plugin, to either
Drupal **permissions** (fine‑grained) or Drupal **roles** (coarse). You can also
build umbrella (parent) scopes that aggregate child scopes. A client only receives
the access its granted scopes describe.

## Consumers — the client applications

Each application that talks to your API is a **Consumer**, added at
`/admin/config/services/consumer/add`. On the consumer you enable the **grant
types** it may use (for example *Client Credentials* for server‑to‑server access,
or *Authorization Code* for third‑party user login), choose which **scopes** it
may request, and set its **token expirations**. Once a consumer exists, clients
request tokens at `POST /oauth/token` and then authenticate API calls with
`Authorization: Bearer <token>`.

## Putting it all together

1. Set the public/private key paths and generate the keys.
2. Choose the scope provider and create your scopes.
3. Create a consumer with the right grant types and scopes.
4. Have the client request a token from `/oauth/token`, and inspect it at
   `/oauth/debug` if you need to troubleshoot who it authenticates as.
