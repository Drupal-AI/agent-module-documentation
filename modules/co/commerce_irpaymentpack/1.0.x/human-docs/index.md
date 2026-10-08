# Commerce Iranian Payment Pack — manual setup guide

**Commerce Iranian Payment Pack** (`commerce_irpaymentpack`) is a bundle of
**Iranian bank payment gateways** for Drupal Commerce. Instead of installing a
separate module for each bank, this one package gives you a set of gateways
covering the major Iranian banks and payment services — the project lists
**Mellat Bank, Melli Bank, ZarinPal, Zibal, Pasargad, Saman Bank (SEP)** and
**Saderat Bank**. It lets an Iranian merchant accept card payments through
whichever bank(s) they hold a merchant account with.

Each bank is offered as a standard Commerce **payment gateway** that you add and
configure like any other. The customer is redirected to the bank's hosted page to
pay, then returns to your store. It depends on **Commerce** (`commerce`) and
**Commerce Payment** (`commerce_payment`).

On the security front, the reviewed **Saman/SEP** gateway follows the correct
pattern for a redirect‑based payment: after the shopper returns from the bank, the
module **confirms the transaction server‑side with the bank** (a `VerifyTransaction`
call to the bank's authoritative endpoint) and only completes the Commerce payment
when that verification succeeds — it does not trust the browser's return alone.
That's the behavior you want. As always, treat each bank's **merchant credentials**
as secrets (see Installation and Configuration), and when you enable a specific
gateway, confirm its own return/verification flow for the version you install.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add a bank gateway, enter its
   merchant credentials, and choose test versus live.

## Where it lives in the admin menu

The gateways are configured under **Administration → Commerce → Configuration →
Payment gateways** (`/admin/commerce/config/payment-gateways`). Add a new payment
gateway, choose the bank you want (for example **Saman**), and fill in its
credentials as described in [Configuration](configuration/index.md).
