# Commerce Moneris Checkout — manual setup guide

**Commerce Moneris Checkout** (`commerce_moneris_checkout`) is a Drupal Commerce
payment gateway for **Moneris Checkout (MCO)**, Moneris's hosted checkout used by
Canadian merchants. It embeds the **Moneris Checkout iframe** into the payment step
of Commerce's checkout, so the customer enters their card in Moneris's own hosted
form while staying on your checkout page. It builds on Commerce Core's offsite
payment gateway functionality.

When the customer finishes paying, the module confirms the result in a trustworthy
way: it checks the response code, then **fetches the Moneris receipt server-side**
(a direct server-to-Moneris API call) and **verifies that the receipt's order
number matches the order's stored data** before recording the payment. Because the
confirmation is authenticated against Moneris rather than read from the returning
request, a forged or mismatched return is rejected.

Using it requires a matching **Moneris Checkout profile** configured in your
Moneris account (the module's README walks through the shared test environment,
and the same steps apply to a live account with your own login and API key). It
depends on Drupal Commerce's Payment module and a required Moneris PHP library
(installed via Composer), and targets **Drupal 9, 10, and 11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set up a Moneris Checkout profile and
   add the gateway with your Moneris credentials.

## Where it lives in the admin menu

Commerce Moneris Checkout adds no admin page of its own. Like every Commerce
payment gateway, you configure it under **Administration → Commerce →
Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), where you add a new gateway of type
**Moneris Checkout**.
