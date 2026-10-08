# SSO Connector – Cookie — manual setup guide

**SSO Connector – Cookie** (`sso_connector_cookie`) provides cross-subdomain single
sign-on for Drupal sites that live under a common parent domain — for example
`a.example.com` and `b.example.com`. Log in on one, and you are logged in on all
of them, with no redirect to or back-channel call to the Identity Provider.

It works by writing a single session cookie to the shared parent domain on an
authenticated response. That cookie is AES-256-CBC encrypted and HMAC-SHA256
signed, and every participating site validates it locally — checking the
signature, expiry, issued-at time, issuer/audience, and per-user revocation —
before logging the user in. Because validation is entirely local, there is no
round-trip to the IdP on each request. This is the classic shared-cookie SSO
pattern (similar to the older Bakery module), riding on the token infrastructure
that SSO Connector core provides.

The cryptography is handled carefully: it uses encrypt-then-MAC with HKDF-derived
encryption and MAC subkeys and a random IV, supports key rotation via an embedded
key id (with a grace window across old keys), and validates the cookie domain
against the host so it cannot write a cookie for a domain the site is not part of.
Logout genuinely clears the shared cookie across the whole domain, and there is an
optional sliding-expiry refresh cookie. If no key is present the module fails
closed, and a random key is seeded on install. Crucially, the cookie encryption
and MAC key material lives in `settings.php` or State, never in exportable
configuration — so keep those keys secret and consistent across the sites that
share them.

This is a submodule of the SSO Connector suite. It depends on **SSO Connector**
(`sso_connector`) and core **Help**, needs PHP with the OpenSSL extension, and
requires Drupal 11.2 (or 12). It only makes sense for sites that share a common
parent domain.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside SSO Connector.

## How to set it up

The essential piece is the **shared cookie domain** — the common parent domain
your sub-sites live under — and the **shared key material**. A random encryption
key is seeded on install, but for a real deployment you provision the key material
in `settings.php` or State and keep it identical across every site that shares the
cookie; otherwise each site would sign with a different key and the cookies would
not validate. Once the domain and keys are in place, log in on one sub-site and
confirm you are recognised as logged in on the others, and that logging out clears
the session everywhere.
