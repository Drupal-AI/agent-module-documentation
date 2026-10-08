<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SSO Connector — agent index

**Enterprise SSO across multiple Drupal sites** (IdP/SP, short-lived JWTs). Depends on core `user`, `block`,
`help`. Provides permissions. Version **1.0.3**. Core `^11.2||^12`.

Authentication — **defensively built**: the IdP validates the SP against an **allowlist**
(`isAllowedServiceProvider`) before minting a token, redirects via `TrustedRedirectResponse`, short token expiry
(~120s). Keep the **JWT signing key secret/strong** (a leak forges SSO tokens for any user), keep the SP allowlist
tight, HTTPS.
