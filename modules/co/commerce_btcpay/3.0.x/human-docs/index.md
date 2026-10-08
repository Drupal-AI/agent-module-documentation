# Commerce BTCPay — manual setup guide

**Commerce BTCPay** (`commerce_btcpay`) is a Drupal Commerce payment gateway for
**BTCPay Server**, the self‑hosted, open‑source cryptocurrency payment processor.
It lets your store accept **Bitcoin and other cryptocurrencies** (including
Lightning Network payments and altcoins your BTCPay Server supports) with no
third‑party intermediary, through an off‑site redirect flow. It depends on
Commerce Checkout and Commerce Payment (`commerce_checkout`,
`commerce_payment`).

Payment confirmation is handled correctly. The webhook (IPN) handler verifies the
`BTCPay-Sig` **HMAC signature** over the raw request body, and on both the return
leg and the notification the module **re‑fetches the current invoice status
directly from your BTCPay Server** (`getInvoice()`) and records the payment based
on that verified status — the posted event type and the return URL are never
trusted to decide the outcome. Each update also cross‑checks the invoice against
the right payment, order, store, and amount/currency. The notification route is
public (`_access: TRUE`, standard for a Commerce IPN), but it is safe precisely
because of the signature check and the authoritative re‑fetch. That means a forged
or replayed notification cannot mark an order paid.

Version 3.x uses BTCPay Server's **Greenfield API** and is a breaking change from
1.x/2.x — uninstall older versions before installing 3.x. Pairing: save a
**disabled** gateway with your HTTPS BTCPay Server URL, click **Generate API Key**
to authorize a least‑privilege key on BTCPay, confirm on return, then explicitly
enable the verified gateway. The API key and webhook secret are stored encrypted in
Drupal's non‑exportable key/value storage (never in exported config), so you
re‑authorize per environment. Run everything over HTTPS. This release is marked
alpha (reported stable by the maintainers), so validate it for your version.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Commerce dependencies.
2. [Configuration](configuration/index.md) — add the gateway, pair with your
   BTCPay Server, and store the API key.

## Where it lives in the admin menu

Commerce BTCPay adds no page of its own. You configure it as a gateway under
**Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) — see
[Configuration](configuration/index.md).
