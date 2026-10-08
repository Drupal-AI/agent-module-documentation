# Monitoring SSO — manual setup guide

**Monitoring SSO** (`msso`) is a project *bundle* that ships a **fork of the
contrib OAuth2 Server module** (`oauth2_server`, based on release 2.1.1) with some
extra custom code to support a monitoring / single‑sign‑on integration. When
enabled it turns your Drupal site into an **OAuth2 / OpenID Connect provider**:
other applications can send users to your site to log in and then receive tokens
representing that user.

Functionally it behaves like OAuth2 Server. It exposes the standard endpoints —
`/oauth2/authorize` and `/oauth2/token` (gated by the *use oauth2 server*
permission), plus public key endpoints at `/oauth2/certificates` and `/oauth2/jwk`
that publish only the RSA **public** key for clients to verify tokens. Servers,
scopes, and clients are managed as configuration entities under
**Administration → Structure → OAuth2 Servers**.

> **Important — do not run this on production.** The project's own description is
> explicit: this is an under‑development bundle that "just contains a copy of the
> OAuth2 Server module." For a real OAuth2/OIDC provider you should install the
> canonical [OAuth2 Server](https://www.drupal.org/project/oauth2_server) module
> instead. Because `msso` is a modified fork, it also carries custom behavior that
> differs from stock OAuth2 Server; treat it as an integration‑specific build and
> review its custom code before relying on it. It is not covered by Drupal's
> security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   bundled module.
2. [Configuration](configuration/index.md) — create a server, define scopes and
   clients, and grant the right permissions.

## Where it lives in the admin menu

The OAuth2 server management screens sit at **Structure → OAuth2 Servers**
(`/admin/structure/oauth2-servers`, route `oauth2_server.overview`), reachable by a
user with the **Administer OAuth2 Server** permission. End users who are allowed to
authorize client apps need the **Use OAuth2 Server** permission.
