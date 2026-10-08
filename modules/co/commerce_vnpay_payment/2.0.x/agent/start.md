<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce VNPay — agent index

**VNPay (Vietnam) offsite-redirect payment gateway** for Drupal Commerce. Version **2.0.x**. Core `^9.2 || ^10`.
Depends on `commerce_payment`. Gateway plugin `commerce_vnpay_payment`.

SECURITY FINDING (D3, payment bypass): the **outbound** request is HMAC-SHA512 signed, but `onReturn()`
(`src/Plugin/Commerce/PaymentGateway/VNPayOffsite.php`) trusts `vnp_ResponseCode == '00'` from the query and
creates a payment (state `authorization`) **without verifying `vnp_SecureHash`**. There is **no `onNotify`/IPN**.
A customer redirected to VNPay can skip paying and hit the checkout return URL with `?vnp_ResponseCode=00&
vnp_TransactionStatus=00&vnp_TransactionNo=x` to mark their own order paid. Amount is bound to the order total
(no cross-order), but the success is forgeable. Fix: recompute HMAC-SHA512 over the returned params with
`vnp_HashSecret` and reject on mismatch; add a server-to-server IPN. Do not deploy as-is for real payments.
