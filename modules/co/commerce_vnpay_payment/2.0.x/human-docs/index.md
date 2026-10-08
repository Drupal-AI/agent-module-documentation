# Commerce VNPay — manual setup guide

**Commerce VNPay** (`commerce_vnpay_payment`) adds the Vietnamese **VNPay**
payment provider to Drupal Commerce as an **offsite‑redirect payment gateway**.
At checkout the customer is sent to VNPay's hosted payment page with a signed
request, pays there (VNPAY‑QR, ATM/domestic cards, or international cards), and is
then returned to your store's checkout — so card details are entered on VNPay's
side, not on your site.

The problem it solves is simple: it lets a Vietnam‑market Commerce store accept
VNPay payments without building the redirect and signing logic yourself. The
outbound request to VNPay is signed with **HMAC‑SHA512** over the sorted
parameters, and the module passes the order id, the amount (multiplied by 100),
currency, and billing details, with a 15‑minute payment expiry.

It depends only on Commerce's **Payment** module (`commerce_payment`), and it
does **not** work on enable alone — you must add and configure a VNPay payment
gateway before it does anything. You will need your VNPay endpoint URL
(sandbox or production), your `vnp_TmnCode` (terminal/merchant code), and your
`vnp_HashSecret`.

> **Important security note.** The upstream project describes itself as "for
> testing only," and the module is **not covered by Drupal's security advisory
> policy**. As documented in the agent notes, the return handler currently
> treats a success response code (`vnp_ResponseCode == '00'`) from VNPay as proof
> of payment **without re‑verifying the returned `vnp_SecureHash` signature**, and
> there is no server‑to‑server IPN/notify callback. That means a determined
> customer could reach the checkout‑return URL with a forged success code and mark
> their own order as paid. **Do not deploy this gateway for real payments as‑is**
> — first verify (or add) return‑signature verification and a server‑side
> notification. See the [`agent/`](../agent/start.md) notes for details.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the VNPay payment gateway and
   enter your credentials.

## Where it lives in the admin menu

Commerce VNPay adds no top‑level admin page of its own. Like every Commerce
payment gateway, you create and configure it under **Administration → Commerce →
Configuration → Payment gateways** (`/admin/commerce/config/payment-gateways`),
where you choose **VNPay** as the plugin. See
[Configuration](configuration/index.md) for the field‑by‑field walkthrough.
