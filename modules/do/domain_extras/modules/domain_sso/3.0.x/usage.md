Domain SSO lets a visitor who is signed in on one domain of a Domain Access network log in to another domain in the group through a short token handshake.

---

Domain SSO is a lightweight single sign-on layer for the Domain (Domain Access) suite that shares an existing login across the sibling domains of one Drupal install. It adds three routes and no config, forms, permissions, or plugins. An account menu link (`domain_sso.links.menu.yml`, menu `account`, labelled "SSO") points at `domain_sso.sso_login` (`/domain-sso`, `SsoController::login`), shown only to anonymous users (`_user_is_logged_in: FALSE`); that controller reads the active domain via the `domain.negotiation_context` service and redirects the browser to the network's default domain, calling `domain_sso.handshake.issue` (`/domain-sso/handshake-issue`, `IssueController::issue`) with the origin domain id and the referring URL. On the default (issuer) domain, if the browser already has a session, `IssueController` mints a JSON payload (`uid`, `iat`, `exp` = now + 60s, random 16-byte `nonce`, target `domain` id), signs it with `hash_hmac('sha256', payload, Settings::getHashSalt() . nonce)`, base64-encodes the payload and appends the signature (`token = base64(payload).signature`), records the nonce in the cache bin with a 5-minute TTL, and redirects to `domain_sso.handshake.consume` (`/domain-sso/handshake-consume`, `ConsumeController::consume`) on the target domain carrying the `token` (and optional `target`). `ConsumeController` splits and decodes the token, recomputes and compares the HMAC with `hash_equals`, checks `exp`, requires the nonce to still be present in the cache and deletes it (single use), loads the payload `uid`, calls `user_login_finalize()` to establish the session on the target domain, then redirects to the `target` URL or, if none, to the front page of the payload's domain (`TrustedRedirectResponse`). All three routes set `no_cache: TRUE` and `_maintenance_access: TRUE`. Requires the core `domain` module; because sessions are per-domain the network's domains must be distinct hosts (not a shared cookie domain) for the handshake to be meaningful.

---

- Add an "SSO" login link to the user account menu on affiliate domains.
- Let a user already signed in on the default domain sign in to a sibling domain without re-entering credentials.
- Carry an existing session from the network's default (issuer) domain to any other registered domain.
- Issue a short-lived (60-second) HMAC-signed handshake token for the current user via `/domain-sso/handshake-issue?domain=<id>`.
- Pass the target domain id as the `domain` query parameter when issuing a token.
- Include a `target` query parameter to send the user to a specific URL after the handshake completes.
- Consume a handshake token on the destination domain via `/domain-sso/handshake-consume?token=<token>`.
- Establish the destination-domain session programmatically with `user_login_finalize()`.
- Rely on a single-use cache-stored nonce so each token works only once.
- Rely on the token's `exp` field so stale tokens are refused.
- Redirect anonymous issuers to the standard `user.login` form with a `destination` back to the handshake.
- Resolve the active domain through the `domain.negotiation_context` service.
- Send the visitor to the network's default domain to perform the token issue step.
- Fall back to the payload domain's front page when no `target` is supplied.
- Run the handshake routes uncached and reachable during maintenance mode.
- Pair with Domain Access so one account spans many affiliate hosts with a single sign-in.
