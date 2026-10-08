# Access Token Authentication — manual setup guide

**Access Token Authentication** (`access_token_auth`) registers a global
authentication provider for Drupal. When a request arrives carrying a valid token,
the module logs that request in as the token's owning user — or, optionally, as a
single configured "stub" service account. It is a lightweight way to give
API/machine clients authenticated access without the weight of OAuth.

A client authenticates by sending the token in an **`X-ACCESS-AUTH-TOKEN`**
request header (a query parameter of the same name is also accepted, but avoid it
— tokens then leak into server logs and referrer headers). Tokens are generated
with strong entropy (a SHA-256 hash of 64 random bytes) and can work in two modes:

- **Time-based** — the token is valid until it expires, using a configurable
  time-to-live (30–1800 seconds).
- **One-time** — the token is rejected after its first successful use.

Users manage and invalidate their own tokens, and administrators can invalidate
anyone's. A cron task can delete expired or used tokens automatically. Requests
that carry a token bypass the page cache (a dedicated request policy) so that a
cached response can never leak to the wrong user, and the token managers behind
the system are pluggable if you need custom storage.

The security posture is fundamentally sound — high-entropy tokens, empty/null
tokens rejected, per-user scoping — but a token is a bearer credential, so treat
it accordingly: **serve only over HTTPS**, prefer the header over the query
parameter, and keep TTLs short. Note too that after you generate a token, only its
last four characters are shown again, so copy it immediately.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form, the permissions,
   and generating a token.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Access Token
Authentication** (`/admin/config/services/access-token-auth`), and users list
their valid tokens at `/admin/config/services/access-token-auth/list`.
