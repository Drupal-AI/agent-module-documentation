<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SecKit CSP Nonce adds automatic CSP nonce support to inline scripts, standalone or integrated with the SecKit module.

---

SecKit CSP Nonce adds automatic Content Security Policy (CSP) **nonce** support to inline scripts — so
inline `<script>` tags get a per-request nonce and the CSP `script-src` allows only nonce-tagged scripts,
letting a site use a strict CSP without `'unsafe-inline'`. It works standalone or integrates with the
Security Kit (SecKit) module for enhanced CSP, in the Security package.

Use it to harden CSP for inline scripts. This is a **positive security** feature: a nonce-based CSP is a
strong defense against cross-site scripting (XSS) — an injected inline script without the correct per-request
nonce won't execute. When adopting: ensure your CSP is actually configured to require the nonce (drop
`'unsafe-inline'`), and that all legitimate inline scripts get the nonce (otherwise they break). It has no
access-control role. Configure the CSP nonce behaviour (and SecKit CSP).

---

- Add CSP nonce support to inline scripts.
- Tag inline scripts with a per-request nonce.
- Allow only nonce-tagged scripts.
- Enable a strict CSP without unsafe-inline.
- Work standalone or with SecKit.
- Harden CSP against XSS.
- Ensure the CSP requires the nonce.
- Drop 'unsafe-inline'.
- Ensure legitimate inline scripts get the nonce.
- Have no access-control role.
- Configure the CSP nonce.
- Strengthen CSP.
- Defend against XSS.
- Configure SecKit CSP.
- Add nonces.
- Harden inline scripts.
- Configure the nonce.
- Improve CSP.
- Enable nonce CSP.
- Protect against script injection.
