<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
miniOrange OAuth Server lets you configure client applications supporting OAuth 2.0 and OpenID Connect to turn Drupal into an Identity Provider.

---

miniOrange OAuth Server turns Drupal into an OAuth 2.0 / OpenID Connect (OIDC) **Identity Provider (IdP)**
— letting you register client applications, define scopes and keys, and have external apps authenticate their
users against your Drupal site (authorization-code and related flows, consent, single logout, webhooks). It
is configured at `oauth_server_sso.setup`, provides its own permissions, in the miniOrange package.

Use it to make Drupal the login provider for other applications. Because this module **is** the
authorization server, its correctness is security-critical. A targeted review of the highest-risk primitives
found them implemented correctly: authorization **codes/tokens/client-secrets are generated with a CSPRNG**
(`bin2hex(random_bytes(32))`), and the authorize endpoint **validates the request's `redirect_uri` against
the client's registered allow-list** (RFC 6749 §3.1 — rejecting unregistered URIs, requiring an explicit one
when multiple are registered), and it makes its API calls over standard TLS (verification not disabled). When
adopting: keep it **updated** (auth-server bugs are high-impact), store client secrets/signing keys securely,
serve everything over **HTTPS**, register **exact** redirect URIs per client, enable **PKCE** for public
clients, and review scopes/consent so clients only get what they need. Configure the OAuth clients, scopes
and keys.

---

- Turn Drupal into an OAuth2/OIDC IdP.
- Register client applications.
- Authenticate external apps' users.
- Define scopes and keys.
- Support authorize/consent/SLO/webhooks.
- Generate codes/tokens/secrets with a CSPRNG (random_bytes).
- Validate redirect_uri against the client allow-list (RFC 6749 §3.1).
- Make API calls over standard TLS.
- Keep the module updated (high-impact bugs).
- Store client secrets/signing keys securely.
- Serve everything over HTTPS.
- Register EXACT redirect URIs per client.
- Enable PKCE for public clients.
- Review scopes/consent.
- Configure OAuth clients/scopes/keys.
- Provide an identity provider.
- Handle SSO for external apps.
- Secure the auth server.
- Configure the IdP.
- Authenticate applications.
