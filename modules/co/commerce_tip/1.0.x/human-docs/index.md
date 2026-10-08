# Commerce Tip — manual setup guide

**Commerce Tip** (`commerce_tip`) adds an **optional tip / gratuity** to Drupal
Commerce checkout. It provides a checkout pane where the customer can voluntarily
add an extra amount to their order; that amount is recorded as an **order
adjustment**, so it flows into the order total and is charged along with the rest
of the payment.

It's a natural fit for restaurants, delivery services, charities, or any store
that wants to offer a gratuity or a round‑up at checkout. Because the tip is a
standard Commerce adjustment, it shows up on the order summary and receipts and is
handled by your existing payment gateway with no custom line‑item code. The tip is
always optional and customer‑entered — the amount is intentionally under the
customer's control, which is the point of a voluntary tip, not a pricing flaw.

The module depends on **Commerce** and **Commerce Checkout**. It has no settings
page of its own and no dedicated permissions — you turn it on by adding its
checkout pane to a checkout flow, and access simply follows the standard checkout
flow. You can also customize the pane's description text and offer tipping on some
checkout flows but not others.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no standalone configuration page** for this module. You configure it by
placing its checkout pane, described under "How to use it" below.

## How to use it

1. Enable Commerce Tip (see [Installation](installation/index.md)).
2. Go to **Commerce → Configuration → Checkout flows**
   (`/admin/commerce/config/checkout-flows`) and edit the checkout flow you want
   to offer tipping in.
3. Find the **tip** checkout pane, enable it, and drag it to the step and position
   where you want it to appear. You can adjust its description text here.
4. Save the checkout flow. Repeat only for the flows where you want tipping — leave
   the pane out of any flow that should not offer it.

At checkout, customers on that flow can now enter a tip amount. The tip is added to
the order as an adjustment, included in the order total, and captured as part of
the payment. To stop offering tips, simply remove the pane again.

## Verify

Place a **test order** through a flow with the tip pane enabled, add a tip, and
confirm it appears on the order summary, is included in the total, and is captured
by your payment gateway.

> **Note:** at the time of writing, this module is **not covered by Drupal's
> security advisory policy**. Review it before relying on it for a production store.
