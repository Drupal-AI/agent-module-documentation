# Give — manual setup guide

**Give** (`give`) lets a Drupal site **accept donations**. It's aimed at
nonprofits and fundraising, and it gives potential donors a few easy ways to
contribute:

- **By credit card** through **Stripe** (Stripe's fee is roughly 2.9% + 30¢ per
  transaction).
- **By pledging to pay by cheque**.
- **By bank transfer** (noted as a low‑fee option).

You build **donation forms** inside your Drupal site, and the module stores
**donation records** and can produce donation reports. It automatically sends
**thank‑you emails** to donors, supports **recurring donation** options, and
integrates with the **Paragraphs** module so donation forms can be embedded in
rich page layouts. An optional **give_civicrm** submodule connects donations to
CiviCRM.

Because Give handles money and personal data, a few things matter from the start.
Store your **Stripe API keys as secrets** (never commit them), serve donation
pages over **HTTPS**, and — if you use Stripe **webhooks** to confirm payments —
make sure the **Stripe webhook signature is verified** so forged "payment
succeeded" events are rejected. Donation records contain donor **personal data**
(name, email, amount), so restrict access to them with the module's permissions
and handle them according to your privacy obligations.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and optionally add the CiviCRM submodule.
2. [Configuration](configuration/index.md) — set up payment methods, store your
   Stripe keys safely, and create donation forms.

## Where it lives in the admin menu

Give's settings are at the `give.settings` route, reached from the module's
*Configure* link on **Extend** or under **Configuration**. That's where you set up
payment methods and Stripe credentials. Donation records and reports are available
from the module's administrative pages.

## How to use it

1. Configure your payment methods and enter your Stripe keys (see
   [Configuration](configuration/index.md)).
2. Create one or more donation forms, optionally embedding them via Paragraphs.
3. Donors give by card, cheque pledge, or bank transfer; the module records each
   donation, emails a thank‑you, and — for recurring gifts — schedules future
   payments.
4. Review donations through the administrative reports.
