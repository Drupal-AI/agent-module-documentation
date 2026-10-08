# Commerce Giftcard Mail — manual setup guide

**Commerce Giftcard Mail** (`commerce_giftcard_mail`) fills the gap between
[Commerce Giftcard](https://www.drupal.org/project/commerce_giftcard) and
[Commerce Email](https://www.drupal.org/project/commerce_email): it delivers the
"here is your gift card" email to the buyer when a gift card bought through an
order becomes active. In other words, when a customer purchases a gift card and
the order is paid, the recipient automatically receives an email with the card
details.

It works by plugging into the standard Commerce Email system rather than sending
mail itself. It registers a Commerce Email **event** called *Giftcard activated*
(bound to the `commerce_giftcard.giftcard_activated` event), so you author the
actual email — subject, body, recipient — in Commerce Email against that event.
To help you address and personalize the message, it adds two gift-card tokens:

- `[commerce_giftcard:email]` — the buyer's contact email, resolved from the gift
  card's purchasing order.
- `[commerce_giftcard:initial_amount]` — the amount from the purchase transaction.

The module has **no admin page, permission or settings form of its own** — all the
setup happens in Commerce Email. In the 2.x version, a required patch on Commerce
Giftcard (which adds the "activated" event and ensures activation only happens once
payment is confirmed) is applied automatically via Composer, so the mail goes out
on a *paid, activated* card rather than merely on order placement. It depends on
Commerce Giftcard and Commerce Email, and runs on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Commerce Giftcard / Commerce Email dependencies.

There is **no configuration page** for this module. You create the actual email in
Commerce Email, described in "How to use it" below.

## Where it lives in the admin menu

Commerce Giftcard Mail adds no page of its own. You configure the email it enables
under **Commerce → Configuration → Emails**
(`/admin/commerce/config/emails`), which is the Commerce Email interface.

## How to use it

1. Make sure **Commerce Email** and **Commerce Giftcard** (2.x) are installed and
   enabled (see [Installation](installation/index.md)).
2. Go to **Commerce → Configuration → Emails**
   (`/admin/commerce/config/emails`) and click to add a new email.
3. Choose the **Giftcard activated** event as the email's trigger.
4. Write the **subject** and **body**. Use the two provided tokens to personalize
   it — set the recipient to `[commerce_giftcard:email]` (the buyer's contact
   email) and include `[commerce_giftcard:initial_amount]` in the body to show the
   card's value. You can of course add other gift-card entity tokens too.
5. **Save.** From now on, when a purchased gift card is activated after payment,
   the customer receives your email automatically — no custom mail code required.
