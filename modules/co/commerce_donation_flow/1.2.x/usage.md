<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Donation Flow provides donation-oriented configuration and a tailored checkout flow for Drupal Commerce, letting a customer choose a donation amount.

---

Commerce Donation Flow adapts Drupal Commerce for donations rather than product sales. It ships a
donation-specific checkout flow and configuration so a visitor can enter or choose a donation amount
and complete payment without the full cart/product experience of a typical store. It builds on the
core Commerce order, price, payment and checkout subsystems, so the usual Commerce concepts —
orders, payment gateways, checkout panes — still apply; the module tailors them to the donation use
case (amount selection, a streamlined flow).

Use it when the goal is to collect one-off donations on a Drupal Commerce site: install alongside a
payment gateway, configure the donation flow, and expose the donation form. Because it relies on the
standard Commerce payment stack, pair it with a properly configured, signature-verifying payment
gateway (the security of the actual money movement lives in the gateway, not this module). It
provides its own permissions for administering the donation configuration.

---

- Collect one-off donations on a Commerce site.
- Let a donor choose or enter a donation amount.
- Provide a donation-specific checkout flow.
- Streamline checkout for donations vs product sales.
- Reuse Commerce orders and payment for donations.
- Configure the donation flow and amounts.
- Expose a donation form to visitors.
- Pair with a Commerce payment gateway.
- Administer donation configuration via permissions.
- Build a fundraising page on Drupal Commerce.
- Integrate donations into checkout panes.
- Map a donation to a Commerce order.
- Take donation payments through a gateway.
- Avoid full cart/product UX for donations.
- Set suggested donation amounts.
- Use commerce_order/price/payment/checkout together.
- Keep money-movement security in the gateway.
- Support recurring setup via a compatible gateway.
- Theme the donation form for a campaign.
- Report on donation orders like any Commerce order.
