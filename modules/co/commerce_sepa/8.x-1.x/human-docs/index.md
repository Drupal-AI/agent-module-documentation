# Commerce SEPA — manual setup guide

**Commerce SEPA** (`commerce_sepa`) adds an **on-site SEPA direct-debit** payment
method to Drupal Commerce. At checkout the customer supplies their **IBAN**
(validated by the module) and agrees to a **SEPA Direct Debit mandate**; the
store records that so it can later pull the funds through the SEPA banking
scheme. After the order completes, the module can email the customer the SEPA
Direct Debit Mandate document, which they complete, sign, and return.

It suits euro-area stores that want to collect payment by bank direct debit
rather than card. It depends on Commerce's **Payment** module
(`commerce_payment`) and adds no permissions or access role of its own.

There is one concept that is essential to understand before you rely on it: **SEPA
direct debit is asynchronous and mandate-based.** The module captures the IBAN
and mandate at checkout, but the money is not actually collected — and any
failure or chargeback does not surface — until the debit is processed later
through the bank. An order marked "processing" is therefore **not yet guaranteed
paid**; you must reconcile actual settlement out of band against your bank. Treat
the collected IBAN and mandate as **sensitive customer/bank data**: transmit and
store them securely and serve checkout over HTTPS.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the SEPA gateway and set the
   creditor / mandate details, field by field.

## Where it lives in the admin menu

There is no separate settings page. You configure it by adding a payment gateway
under **Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and choosing the SEPA plugin. See
[Configuration](configuration/index.md).
