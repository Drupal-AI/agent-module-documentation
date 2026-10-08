<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Tip adds a **tip / gratuity option to Commerce checkout**, letting the customer voluntarily add an
extra amount to their order that is recorded as an order adjustment.

Use it for restaurants, delivery, charities, or any store that wants to offer an optional gratuity or
round-up. It hooks into the Commerce checkout flow via a checkout pane and adds the chosen amount to the order
total.
---
- Requires `commerce` and `commerce_checkout`; enable with `ddev drush en commerce_tip`.
- Adds a **tip checkout pane** you enable/position in your checkout flow at
  `/admin/commerce/config/checkout-flows`.
- The tip amount is customer-entered on the checkout pane and applied as an order adjustment.
- No dedicated permissions; access follows the standard checkout flow.
- Uses Commerce's price/adjustment API so the tip is reflected in the order total and payment.
- Configure per checkout flow, so different flows can offer or omit tipping.
---
- Let customers add an optional tip at checkout.
- Record the tip as a Commerce order adjustment.
- Include the tip in the order total and payment amount.
- Offer tipping on selected checkout flows only.
- Support round-up / gratuity use cases.
- Position the tip pane anywhere in the checkout steps.
- Let the customer choose the tip amount.
- Reflect the tip in order totals and receipts.
- Integrate with existing payment gateways (charged as part of total).
- Use for restaurant/delivery gratuity.
- Use for donation-style round-ups.
- Keep tipping optional (no forced charge).
- Leverage Commerce's adjustment system (no custom line-item code).
- Show the tip line on the order summary.
- Disable tipping simply by removing the pane.
- Test that the tip flows through to captured payment.
