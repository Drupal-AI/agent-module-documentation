# REST API Access Token — manual setup guide

**REST API Access Token** (`rest_api_access_token`) adds **token-based
authentication** to Drupal's REST and JSON:API endpoints, so a decoupled front end,
mobile app, or external client can authenticate without cookies. A client logs in
once with a username/email and password, receives a token, and then sends that
token in an `X-AUTH-TOKEN` header on subsequent requests. The module also provides
logout endpoints (single device and all devices), an optional per-request signature
check, and an optional per-user response cache.

When a client calls the login endpoint, the module verifies the credentials with
Drupal's own password system and mints two values: a **public token** (the bearer
credential the client sends on each request) and a **secret** (used only if you
enable signature verification). Both are generated from a cryptographically secure
random source and stored in the module's database table. From then on, the module's
authentication provider recognises the `X-AUTH-TOKEN` on incoming requests, loads
the matching user, and authenticates the request. A cron job automatically prunes
tokens older than a configurable lifetime.

Because tokens are credentials, how you handle them matters, and there are a few
defaults to know about before you rely on this in production:

> - **The token is accepted from the URL query string as well as the header.**
>   Send the token in the `X-AUTH-TOKEN` header. This behaviour cannot be turned
>   off in the module.
> - **Signature verification is OFF by default.** Enable it if requests should
>   also require the secret.
> - **Token lifetime defaults to infinite.** Set a finite `token_lifetime_hours`
>   for production.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the admin permission.
2. [Configuration](configuration/index.md) — the settings form: login by
   name/email, signature verification, response cache, and the two lifetimes.

## Where it lives in the admin menu

The settings form is at **Configuration → System → REST API Access Token**
(`/admin/config/system/rest_api_access_token`), reachable by users with the
**Administer rest api access token** permission. The authentication itself is
handled by API endpoints, not admin pages:

- `POST api/v1/auth/token` — log in, returns `{ token, secret, userId }`.
- `POST api/v1/auth/logout` — log out the current device (revoke this token).
- `POST api/v1/auth/logout-from-all-devices` — revoke all of the user's tokens.

## How to use it

1. In the settings form, choose whether clients log in by **username**, **email**,
   or both, and set a finite **token lifetime** for production.
2. Have your client `POST` credentials to `api/v1/auth/token` and store the returned
   **token** (and the **secret**, if you enable signatures).
3. On every subsequent API request, send the token in the **`X-AUTH-TOKEN`
   header** (not the query string).
4. To harden things, enable **signature verification** so each request must also
   carry a valid `X-AUTH-SIGNATURE` computed from the secret — that way a stolen
   public token alone is not enough.
5. Call the logout endpoints to revoke tokens when a user signs out.

Developers can also subscribe to the module's login/logout events (for example to
enforce a single active session per user) — see the
[`agent/`](../agent/start.md) docs.
