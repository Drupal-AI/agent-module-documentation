# Google Customer Reviews — manual setup guide

**Google Customer Reviews** (`google_customer_reviews`) integrates Google's free
**Customer Reviews** program with **Drupal Commerce**. After a customer completes a
purchase, the module shows an opt‑in survey so Google can email them later and invite
a review of their order — feedback that feeds Google's seller ratings. It can also
place a **badge** block anywhere on your site to display your current Google Customer
Reviews rating.

There are two moving parts: a **checkout pane** that presents the survey opt‑in and
passes along the order details Google needs, and an optional **badge block**. The
checkout pane is placed automatically on the *complete* step of your default checkout
flow; you place it manually if you use other flows. The module depends on
**Commerce** and **Commerce Checkout**.

> **Privacy note.** To trigger the survey, the module sends **order details,
> including the customer's email and order ID, to Google**. That is an external
> transfer of personal data — disclose it in your privacy policy as appropriate for
> your jurisdiction.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your merchant ID, tune the opt‑in,
   and place the badge block.

## Where it lives in the admin menu

Settings are at **Configuration → Web services → Google Customer Reviews**
(`/admin/config/services/google-customer-reviews`). The badge is added through your
site's **Block layout** (**Structure → Block layout**).

## Things to expect

- The badge and survey only appear on the domain configured in your Google Merchant
  profile — they will **not** show in a local development environment.
- After you integrate the module, it can take up to a week for the Merchant Center
  dashboard to show survey statistics and for the "not functioning" warning to clear.
- The badge only shows a rating once you have collected enough reviews, evaluated per
  country — this is Google's policy, not a module limitation.
