<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Giftcard Mail delivers the "here is your gift card" email when a gift card bought through an order becomes active. It bridges Commerce Giftcard and Commerce Email so the notification is driven by the standard email-event system.

It registers a Commerce Email event plugin, `giftcard_activated`, bound to the `commerce_giftcard.giftcard_activated` event and the `commerce_giftcard` entity, so you can configure an email (subject, body, recipient) in Commerce Email that fires when a gift card is activated. To address and personalize that mail it adds two gift-card tokens: `[commerce_giftcard:email]` (the buyer's contact email, resolved from the gift card's purchasing order item's order) and `[commerce_giftcard:initial_amount]` (the amount from the purchase transaction). The module's own composer file references a patch on Commerce Giftcard so activation happens only once payment is confirmed — i.e. the mail is meant to go out on a paid, activated card, not merely on order placement.

There is no admin route, permission or settings form of its own: configure the actual email in Commerce Email against the "Giftcard activated" event and use the two tokens for the recipient and amount. Ensure Commerce Email and Commerce Giftcard (2.x) are installed and the activation-on-payment behaviour is in place.
---
Create a Commerce Email on the "Giftcard activated" event and use the buyer-email/amount tokens to send the card to the purchaser.
---
- Email a gift card to the buyer when it is activated
- Trigger the mail from the giftcard-activated event
- Send the card only after payment is confirmed
- Address the email with the buyer's order contact email
- Include the gift-card amount in the email body
- Personalize the mail with `[commerce_giftcard:email]`
- Personalize the mail with `[commerce_giftcard:initial_amount]`
- Configure subject/body via Commerce Email
- Notify the purchaser rather than a fixed address
- Resolve the buyer from the gift card's purchase transaction
- Integrate Commerce Giftcard with Commerce Email cleanly
- Avoid custom mail code for gift-card delivery
- Deliver a redemption code to the customer automatically
- Cache-tag the token replacement on state for correctness
- Support gift cards sold as products in an order