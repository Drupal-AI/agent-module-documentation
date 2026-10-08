# Commerce CCAvenue — manual setup guide

**Commerce CCAvenue** (`commerce_ccavenue`) provides an **off‑site redirect
payment gateway** that connects Drupal Commerce to **CCAvenue**
(www.ccavenue.com), one of the most widely used payment processors in India (and
the UAE). It's the go‑to option for Commerce stores that need to accept CCAvenue's
range of payment methods — credit cards, ATM/debit cards, direct bank debits, cash
cards, and mobile payments.

At checkout the gateway builds the merchant parameter set (order id, the amount
taken from the server‑side order total, currency, and billing details),
**AES‑128‑CBC encrypts it with your working key**, and auto‑POSTs the shopper to
CCAvenue's hosted payment page. When CCAvenue sends the customer back, the module
decrypts the encrypted response with the same working key, reads the payment
status, and on success creates a Commerce payment in the authorization state using
the order's own total. The return and cancel steps use Commerce's standard
checkout routes.

There are a few operational points worth knowing before you go live, covered in
[Configuration](configuration/index.md): both the "test" and "live" endpoints
currently point at the same production CCAvenue host, so test mode still transacts
against production; response authenticity rests entirely on the **shared working
key** (there is no separate signature), so protect that key carefully; and while
the charged amount is always taken from the order server‑side, the module does not
cross‑check the decrypted order id/amount from the response against the current
order in code.

Commerce CCAvenue depends on Commerce **Payment** (`commerce_payment`) and works
on Drupal 10.1 and 11. The project is currently seeking a co‑maintainer and is in
maintenance‑fixes mode, so pin your version and test upgrades.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Commerce Payment.
2. [Configuration](configuration/index.md) — adding the CCAvenue Redirect gateway,
   entering your credentials, and the operational notes to respect.

## Where it lives in the admin menu

Like every Commerce payment method, CCAvenue is set up under **Administration →
Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). You add a gateway there and choose the
**CCAvenue Redirect** plugin.
