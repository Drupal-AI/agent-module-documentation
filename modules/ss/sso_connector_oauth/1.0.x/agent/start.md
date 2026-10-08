<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SSO Connector – OAuth 2.0 — agent index

**OAuth 2.0 / OIDC IdP** (Auth Code + PKCE + RS256). Version **1.0.1**. Core `^11.2||^12`.

Defensive: validates client + redirect_uri, **enforces PKCE**, bounds state/nonce, RS256 ID tokens (security positive). Depends on `sso_connector`, core `user`/`help`.