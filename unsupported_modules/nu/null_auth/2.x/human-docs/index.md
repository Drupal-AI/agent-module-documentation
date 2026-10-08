# Null Authentication — manual setup guide

**Null Authentication** (`null_auth`) is a small **developer/testing utility**: a
"null" authentication provider. When a request carries the query parameter
`?_null_auth=1`, this provider handles it and authenticates the request as the
**anonymous** user (its `authenticate()` returns Drupal's anonymous user). Its
original purpose, from the project's own description, is enabling anonymous access
to REST resources using an auto‑login method — but it is equally handy for a
developer who is logged in and wants to fetch a page *as anonymous* to check how
it renders or caches.

There is a crucial safety property to understand: this provider can only
**downgrade** a request to anonymous. It never elevates privileges and never
impersonates another user, so it is not an authentication‑bypass in the sense of
gaining access — it can only *drop* to anonymous. That makes it far less
dangerous than the name might suggest.

> **Development and testing only — do not enable in production.** The module's own
> documentation carries a clear warning: it applies **no flood control** and
> grants auto‑login (as anonymous) for **all** requests that use the parameter.
> Use it **only in environments with controlled access**. It exists to make
> testing anonymous behaviour and anonymous REST access convenient, not to run on
> a live public site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (in a non‑production environment).

This module has **no configuration form** (`configure` is null). As its own docs
put it: "There is no specific configuration for this module, it enables
automatically a null authentication method." Usage is entirely a matter of adding
the query parameter to requests, described in "How to use it" below.

## How to use it

Add `_null_auth=1` to the request you want handled as anonymous. A common pattern
is enabling anonymous access to a REST resource for testing, using the contrib
[REST UI](https://www.drupal.org/project/restui) module to enable the resource
with the **null** authentication provider (and granting the relevant permission
to the anonymous user). For example, creating a user over REST as anonymous:

```
# 1. Get a CSRF token
GET /rest/session/token

# 2. Create a user, authenticated as anonymous via the null provider
POST /entity/user?_format=json&_null_auth=1
Headers:
  Content-Type: application/json
  X-CSRF-Token: <token from step 1>
Body:
  { "name": { "value": "userName" }, "mail": { "value": "userMail" } }
```

Because the provider forces the request to anonymous, whatever the request can do
is exactly what an anonymous user is permitted to do — which is why you scope
permissions carefully and only ever run this where access is controlled.
