<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Tpay — agent index

**Tpay (Poland) offsite-redirect payment gateway** for Drupal Commerce. Version **8.x-3.x**. Core `^9.3 || ^10`.
Depends on `commerce_payment`. Gateway plugin `tpay_redirect`; optional pluggable bank-selection step
(`CommerceTpayBankSelection` plugin type).

Security: `onNotify()` runs the bundled tpayLibs `checkPayment()` which **verifies the md5 checksum** against
the merchant secret; the signed **CRC** carries the order id so the confirmation is bound to the order, and it
**dedupes by remote tr_id**. Reviewed as SOUND (signature verified + order-bound). Store the merchant secret as
a secret; HTTPS. Note: does not compare paid amount to order total (partial-payment edge, not a forge).
