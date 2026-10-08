<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Qcart (qcart) — agent index
**Attaches the external Qcart button script (`https://qcart.app/btn.js`) to every page.**

- **Version:** 22.5.x (date-based release 22.5.31)
- **Core:** >=8
- **Mechanism:** `qcart_page_attachments()` → library `qcart/library_qcart`
- **Library:** external JS `https://qcart.app/btn.js?trg=any` (header, async/defer), no local assets
- **No routes / permissions / services / config.**

**Security:** Loads and runs remote third-party JavaScript from `qcart.app` on all pages (supply-chain / privacy consideration; script served over HTTPS). No server-side cart, pricing, or order logic exists in the module, so there is nothing Drupal-side to tamper with. Page scoping requires editing the hook.
