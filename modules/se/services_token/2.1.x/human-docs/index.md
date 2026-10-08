# Services Token — manual setup guide

**Services Token** (`services_token`) gives your Drupal web services a stateless,
token-based authentication method. An API client authenticates once with normal
credentials, receives a signed token, and then presents that token on every later
request — no server-side session, no cookie, and no need to send the user's password
again. It is a natural fit for REST or JSON:API clients, mobile apps, and
subscription-style paid-content delivery.

The token is a self-contained string of the form `hex(uid).hex(expire).hmac`. The
client sends it as the HTTP Basic **username** with an empty password. On each
request the module recomputes the SHA-256 HMAC and compares it in constant time
(resisting timing attacks), then checks the expiry — nothing is stored server-side.
Because the signature folds in the account's name, password hash and status, tokens
self-invalidate automatically when the user changes their password or gets blocked.
Tokens also expire after a configurable lifetime (30 days by default), and
authenticated responses are automatically kept out of the page cache so they can't
leak.

The module works once enabled, but you'll do a little setup: grant the
token-generation permission to the right roles, and optionally set a dedicated
signing key and lifetime in `settings.php`. It has no admin settings form — its
configuration lives in permissions and `settings.php`. It needs no other modules,
though it is designed to sit alongside core's **RESTful Web Services** (`rest`)
and/or the contrib **Services** module. Supports Drupal 10 and 11.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install, enable, grant the permission,
   and set the optional `settings.php` knobs.

## How to use it

There is no configuration page. After installing and granting the **`generate
services token`** permission (see [Installation](installation/index.md)), clients
work with tokens like this:

**Generate a token** — the client POSTs to the generate endpoint, authenticating
with normal credentials, and gets back the token and its expiry:

```bash
curl -XPOST http://my_username:topsecret@example.com/api/services_token/generate
# {"expires":"2015-12-07T20:39:47+0100","token":"1.5665e083.RJG0Cdym..."}
```

**Use the token** — send it as the HTTP Basic username with an empty password:

```bash
curl -XGET http://1.5665e083.RJG0Cdym...:@example.com/api/user/1
```

**Regenerate** — POST to the same generate endpoint with the current token to renew
before it expires, so a client can refresh itself automatically.

Token generation is exposed both as a REST resource
(`POST /services_token/generate`) and as a Services module endpoint at
`services_token/generate`. Always use HTTPS — neither the token nor the initial
credentials are safe over an insecure connection.
