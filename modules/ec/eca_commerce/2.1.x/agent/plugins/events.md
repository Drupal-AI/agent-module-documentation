# ECA Commerce events

Source: `src/Plugin/ECA/Event/CommerceEcaEvents.php` (+ `CommerceEcaEventsDeriver.php`).
One ECA event plugin `#[EcaEvent(id: 'eca_commerce', deriver: CommerceEcaEventsDeriver)]` whose
`definitions()` returns one derivative per Commerce event. In a model you select "ECA Commerce" and
then the specific event; the resulting plugin id is `eca_commerce::<id>` (schema key
`eca.event.plugin.eca_commerce::<id>`). Each derivative maps to a real Commerce event constant +
Symfony event class, so it fires exactly when Commerce dispatches that event.

**Availability is conditional.** A group is only registered if its Commerce submodule class exists
(`class_exists(CartEvents::class)`, `CheckoutEvents`, `OrderEvents`, `PaymentEvents`, `PriceEvents`,
`ProductEvents`, `PromotionEvents`, `StoreEvents`, `TaxEvents`). Core-group events are always present.

## Event ids by group

- **Core:** `filter_conditions`, `post_mail_send`, `referenceable_plugin_types`
- **Cart:** `cart_empty`, `cart_entity_add`, `cart_order_item_add`, `cart_order_item_update`,
  `cart_order_item_remove`, `cart_order_item_comparison_fields`
- **Checkout:** `checkout_completion`, `checkout_completion_register`
- **Order:** `order_assign`, `order_label`, `order_paid`, `order_profiles`, `order_load`,
  `order_create`, `order_presave`, `order_insert`, `order_update`, `order_predelete`, `order_delete`
- **Order item:** `order_item_load`, `order_item_create`, `order_item_presave`, `order_item_insert`,
  `order_item_update`, `order_item_predelete`, `order_item_delete`
- **Payment:** `payment_filter_payment_gateways`, `payment_load`, `payment_create`, `payment_presave`,
  `payment_insert`, `payment_update`, `payment_predelete`, `payment_delete`
- **Price:** `price_number_format`
- **Product:** `product_load`, `product_create`, `product_presave`, `product_insert`,
  `product_update`, `product_predelete`, `product_delete`, `product_translation_insert`,
  `product_translation_delete`, `product_default_variation`, `product_variation_ajax_change`,
  `product_filter_variations`
- **Product variation:** `product_variation_load`, `product_variation_create`,
  `product_variation_presave`, `product_variation_insert`, `product_variation_update`,
  `product_variation_predelete`, `product_variation_delete`,
  `product_variation_translation_insert`, `product_variation_translation_delete`
- **Promotion:** `promotion_filter`, `promotion_load`, `promotion_create`, `promotion_presave`,
  `promotion_insert`, `promotion_update`, `promotion_predelete`, `promotion_delete`,
  `promotion_translation_insert`, `promotion_translation_delete`
- **Coupon:** `promotion_coupon_load`, `promotion_coupon_create`, `promotion_coupon_presave`,
  `promotion_coupon_insert`, `promotion_coupon_update`, `promotion_coupon_predelete`,
  `promotion_coupon_delete`
- **Store:** `store_load`, `store_create`, `store_presave`, `store_insert`, `store_update`,
  `store_predelete`, `store_delete`, `store_translation_insert`, `store_translation_delete`
- **Tax:** `tax_build`, `tax_customer_profile`

## Tokens each event exposes

`getData()` returns entities from the fired event; the `#[Token]` attributes declare which token is
available on which event classes. Reference these in later ECA steps (e.g. `[commerce_order]`):

| Token | Meaning | Available on (event classes) |
|---|---|---|
| `cart` | The cart order entity | cart_empty/entity_add/order_item_add/remove/update |
| `commerce_order` | The order entity | checkout_completion_register, order_assign, all OrderEvent, order_label, order_profiles, payment_filter_gateways, promotion_filter |
| `commerce_order_item` | The order item | cart_entity_add, cart_order_item_add/remove/update, order_item_comparison_fields, all OrderItemEvent, tax_customer_profile |
| `commerce_order_items` | Array of order items | cart_empty |
| `commerce_order_item_original` | Item state before update | cart_order_item_update |
| `commerce_order_item_comparison_fields` | Fields to compare | cart_order_item_comparison_fields |
| `commerce_order_label` | The order label | order_label |
| `commerce_order_payment_gateways` | Gateway config | payment_filter_payment_gateways |
| `commerce_customer` | Customer (Drupal user) | order_assign |
| `commerce_coupon` | Coupon entity | coupon events |
| `commerce_payment` | Payment entity | payment events |
| `commerce_definition` | Number format definition | price_number_format |
| `commerce_product` | Product (not variation) | filter_variations, default_variation, product events |
| `commerce_product_attribute_value` | Attribute value | product attribute value event |
| `commerce_product_variation` | Variation entity | variation ajax change, variation events |
| `commerce_product_variations` | Array of variations | filter_variations |
| `commerce_product_variation_default` | Default variation | product_default_variation |
| `commerce_product_variation_response` | AJAX response | product_variation_ajax_change |
| `commerce_product_variation_view_mode` | View mode | product_variation_ajax_change |
| `commerce_promotion` | Promotion entity | promotion events |
| `commerce_promotions` | Array of promotions | promotion_filter |
| `commerce_store` | Store entity | store events |
| `commerce_tax_plugin` | Local tax type plugin | tax_build |
| `commerce_tax_zones` | Array of tax zones | tax_build |
| `customer_profile` | Customer profile | tax_customer_profile |
| `profiles` | Array of customer profiles | order_profiles |
| `entity` | Purchasable entity | cart_entity_add |
| `quantity` | Float quantity | cart_entity_add, cart_order_item_add |

Any key not matched falls back to `parent::getData()` (ECA base tokens).
