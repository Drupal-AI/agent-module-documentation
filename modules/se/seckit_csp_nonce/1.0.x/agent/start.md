<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SecKit CSP Nonce — agent index

Adds automatic **CSP nonce support to inline scripts** (per-request nonce; CSP allows only nonce-tagged
scripts → strict CSP without `'unsafe-inline'`). Standalone or with **SecKit**. Version **1.0.0**. Core
`^9||^10||^11`.

**Positive security** — nonce-based CSP is a strong **anti-XSS** defense (injected inline scripts without the
nonce won't execute). Ensure the CSP requires the nonce (drop `'unsafe-inline'`) and legitimate inline
scripts get it. No access role.
