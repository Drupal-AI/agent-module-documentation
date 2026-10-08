# Bakery Single Sign-On — manual setup guide

**Bakery Single Sign-On** (`bakery`) lets a user log in once and be recognised
across several Drupal sites that share a second-level domain — `app.example.com`,
`docs.example.com`, `shop.example.com`, and so on. One site is designated the
**parent**: it authenticates the user and issues a cookie. The other **child**
sites read that cookie and trust it to establish the same session. It is the
classic single-sign-on problem within one organisation, solved the cookie way.

Because the cookie *is* the cross-site authentication token, the entire security
of the scheme rests on how that cookie is signed, verified and read. The cookie
is signed with **HMAC-SHA256** using a shared `bakery_key`, the payload is
encrypted, there is a freshness check to bound its lifetime, and — importantly —
the signature is verified *before* the payload is deserialized.

The shared **`bakery_key` is a master credential.** It must be identical on every
site in the group, and anyone who obtains it can forge an SSO cookie for any user
on any of those sites. Treat it with the seriousness of a master password: keep
it out of Git, out of configuration exports, and out of database dumps. See
[Configuration](configuration/index.md) for how to set the parent/child roles and
handle that key.

This module ships as a **3.x dev** release and supports Drupal 10.2 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   on the parent and each child site.
2. [Configuration](configuration/index.md) — set the parent/child roles, share
   the `bakery_key` safely, and the freshness window.
