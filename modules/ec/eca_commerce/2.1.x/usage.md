ECA Commerce exposes Drupal Commerce's events, condition plugins and two custom actions to the [ECA](https://www.drupal.org/project/eca) no-code automation engine, so you can build order/cart/checkout/product/payment/promotion workflows in a modeller (BPMN recommended) instead of writing an event subscriber.

---

The module is pure ECA glue: it defines no routes, permissions, Drush commands or config UI (`configure` is null). It ships three kinds of plugins. (1) A single derived **ECA event** plugin (`eca_commerce`) whose deriver turns every Commerce event constant into a start event an ECA model can react to — core, cart, checkout, order, order-item, payment, price, product, product-variation, promotion, coupon, store and tax events. Each event advertises **tokens** (e.g. `commerce_order`, `cart`, `commerce_product_variation`, `commerce_payment`) exposing the relevant entity from the underlying Symfony event so later ECA steps can read/modify it. Event groups are only registered when the matching Commerce submodule is installed (`class_exists` guards). (2) A derived **ECA condition** plugin (`eca_commerce_commerce`) that wraps every Commerce condition plugin (`plugin.manager.commerce_condition`) as an ECA condition evaluated against an `entity` context; because the BPMN modeller cannot render checkboxes, entity-select/autocomplete widgets are flattened to comma-separated ID textfields and checkbox fields are stripped. (3) Two custom **ECA actions** on `commerce_order_item` entities: `eca_commerce_change_price_in_cart` (set an order item's unit price from a number/token, USD only) and `eca_commerce_add_adjustment` (add a `custom` price Adjustment with method/type/label/amount/currency/percentage, token-replaced). Actions resolve a fallback currency from the order item's total price, its store, or the default store, finally `USD`. Everything is triggered by ECA models, which are trusted site configuration.

---

- React to a new order being placed (`order_insert`/`checkout_completion`) to send a notification or call a webhook via other ECA actions.
- Run business logic when an order is marked paid (`order_paid`), e.g. enrol the customer or fulfil a license.
- Apply a discount by adding a price Adjustment to an order item when it is added to the cart (`cart_order_item_add` + Add Price Adjustment action).
- Override an order item's unit price from a token/computed value with the Change Price in Cart action.
- Give a percentage-based surcharge or fee via the Add Price Adjustment action's `percentage` field.
- Trigger a workflow when the cart is emptied (`cart_empty`) or an entity is added to it (`cart_entity_add`).
- Assign or reassign an order to a user on `order_assign` and read the `commerce_customer` token.
- Alter an order's label at render time via `order_label` and the `commerce_order_label` token.
- React to product / product variation lifecycle events (create, presave, insert, update, delete, translation) for indexing or syncing.
- Filter selectable product variations (`product_filter_variations`) or the default variation (`product_default_variation`).
- React to the AJAX variation change on a product page (`product_variation_ajax_change`).
- Run logic on promotion and coupon lifecycle events (`promotion_*`, `promotion_coupon_*`).
- Filter which promotions apply to an order (`promotion_filter`).
- React to payment lifecycle events (`payment_create`/`payment_insert`/`payment_update`/…) for reconciliation.
- Filter the available payment gateways at checkout (`payment_filter_payment_gateways`).
- React to store lifecycle events (`store_*`) to keep external systems in sync.
- Hook into tax zone building (`tax_build`) or the customer profile used for tax (`tax_customer_profile`).
- Use any Commerce condition (order total, product category, store, etc.) as an ECA condition guarding a workflow step.
- Read commerce entities inside an ECA model through the event tokens (`commerce_order`, `commerce_order_item`, `commerce_product`, `commerce_payment`, `commerce_promotion`, `commerce_store`, `commerce_coupon`, …).
- Modify order item quantity/price logic on `cart_order_item_update` using the `commerce_order_item_original` token.
- React to the checkout completion-register step (`checkout_completion_register`) for guest-to-account conversion flows.
- Customize the number format definition on `price_number_format`.
- Build entirely no-code Commerce automations that previously required a custom module with event subscribers.
