# OAuth2 Client — manual setup guide

**OAuth2 Client** (`oauth_client`) puts a user‑facing workflow on top of Drupal's
[Simple OAuth](https://www.drupal.org/project/simple_oauth) module for
**requesting and managing OAuth2 client applications**. Instead of an administrator
hand‑creating every consumer, people with the right permission can request a
client with a predefined set of scopes, and privileged users approve or reject
those requests through a small moderation workflow. When a request is approved,
the module creates the corresponding OAuth2 client (a Simple OAuth *consumer*)
automatically.

It focuses on obtaining tokens for the **client_credentials** grant so the site —
or an approved client — can call external OAuth2‑protected APIs. In this release
the interactive **authorization_code** login grant is **not yet enabled**, which
means there is no end‑user browser login flow here and therefore no login‑CSRF
surface to worry about. It depends on core's Options, User, and Views modules and
on Simple OAuth (`drupal/simple_oauth:^6`), and it provides its own permissions.

Because the module deals in OAuth2 **client credentials and issued tokens**, treat
those as sensitive: the client **secret** should be handled as a secret, stored
tokens should be protected like any credential, and token requests should always
travel over HTTPS. The [Configuration](configuration/index.md) page walks through
where those pieces live.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside Simple
   OAuth, and enable the module.
2. [Configuration](configuration/index.md) — define scopes, create a client
   request type, assign permissions, and moderate incoming requests.

## Where it lives in the admin menu

The module does not register a single top‑level settings form. Instead:

- **Users** request clients from the **OAuth2 client requests** tab on their own
  account settings.
- **Administrators** review, approve, or reject those requests at
  **Configuration → Web services → Consumer → OAuth Client Request**
  (`/admin/config/services/consumer/oauth-client-request`).

Scopes and the underlying consumers are managed in Simple OAuth. See
[Configuration](configuration/index.md) for the full flow.
