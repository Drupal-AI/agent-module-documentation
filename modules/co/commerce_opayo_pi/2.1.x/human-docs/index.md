# Commerce Opayo Pi — manual setup guide

**Commerce Opayo Pi** (`commerce_opayo_pi`) is a Drupal Commerce payment gateway for
**Opayo** (formerly Sage Pay, now part of Elavon), built on the Opayo **Pi REST
API** with **3‑D Secure** authentication. Its defining feature is that card details
are **tokenized in the shopper's browser** — the raw card number (PAN) never reaches
your Drupal back-end — and the 3‑D Secure step happens **inside an iframe** during
checkout for a consistent presentation.

The problem it solves is taking Opayo card payments while keeping your PCI scope
small: because the PAN is only ever submitted to Opayo, compliance is limited to
SAQ‑A / SAQ‑A‑EP. It supports Payment and Refund transaction types, adds Opayo
Transaction entity lists to the admin pages, collects the customer phone number that
3‑D Secure requires, and periodically cleans up expired payment methods and
transactions via cron.

This is not a works-on-enable module: it needs configuration in two places — a
generic settings form (Opayo credentials) and a Commerce payment gateway — plus the
Opayo checkout flow attached to your order types. It depends on Commerce **Payment**
(`commerce_payment`), **Phone International** (`phone_international`) and **Queue
Unique** (`queue_unique`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — set the Opayo credentials, add the
   payment gateway, attach the checkout flow and collect a phone number.

## Where it lives in the admin menu

The **generic settings** (vendor name, integration keys/passwords, record
retention) live at **Commerce → Configuration → Opayo Pi settings**
(`/admin/commerce/config/opayo_pi/settings`, permission *Administer opayo
transactions*). The **payment gateway** itself is added under **Commerce →
Configuration → Payment gateways** using the **Opayo (Pi integration)** plugin.
