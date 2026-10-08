# Headless IdP — manual setup guide

**Headless IdP** (`headless_idp`) authenticates a decoupled Drupal site against
an **external identity provider (IdP)** — so the IdP owns passwords, MFA, and the
user lifecycle, and Drupal runs as your API backend that trusts the IdP's tokens.
It saves you writing the fiddly, security-sensitive glue yourself: JWT
validation, MFA round-trips, and linking each external identity to a Drupal user.

It is **headless-first**: it exposes a JSON auth API (endpoints such as
`/auth/login`, `/session`, `/auth/challenge`, `/auth/logout`, and
`/auth/migrate`) that your front end (Nuxt, Next, or anything that speaks HTTP)
calls. There are no redirect flows, no session cookies, and no OAuth login
screens to theme — the front end sends JSON and Bearer JWTs, and Drupal verifies
them.

Four providers ship ready to use — **AWS Cognito**, **Okta**, and two Microsoft
Entra variants (workforce **Entra ID** and customer **Entra External ID /
CIAM**) — and a plugin API lets you add more. It handles the whole lifecycle, not
just login: password sign-in, MFA challenge/response, user enrolment, session
revocation, email/password sync, and refresh-token rotation.

Security hardening is built in rather than bolted on: JWKS signature
verification, algorithm-confusion rejection, strict issuer and audience binding,
per-user / per-IP / per-session brute-force rate limiting (mirroring core's flood
defaults), generic errors to avoid account enumeration, a configurable
password-complexity policy, and verified lazy migration of legacy passwords. It
depends on the [Simple OAuth](https://www.drupal.org/project/simple_oauth) and
[External Authentication](https://www.drupal.org/project/externalauth) modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Simple OAuth and External Authentication.
2. [Configuration](configuration/index.md) — choosing and configuring a provider,
   the trust model (JWKS, issuer/audience), and handling secrets.

## Where it lives in the admin menu

Headless IdP is administered through Drupal's configuration and provides its own
permissions. It also ships Drush commands to inspect providers, manage the
Drupal-to-IdP account links, migrate from `openid_connect`, and manage MFA
preferences. See [Configuration](configuration/index.md).

## How it works

Your front end signs the user in against the IdP and receives a JWT. It sends
that token to Drupal as a Bearer credential. Drupal verifies the signature
against the provider's published keys (JWKS), pins the issuer and audience, links
the token to a Drupal user through the External Authentication module, and then
treats the request as authenticated. There is a standalone evaluation rig (a DDEV
site with the module installed) if you want to try it before wiring it into your
own project.
