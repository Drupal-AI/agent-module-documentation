<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fundraise Up JS (fundraiseup_js) — agent index
**Injects the Fundraise Up donation widget loader into every non-admin page and exposes its JS API.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Route:** `fundraiseup_js.config` → `/admin/config/services/fundraiseup-js` (form)
- **Permission:** `administer fundraise up js configuration`
- **Mechanism:** `hook_page_attachments()` adds the CDN bootstrap `<script>` + inline live-mode flag; behavior `js/fundraiseup_js.js` binds `data-fundraiseup-js-open-checkout`.

Third-party script loaded from `https://cdn.fundraiseup.com/widget/<site_id>`.

**Security:** admin config route gated by a dedicated permission; Site ID validated to `^[a-zA-Z_0-9]+$` and `Html::escape()`-d before output; no anonymous or mutating endpoints. Loads an external CDN script (note for CSP).
