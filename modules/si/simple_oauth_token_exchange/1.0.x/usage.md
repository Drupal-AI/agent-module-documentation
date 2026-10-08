<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple OAuth Token Exchange adds the RFC 8693 token-exchange grant to Simple OAuth.

---

Simple OAuth Token Exchange implements the RFC 8693 OAuth 2.0 Token Exchange grant for the Simple OAuth module — allowing a client to exchange one token (a subject token) for another with different scopes/audience, a standard pattern for delegation and service-to-service authorization in decoupled/API architectures.

It builds on Simple OAuth's token validation and scope repository (a standard grant plugin); token/scope security follows Simple OAuth. Depends on `simple_oauth`; supports Drupal 10.3+ and 11.

---

- Implement RFC 8693 token exchange.
- Add a token-exchange grant.
- Exchange a subject token for another.
- Adjust scopes/audience.
- Support delegation.
- Enable service-to-service auth.
- Build on Simple OAuth's validation.
- Use the scope repository.
- Depend on `simple_oauth`.
- Support Drupal 10.3+ and 11.
- Support decoupled/API architectures.
- Follow Simple OAuth security.
- Provide a grant plugin
- Configure exchange
- Handle OAuth flows.
- Support token delegation.
- Integrate with Simple OAuth.
- Exchange tokens
