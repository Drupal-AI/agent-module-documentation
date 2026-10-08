# TAPIS Auth — manual setup guide

**TAPIS Auth** (`tapis_auth`) is the authentication layer for the TAPIS suite of
modules. To call TAPIS APIs on behalf of a site user, Drupal needs a valid JWT
access token that represents that user — and only TAPIS's own Tokens service can
mint those. This module makes Drupal act as the *Authenticator service*: it uses
Drupal's service credentials to obtain a token representing the site itself, then
uses that to mint per-user JWT access tokens on demand whenever a user performs a
TAPIS operation (submitting a job, creating an app, and so on). It also refreshes
tokens automatically when a user's stored token has expired.

Because JWT access tokens are only valid within a single TAPIS tenant, this module
builds directly on **TAPIS Tenant**, which is its one module dependency. It
provides a reusable Drupal service that the other TAPIS modules call to
authenticate users, and it registers its own permissions.

There is no configuration form of its own — it works as the token-minting engine
behind the rest of the suite. What matters most here is secret handling: this
module obtains and holds **TAPIS access tokens and service credentials**. Treat
those as sensitive secrets — store them via the Key module or environment
variables, never commit them, protect the stored tokens, and always authenticate
over HTTPS.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and its TAPIS Tenant dependency.

## How to use it

You do not interact with TAPIS Auth directly day-to-day; it runs quietly whenever
another TAPIS module needs an authenticated call. Make sure your TAPIS Tenant is
configured first (with the service credentials stored as a Key), then enable this
module. From then on, when a user first performs a TAPIS operation, Auth mints and
stores a JWT token for them automatically and reuses or refreshes it as needed.
