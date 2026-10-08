# Simple OAuth Revoke — manual setup guide

**Simple OAuth Revoke** (`simple_oauth_revoke`) adds the **token revocation
endpoint** described by [RFC 7009](https://tools.ietf.org/html/rfc7009) to the
[Simple OAuth](https://www.drupal.org/project/simple_oauth) module. Once enabled,
a client can call `/oauth/revoke` to tell the server that an access token or
refresh token is no longer needed, and the server invalidates it immediately.

Revocation is the part of OAuth that is easy to skip and matters most when
something has gone wrong. Without it, a token stays valid until it expires: logging
out of a mobile app invalidates nothing, uninstalling the app leaves a working
credential behind, and a token found in a log or a crash report cannot be turned
off. Access tokens are often short-lived enough to tolerate that. **Refresh tokens
are not** — they exist to be long-lived, so a leaked refresh token without a way to
revoke it is a standing grant into your site.

There is no configuration and no admin page. Enable the module and the endpoint
exists. It depends on the **Simple OAuth** module and has no submodules.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## How to use it

After enabling the module, an `/oauth/revoke` endpoint is available. To revoke a
token, send a **POST** request whose body is
`application/x-www-form-urlencoded` and contains a `token` parameter set to the
token you want to revoke:

```bash
curl --location 'https://example.com/oauth/revoke' \
  --header 'Content-Type: application/x-www-form-urlencoded' \
  --data-urlencode 'token=<the-token-to-revoke>' \
  --data-urlencode 'client_id=<client-id>' \
  --data-urlencode 'client_secret=<client-secret>'
```

The request must be authorized by the client that originally issued the token.
You can supply the `client_id` and `client_secret` in the request body (as above)
or via HTTP Basic authentication; alternatively, a bearer token may be used to
authorize the request.

Following RFC 7009, the endpoint deliberately returns **200 even for a token it
does not recognise**. That is intentional, not a bug: it stops an attacker from
using the endpoint to probe whether a particular token exists.

## A note on why the endpoint is public

The revocation route is intentionally public (the caller is a client presenting a
token and its own credentials, so authenticating the caller is the endpoint's job,
not the router's — this matches how RFC 7009 requires the endpoint to be
reachable). That design is correct, but there are three things worth confirming on
your specific site:

1. **Require client authentication for confidential clients** — otherwise anyone
   holding a token could revoke it. That is mostly self-harm, but it is still a
   denial-of-service against a client.
2. **Make sure revoking a refresh token also revokes its access tokens** —
   revoking one and leaving the other is a partial logout that looks complete.
3. **Apply flood control** to this unauthenticated POST endpoint, as you would for
   any public POST route.
