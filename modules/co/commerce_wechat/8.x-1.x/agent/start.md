<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce WeChat Pay — agent index

**WeChat Pay APIv3 gateway** for Drupal Commerce (Native/H5/JSAPI + refunds). Version **8.x-1.x**.
Core `~8.8 || ^9 || ^10`. Depends on `commerce_payment`, `yunke_qrcode`. Gateway plugin `wechat_pay`.

Security: reviewed SOUND. `onNotify()` calls `verifyNotify()` — real signature verification via
`CertificateVerifier` against the platform certificate with a 5-minute timestamp window — then decrypts
(AES-GCM, APIv3 key), binds by `out_trade_no`, and **checks amount + currency** before setting `completed`.
`onReturn()` re-queries WeChat and re-checks the amount and order ownership. The `NoopValidator` is used ONLY
during the initial platform-certificate bootstrap fetch (standard SDK chicken-and-egg), not in the notify path.
Anon routes `paymentCheck`/`returnPage` are read-only status pages (no state mutation). Store keys as secrets.
