# Commerce Recurring Log — manual setup guide

**Commerce Recurring Log** (`commerce_recurring_log`) adds **activity logs to
Commerce Recurring subscriptions**. It records lifecycle events — creation,
renewal, cancellation, payment, failure — directly against each Subscription
entity, giving administrators and support staff a clear, per-subscription trail of
what happened and when. The recorded events include subscription state transitions,
unit-price changes, and declined recurring payments.

The problem it solves is traceability. Without it, understanding why a particular
subscription renewed, lapsed, or failed means piecing the story together from
scattered sources. This module stores subscription events as entity logs
(revisions specific to subscription events) and surfaces them in a dedicated
**Subscription activity** section on the subscription's admin page, making
debugging and support far easier. It builds on Drupal Commerce's logging system and depends on **Commerce
Recurring** (`commerce_recurring`) and **Commerce Log** (`commerce_log`).

This is a **works-on-enable** module: there is nothing to configure. As soon as
you enable it, logging begins automatically for all subscriptions. The logs follow
Commerce Log's own access rules, and the module adds no access-control role of its
own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Commerce Recurring.

There is no configuration page — logging starts automatically on enable.

## Where it lives in the admin menu

Commerce Recurring Log adds no settings page. Its output appears as a
**Subscription activity** section on each subscription's admin page, where you
can review that subscription's recorded events.

## How to use it

1. Enable the module (see Installation) — no further setup is required.
2. Open any subscription's **admin page**; the log entries appear in their own
   **Subscription activity** section, listing state changes, price changes,
   declined payments, and other lifecycle events.
3. Use the trail when supporting a customer or debugging why a subscription behaved
   the way it did.
