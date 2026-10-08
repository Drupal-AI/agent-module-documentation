<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a configurable block that renders a payment form pointing at a Yandex.Money wallet, so a site can collect donations or contributions to a specified wallet number.

---

The module registers a single "Yandex Money Block" (`ymb_ymb`) that you place through the block layout and configure per instance: the receiver wallet number, a payment purpose/target, a suggested amount (default 200), an optional redirect URL after payment, and a description. The block's `build()` passes these values to a `ymb_block` theme template, which outputs the Yandex.Money payment form/link. There are no routes, permissions or services; all state is block configuration.

It is a lightweight fundraising widget rather than a full gateway integration — payment happens on Yandex's side once the visitor submits the form, so no card data or callback is handled by Drupal. Configuration is purely per-block, making it easy to place several wallets/purposes across a site. Because the form targets an external payment host, review the wallet number and amount fields per instance.

---
- Add a "donate to my Yandex.Money wallet" block to the site
- Collect contributions toward a fundraising target
- Configure the receiver wallet number per block
- Set a payment purpose/target label
- Preset a suggested donation amount (default 200)
- Add a description explaining the fundraiser
- Redirect the payer to a thank-you URL after payment
- Place multiple wallet blocks for different campaigns
- Show a payment form in a sidebar region
- Accept ad-hoc payments without a full commerce stack
- Point different blocks at different Yandex wallets
- Theme the payment form via the `ymb_block` template
- Offer a quick support/tip button on content pages
- Configure everything through the block layout UI
- Keep card handling entirely on Yandex's side
