# OpenID Connect Client — manual setup guide

**OpenID Connect Client** (`oidc`) makes Drupal a *relying party* in an OpenID
Connect flow, so your users authenticate against an external identity provider —
Keycloak, Microsoft Entra ID, Okta, Auth0, Google — instead of against Drupal's own
user table. OpenID Connect is an OAuth 2.0 flow with an identity layer, and it is the
current standard for single sign‑on in most new deployments.

The module implements the client side and depends on
[External Authentication](https://www.drupal.org/project/externalauth)
(`externalauth`), the shared contrib service that maps a remote identifier to a local
Drupal account — so the same account‑linking semantics apply here as in the SAML and
CAS modules. It supports **multiple realms**: each identity provider is configured as
a realm plugin with its own login route (`/oidc/login/{realm}`), so several providers
can coexist on one site. You can also replace or redirect `/user/login` to a realm so
users don't accidentally land on the default login page. New users can be given a
default role and a chosen username format.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (mind the PHP
   `gmp` extension requirement) and enable it.
2. [Configuration](configuration/index.md) — set up a realm (issuer, client ID and
   secret, roles), and the decisions that actually matter for an SSO project.

## Where it lives in the admin menu

Realms are configured from the admin interface, behind the **Administer OIDC**
permission (which is correctly marked as a restricted permission). Once a realm
exists, its login route is `/oidc/login/{realm}`.

## The three questions that decide an SSO project

Before you configure anything, settle these — they matter more than any single form
field:

1. **Existing local accounts** with matching email addresses — are they linked to
   the identity provider, or refused?
2. **Role derivation** from provider claims — who becomes an administrator, and what
   happens when the claim changes?
3. **Local password login** — kept as a fallback (and therefore still an attack
   surface), or closed off entirely?
