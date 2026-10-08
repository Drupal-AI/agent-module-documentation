<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# miniOrange OAuth Server — agent index

Turns Drupal into an **OAuth 2.0 / OpenID Connect Identity Provider (IdP)** — register client apps, scopes,
keys; authenticate external apps' users (authorize/consent/SLO/webhooks). Config at `oauth_server_sso.setup`;
provides permissions. Version **3.0.0**. Core `^10||^11`.

**Security (it IS the auth server — correctness is critical):** targeted review found the key primitives
correct — codes/tokens/client-secrets use a **CSPRNG** (`bin2hex(random_bytes(32))`); the authorize endpoint
**validates `redirect_uri` against the client's registered allow-list** (RFC 6749 §3.1); TLS not disabled.
Keep **updated**; store secrets/keys securely; **HTTPS**; register **exact** redirect URIs; enable **PKCE**
for public clients; review scopes/consent.
