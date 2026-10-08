# miniOrange OAuth Server — manual setup guide

**miniOrange OAuth Server** (`oauth_server_sso`) turns your Drupal site into an
**OAuth 2.0 / OpenID Connect (OIDC) Identity Provider (IdP)**. In other words,
Drupal becomes the login provider: external "client" applications — Salesforce,
Slack, Jira, WordPress, AWS Cognito, and any other OAuth/OIDC‑compliant app — send
their users to your Drupal site to sign in, and Drupal issues the tokens that log
them into those apps. It is single sign‑on with Drupal as the source of truth for
identity.

You register each client application, define the **scopes** it may request, manage
the **signing keys**, and control how the server responds (the user attributes and
roles shared back to the client). It supports the common OAuth2 grant types
(authorization code, implicit, password, client credentials, refresh token), OIDC
with JWT signing (HS/RS algorithms), consent, single logout, and webhooks. The
module lives in the miniOrange package and is configured at a single setup screen.

Because this module **is** the authorization server, its correctness is
security‑critical — a bug here would affect every app that trusts it. A targeted
review of the highest‑risk primitives found them sound: authorization codes,
tokens, and client secrets are generated with a cryptographically secure random
generator (`bin2hex(random_bytes(32))`); the authorize endpoint **validates each
request's `redirect_uri` against the client's registered allow‑list** (RFC 6749
§3.1), rejecting unregistered URIs; and the module makes its API calls over
standard TLS (certificate verification is not disabled). The [Configuration](configuration/index.md)
page explains how to keep it that way.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — register client apps, set redirect
   URIs, scopes, keys, and the security options that matter most.

## Where it lives in the admin menu

Once enabled, the server's configuration lives at its setup screen, the
`oauth_server_sso.setup` route. From there you register client applications, define
scopes and attribute/role mappings, and manage signing keys. The module provides
its own permissions, so grant access only to trusted administrators.
