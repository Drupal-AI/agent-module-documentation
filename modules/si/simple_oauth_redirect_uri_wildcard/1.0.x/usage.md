<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple OAuth Redirect URI Wildcard allows wildcard redirect URIs in the simple_oauth module.

---

Simple OAuth Redirect URI Wildcard **allows wildcard redirect URIs** in Simple OAuth — so a consumer can
register a redirect URI like `https://*.example.com/callback` that matches subdomains, instead of a single exact
URI. It depends on the Simple OAuth module.

Use it only when you genuinely need subdomain-flexible redirect URIs. This touches OAuth's most safety-critical
control (redirect-URI validation), so know both the implementation and the residual risk. **Implementation
(defensively done):** matching converts the pattern to an **anchored** regex (`/^...$/i`) built with `preg_quote`,
where `*` becomes `[a-z0-9-_]+` — a **single subdomain label with no dots**, so it can't span domain boundaries or
match as a substring; and the validator **forbids the wildcard in the registrable-domain/TLD position** (you can
wildcard a subdomain, not `*` or `*.com`). That closes the usual wildcard-matching bypasses. **Residual risk
(inherent to the feature):** the OAuth2 Security BCP recommends **exact** redirect-URI matching precisely because a
wildcard like `*.example.com` lets **any** subdomain receive authorization codes/tokens — so if an attacker can
control or take over **any** matching subdomain (subdomain takeover, a compromised or user-content subdomain, shared
hosting), they can capture OAuth codes. Therefore use it only where you control **all** subdomains that match, keep
the wildcard as narrow as possible, watch for subdomain takeover, and prefer exact redirect URIs where you can. It
has no other access role. Configure the wildcard redirect URIs.

---

- Allow wildcard redirect URIs in Simple OAuth.
- Match subdomains with a pattern.
- Avoid registering many exact URIs.
- Depend on the Simple OAuth module.
- Touch OAuth's redirect-URI validation (safety-critical).
- Serve the OAuth flow.
- MATCH via an anchored regex (preg_quote; * = single subdomain label, no dots) — no substring/cross-domain bypass.
- FORBID the wildcard in the registrable-domain/TLD position (subdomains only).
- STILL inherently weaken OAuth's exact-match requirement (OAuth2 Security BCP).
- LET any matching subdomain receive codes/tokens (subdomain-takeover risk).
- Use it only where you control ALL matching subdomains + keep the wildcard narrow + prefer exact URIs.
- Configure the wildcard redirect URIs.
- Handle wildcard redirects.
- Match redirect URIs.
- Configure the wildcards.
- Validate redirects.
- Handle the OAuth flow.
- Register subdomains.
- Watch for takeover.
- Provide wildcard redirect URIs.
