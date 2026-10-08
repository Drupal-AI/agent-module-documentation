# Simple OAuth: Fallback Header — manual setup guide

**Simple OAuth: Fallback Header** (`simple_oauth_fallback_header`) lets API
clients send their OAuth bearer access token in an **alternative HTTP header**
— `X-OAuth-Authorization` by default — instead of the standard `Authorization`
header. Optionally it can also read the token from an `access_token` query
parameter in the URL.

Why would you want that? The standard `Authorization` header is sometimes
already spoken for. If your site sits behind a server that uses basic or digest
HTTP authentication, or a reverse proxy or gateway that strips or rewrites
`Authorization`, or a client that reserves that header for another scheme, then
the OAuth token has nowhere clean to travel. This module gives it a second door:
put the token in `X-OAuth-Authorization` and the module copies it into the
`Authorization` header early in the request, so Simple OAuth then validates it
exactly as normal.

It is genuinely **plug-and-play**: install it, enable it, and it works with no
configuration. There is no settings form, no permission, and no admin page — the
only knobs are two optional lines in `settings.php` (covered in
[Configuration](configuration/index.md)). It depends on the **Simple OAuth**
module.

One thing to understand clearly: this is a **transport convenience, not a new
way in**. The token copied out of the fallback header is still fully validated by
Simple OAuth's normal token authentication, so an invalid or missing token grants
no access — there is no authentication bypass here. Two behaviours are worth
keeping in mind, though: when a fallback header (or query token) is present, it
**overwrites** whatever was in the real `Authorization` header for the rest of
that request; and turning on the GET-query option puts tokens into URLs, where
they can end up in server logs, browser history and `Referer` headers — which is
exactly why RFC 6750 discourages it.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the optional `settings.php` options
   for renaming the header and allowing the GET-query mode.

## How to use it

Once enabled, an API client can authenticate by sending its Simple OAuth bearer
token in the `X-OAuth-Authorization` header:

```
X-OAuth-Authorization: Bearer <access-token>
```

The module resolves the token in priority order — the custom header first, then
the `access_token` GET query (if you have enabled it), then the standard
`Authorization` header — and copies the winning value into `Authorization` before
Simple OAuth takes over. Everything downstream (token validation, scopes,
expiry) behaves exactly as it would for a normal `Authorization` request.
