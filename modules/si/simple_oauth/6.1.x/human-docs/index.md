# Simple OAuth & OpenID Connect — manual setup guide

**Simple OAuth & OpenID Connect** (`simple_oauth`) turns your Drupal site into an
OAuth 2.0 authorization server, with OpenID Connect layered on top. In plain
terms: it lets external apps, mobile clients, and decoupled front ends log in and
call your site's REST or JSON:API endpoints securely, using bearer tokens instead
of storing a username and password. It is the de‑facto standard for securing a
headless or API‑driven Drupal.

It is built on the battle‑tested `league/oauth2-server` library and pairs with the
**Consumers** module — each client application you want to grant access to is
registered as a *consumer*. Simple OAuth then issues signed access tokens (and
optional refresh tokens) that let that client act as a Drupal user with a defined
set of **scopes**. Tokens are RSA‑signed with a public/private key pair, and the
module exposes the standard endpoints `/oauth/token`, `/oauth/authorize`,
`/oauth/userinfo`, `/oauth/jwks`, and `/oauth/debug`, plus a global `oauth2`
authentication provider so any route can accept `Authorization: Bearer …`.

Scopes are how you control what a token can do: they can be dynamic config
entities managed in the UI, or — with the bundled `simple_oauth_static_scope`
submodule — static, YAML‑defined plugins. Each scope maps to Drupal permissions or
roles. For developers, the module is extensible through grant‑type, scope‑provider,
and scope‑granularity plugins, and alter hooks let you inject custom JWT/OIDC
claims.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (note the PHP and
   library requirements), enable, and pick the submodule you need.
2. [Configuration](configuration/index.md) — the settings form: signing keys,
   scope provider, token cleanup, plus how scopes and consumers fit together.

## Where it lives in the admin menu

The main settings form is at **Configuration → People → Simple OAuth**
(`/admin/config/people/simple_oauth`). OpenID Connect has its own sub‑form at
`/admin/config/people/simple_oauth/openid-connect`. Client applications
(*consumers*) are managed under **Configuration → Web services → Consumers**
(`/admin/config/services/consumer`), provided by the Consumers dependency.

## How to use it

Getting a working OAuth server typically means four steps:

1. **Configure signing keys** on the settings form — generate an RSA key pair from
   the UI or with `drush simple-oauth:generate-keys`, and store the private key
   *outside* your web root.
2. **Create scopes** that map to the Drupal permissions or roles a client should
   have (see [Configuration](configuration/index.md)).
3. **Create a Consumer** at `/admin/config/services/consumer/add`, enabling the
   grant types (Client Credentials, Authorization Code, etc.) and scopes it may
   use. Set per‑consumer token expirations here.
4. **Request tokens** — clients POST to `/oauth/token` and then send
   `Authorization: Bearer <token>` on API requests. Use `/oauth/debug` to inspect
   a token's identity and access.

Expired tokens can be purged automatically on cron in configurable batches.
Developers can add custom private JWT claims via
`hook_simple_oauth_private_claims_alter()` and OIDC claims via
`hook_simple_oauth_oidc_claims_alter()` — see the [`agent/`](../agent/start.md)
docs for the API and plugin details.
