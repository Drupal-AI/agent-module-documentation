# Simple OAuth Token Exchange — manual setup guide

**Simple OAuth Token Exchange** (`simple_oauth_token_exchange`) adds the
[RFC 8693](https://datatracker.ietf.org/doc/html/rfc8693) **OAuth 2.0 Token
Exchange** grant to the [Simple OAuth](https://www.drupal.org/project/simple_oauth)
module. In short, it lets a client trade one token (a "subject token") for another
token that has **different scopes or audience** — the standard OAuth pattern for
delegation and service-to-service authorization in decoupled and API-driven
architectures.

Here is the kind of problem it solves. Imagine a decoupled front end that talks to
Drupal through a Backend-for-Frontend (BFF). The BFF holds a broad access token
with all the privileges the user needs. Now the user wants to upload a large file,
and proxying that upload through the BFF is undesirable or impossible (for example,
Vercel serverless functions cap request bodies at 4.5 MB). With token exchange, the
BFF can request a **new, narrowly scoped** access token — one that only permits the
file upload — using its existing token, and hand that limited token to the browser
to perform the upload directly. The powerful token never leaves the server.

The module registers a new grant type (a standard Simple OAuth grant plugin) and
provides its own permission. Token and scope validation follow Simple OAuth's own
rules, so its security model carries over unchanged. There is no configuration
form. It depends on the **Simple OAuth** module and has no submodules.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## How to use it

There is no admin settings page. Once enabled, the token-exchange grant becomes
available at Simple OAuth's token endpoint, and a client uses it by requesting the
RFC 8693 grant with its existing token as the subject token and the narrower scope
it wants. Because this involves granting one token the ability to mint another, set
up your Simple OAuth scopes carefully and grant the module's permission only to the
clients that genuinely need to perform token exchange. The scopes on the exchanged
token are validated by Simple OAuth's normal scope repository, so a client can only
obtain scopes it is actually allowed to hold.
