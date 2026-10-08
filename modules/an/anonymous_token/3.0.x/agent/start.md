# Anonymous Token — agent index

Extends core CSRF tokens to work for **anonymous users**. Core only issues/validates CSRF
tokens for authenticated users; this module forces a persistent anonymous session so a CSRF
seed can be stored, then reuses core's crypto to generate/validate tokens. Nothing is wired
automatically in 2.x/3.x — you opt in **per route**. Defensive/hardening; not an access grant.

- **Wire a route + generate/validate a token (the `anonymous_token.csrf_token` service, the
  `_anonymous_csrf_token` route requirement, single-use)** → [api/csrf.md](api/csrf.md)
- **Settings form, the one config key (`force_single_use`), permission** → [configure/settings.md](configure/settings.md)

Key facts:
- Service `anonymous_token.csrf_token` = `AnonymousCsrfTokenGenerator` (subclasses core `CsrfTokenGenerator`).
- Access check tag `_anonymous_csrf_token: 'TRUE'` on a route's `requirements` (subclasses core `CsrfAccessCheck`).
- Config `anonymous_token.settings:force_single_use` (bool, default `false`).
- Permission `administer anonymous csrf token`; config UI `/admin/config/system/anonymous-csrf-token`.
- Token = HMAC(site private key, value + session seed) — core crypto, not guessable.
