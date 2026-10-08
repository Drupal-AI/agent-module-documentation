<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple OAuth Redirect URI Wildcard — agent index

**Allows wildcard redirect URIs in Simple OAuth** (e.g. `https://*.example.com/callback`). Depends on
`simple_oauth`. Version **1.0.0**. Core `^10.3||^11`.

OAuth redirect-URI validation — **defensively implemented** (anchored `/^...$/i` regex, `preg_quote`, `*` = single
subdomain label with no dots, wildcard forbidden in the registrable-domain/TLD), so no substring/cross-domain
bypass. **Residual risk (inherent):** wildcards weaken OAuth's exact-match rule (OAuth2 Security BCP) — any matching
subdomain can receive codes/tokens (subdomain-takeover risk). Use only where you control **all** matching
subdomains; prefer exact URIs.
