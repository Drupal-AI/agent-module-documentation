# TFA Headless — manual setup guide

**TFA Headless** (`tfa_headless`) brings two-factor authentication to
headless/API logins. On a traditional site the **TFA** module handles the second
factor through the normal browser login form, but a decoupled or mobile client
authenticates over an API and never sees that form. This module bridges the two: it
integrates TFA with **Simple OAuth** so an API client must complete the second
factor before it is issued an OAuth token.

Concretely, it provides a small set of REST endpoints for a TOTP (Google
Authenticator-style) flow — generating a QR-code URI and seed, checking whether a
user has TFA enabled, registering a user for TFA, and verifying a login code — and
it alters the `/oauth/token` response so that a token is only handed over once the
second factor is satisfied. It depends on the **TFA**, **REST**, **User**, and
**Simple OAuth** modules; **REST UI** is a helpful companion for switching the
endpoints on. This module supports Drupal 9, 10, and 11.

Because it is an authentication control, its value rests entirely on being
**enforced, not bypassable**. After setting it up, test the real flow end to end
and confirm that a client genuinely *cannot* obtain a usable OAuth token without
completing the second factor — including the awkward cases such as refresh tokens
and any tokens issued before TFA was turned on. Keep your Simple OAuth keys and
secrets secured, and serve everything over HTTPS. This module is not covered by
Drupal's security advisory policy.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies, enable it, and switch on the REST endpoints.

## How to use it

The module exposes four endpoints for a TOTP second factor:

- `/api/totp/generate` — returns a URI for a QR code plus a seed, for the client to
  show during enrolment.
- `/api/totp/status` — reports whether TFA is enabled for the user.
- `/api/totp/register` — registers the user so they can use TFA.
- `/api/totp/login` — checks whether the supplied code authorises the login.

After enabling the module, turn these endpoints on under **Configuration → Web
services → REST** (the REST UI module gives you a friendly screen for this). Your
API client then walks the user through generating and registering a TOTP secret,
and supplies the code at login so that the altered `/oauth/token` response only
issues a token once the second factor checks out.
