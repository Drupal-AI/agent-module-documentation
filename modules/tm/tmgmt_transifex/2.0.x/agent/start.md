<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Transifex Connector (tmgmt_transifex) — agent index

TMGMT connector for the **Transifex** localization platform. Version **2.0.7**. Core `^8.8 || ^9 || ^10`. Depends on tmgmt.

Webhook route `/tmgmt_transifex_callback` is `_access: 'TRUE'` but **the controller verifies an HMAC-SHA256 signature**: recomputes `base64(hmac_sha256("POST\n{url}\n{date}\n{md5(body)}", secret))` vs the `X-Tx-Signature-V2` header, rejecting on unset secret / missing headers / mismatch before `updateJobWithTranslations`. Sound (minor: raw `echo` output + loose `==` on base64 sig — negligible).
