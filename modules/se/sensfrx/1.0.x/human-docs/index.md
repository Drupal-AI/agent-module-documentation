# SensFRX Fraud Prevention — manual setup guide

**SensFRX Fraud Prevention** (`sensfrx`) integrates the [SensFRX](https://sensfrx.ai)
fraud‑detection SaaS into Drupal. It screens user events — logins, registrations,
profile updates, comments — and, when you run Drupal Commerce, orders and payments,
scoring each against SensFRX's risk engine so you can flag, block, or review
suspicious activity. Features include device intelligence, behavioural analysis,
cross‑session fraud linking, proxy/VPN risk scoring, multi‑accounting detection,
and real‑time risk scoring, all surfaced through an admin dashboard.

After you install and connect the module (using a SensFRX Property ID and Property
Secret Key from a free or paid SensFRX account), you choose which activities to
protect and set policies — Allow, Block, or Review — driven by SensFRX's risk
scores. A dashboard under the SensFRX admin section shows activity, risk scores,
device intelligence, and recent events.

> **Known issue in the shipped 1.0.2 release — breaks without Commerce Payment.**
> A code path references payment events unconditionally, so on a site *without*
> Drupal Commerce Payment the module can fatal and its routes fail to register —
> meaning it is effectively non‑functional (and its webhook returns 404) on
> non‑Commerce sites.
>
> Store the SensFRX credentials securely (env‑backed).

The module depends on core **User**, **System**, **Node**, and **Comment**;
Commerce is optional but needed for order/payment screening. It requires Drupal 10
or 11 and PHP 8.1+, and is not covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — connect your SensFRX account and set
   up protected activities and policies.

## Where it lives in the admin menu

After installation you are taken to **Administration → SensFRX → Setup**, and once
connected the **Administration → SensFRX → Dashboard** shows activity, risk scores,
device intelligence, and recent events.
