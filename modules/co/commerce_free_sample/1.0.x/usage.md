<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Free Sample lets customers add one free sample product to their order during checkout. It adds a sample-selection widget to the checkout order-information step and manages a corresponding order item automatically.

A `field_free_sample` entity-reference field plus a custom `free_sample_widget` show a dropdown of configured sample products (only published products whose ids are in the `free_sample_ids` config) on the order-information checkout step. Selecting one removes any previous sample order item and adds the chosen product's default variation as a new order item; the widget is hidden on other checkout steps. Eligibility can be gated: if an `eligibility_field` and `eligibility_values` are configured, the sample is offered only when every order item's purchased variation matches. Settings — sample product ids, the sample product bundle, the order-item type, and the eligibility field/values — are at `/admin/commerce/free-samples` (`administer commerce_product`).

Operational note: the added order item's `unit_price` is taken from the selected variation's own price, so "free" depends on the sample products being priced at zero — it is not a discount/adjustment. Also, the checkout submit/AJAX handlers load the selected product by id and (unlike the widget, which limits options to `free_sample_ids`) do not re-verify that the submitted id is one of the configured samples; because the item is charged at the variation's real price this is a data-integrity rather than free-money concern, but configure sample products at price 0 and keep the widget options authoritative.
---
Configure which products are free samples, then customers pick one during checkout and it is added as an order item.
---
- Offer customers a free sample at checkout
- Let a customer choose one sample product from a list
- Add the selected sample as an order item automatically
- Replace a previously selected sample when a new one is chosen
- Restrict samples to orders containing qualifying products
- Gate eligibility on a product-variation field value
- Configure which products are available as samples
- Set the sample product bundle used for detection
- Set the order-item type used for the sample line
- Hide the sample widget on non-order-information steps
- Show only published sample products in the selector
- Update the order summary via AJAX when a sample is picked
- Price samples at zero so they are genuinely free
- Manage settings at `/admin/commerce/free-samples`
- Encourage upsell by bundling a free trial product
- Offer seasonal samples by swapping the configured product ids
- Limit one free sample per order