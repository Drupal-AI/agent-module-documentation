# Commerce PayPal Dynamic Subscriptions — manual setup guide

**Commerce PayPal Dynamic Subscriptions** (`commerce_paypal_dynamic_subscriptions`)
is an **off-site** Drupal Commerce payment gateway for **recurring payments** through
the **PayPal Subscriptions (Billing) API**. At checkout it renders an off-site PayPal
button that redirects the customer to PayPal to approve a subscription against a
**subscription plan** you've created in the PayPal dashboard. PayPal then manages the
recurring billing.

The return handling is well guarded. When PayPal sends the shopper back with a
`subscription_id`, the gateway fetches that subscription **server-to-server** using
your merchant-authenticated PayPal credentials and verifies that the subscription's
`plan_id` matches the plan stored on the order **before** completing the payment —
protecting against plan spoofing and checkout race conditions. The completed
payment's amount comes from the **order total** (server-authoritative), not from any
client-supplied value, and the PayPal subscription id and status are stored on the
order. (One minor hardening note: the return check confirms the plan matches but does
not additionally assert the subscription status is ACTIVE/APPROVED; because the
amount is server-side and the subscription is fetched with merchant credentials, the
exposure is low.)

It depends on **Commerce PayPal** (`commerce_paypal`), which supplies the
OAuth-authenticated PayPal HTTP client / Checkout SDK (and the sandbox-vs-live host).
The gateway also dispatches subscription **create/cancel events** so you can add
custom redirect or post-create logic, and it provides a custom redirect URL on
cancel.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create a PayPal subscription plan and
   add the payment gateway.

## Where it lives in the admin menu

Like every Commerce gateway, it is added under **Administration → Commerce →
Configuration → Payment gateways** (`/admin/commerce/config/payment-gateways`) by
adding a new gateway and choosing the **Dynamic Subscriptions** plugin. You then
attach it to your checkout flow.
