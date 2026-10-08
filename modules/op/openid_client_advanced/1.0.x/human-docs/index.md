# OpenID Client Advanced — manual setup guide

**OpenID Client Advanced** (`openid_client_advanced`) is a hardened OAuth 2.0 /
OpenID Connect client plugin for the contrib **OpenID Connect** module. Where the
generic client gets you logged in, this one adds the extra token‑verification
steps that a security‑conscious integration wants: **ID‑token (JWT) signature
validation**, **nonce**‑based replay protection, and **PKCE (S256)**. It also
gives you flexible ways to supply the client secret — plain text, an environment
variable, or a file in a secrets directory — so you can keep credentials out of
configuration.

Crucially, it's built on the right foundation. It extends the OpenID Connect
module's client, so the OAuth **`state` parameter (the login‑CSRF check)**,
code→token exchange, and user mapping are still handled by OpenID Connect's own,
well‑tested code. This module *adds* verification on top: it can check the
provider signed the ID token with a key you trust, insist on a matching nonce, and
prove possession of the PKCE verifier at token exchange. When any of these checks
fail — a bad signature, a nonce mismatch, a missing PKCE verifier — the login is
rejected and logged, and a unique **trace ID** is shown to the user so support can
correlate the failure.

The module was written by AI agents, with the maintainer reviewing and taking
responsibility for the work.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in OpenID
   Connect, and enable the module.
2. [Configuration](configuration/index.md) — add an "OAuth 2.0 Advanced" client
   and turn on the security features.

## Where it lives in the admin menu

You configure the advanced client through the OpenID Connect module at
**Configuration → People → OpenID Connect**
(`/admin/config/people/openid-connect`). See
[Configuration](configuration/index.md).

## How to use it

Add a client in OpenID Connect and choose the **OAuth 2.0 Advanced** plugin, enter
the client ID and secret source, point it at your provider (by issuer URL with
auto‑discovery, or by entering the endpoints manually), and enable the security
features — PKCE, ID‑token signature validation, and the nonce. Then test a login.
