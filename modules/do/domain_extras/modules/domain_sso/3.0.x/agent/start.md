<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain SSO (domain_sso) 3.0.x

Lightweight single sign-on for a Domain Access network: carries an existing session
from the default (issuer) domain to another registered domain via a short token handshake.

## Facts
- **Dependency:** `domain:domain` (core Domain module). No other deps, no config, no
  permissions, no plugins, no services of its own. `domain_sso.info.yml`.
- **Routes** (`domain_sso.routing.yml`) — all `no_cache: TRUE`, `_maintenance_access: TRUE`:
  - `domain_sso.sso_login` — `/domain-sso` → `SsoController::login`. Requirement
    `_user_is_logged_in: FALSE` (anonymous only). Entry point on a domain where the visitor
    is not yet signed in.
  - `domain_sso.handshake.issue` — `/domain-sso/handshake-issue` (GET) →
    `IssueController::issue`. Requirement `_access: 'TRUE'`; mints a token for the
    already-authenticated visitor.
  - `domain_sso.handshake.consume` — `/domain-sso/handshake-consume` (GET, POST) →
    `ConsumeController::consume`. Requirement `_access: 'TRUE'`; verifies the token and
    establishes the session.
- **Menu link:** `domain_sso.sso_login` in the `account` menu, label "SSO", weight 20,
  link class `domain-sso-login-link` (`domain_sso.links.menu.yml`).
- **Token:** JSON payload `{uid, iat, exp=now+60, nonce, domain}`, base64-encoded, joined by
  `.` to a `hash_hmac('sha256', payload, Settings::getHashSalt() . nonce)` signature.
  Nonce = `bin2hex(random_bytes(16))`, recorded in the cache bin (`domain_sso_handshake_nonce.<nonce>`)
  with a 5-minute TTL and deleted on consume (single use). `IssueController.php:42-65`,
  `ConsumeController.php:28-61`.
- **Domain services used:** `DomainStorageInterface::loadDefaultDomain()` (issuer),
  `domain.negotiation_context::getDomainId()` (active domain, `SsoController.php:38-40`).
- **Session:** `user_login_finalize($user)` on the target domain (`ConsumeController.php:75`).
- **Tests:** `tests/src/Functional/DomainSsoTest.php` (three programmatic domains, cross-domain login).

## How it works
The visitor hits `/domain-sso` on domain B (anonymous) → redirected to
`handshake-issue` on the **default** domain A (where they have a session) → A mints and signs
a token and redirects to `handshake-consume` on B → B verifies the token and logs the user in.
Full sequence, route by route, in [sso-flow.md](sso-flow.md).

## Setup
No admin UI and no configuration. Enable `domain_sso` on a working Domain Access network whose
domains are distinct hosts (per-domain sessions). The "SSO" link appears in the account menu for
anonymous visitors; the network's default domain acts as the token issuer.

## Docs
- [sso-flow.md](sso-flow.md) — the full three-route handshake (issue → consume), token
  format, nonce handling, and redirect/return-domain behavior.
