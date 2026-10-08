<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Order create endpoint

`src/Plugin/rest/resource/OrderCreateResource.php` — plugin id
`commerce_decoupled_checkout_order_create`, `POST /commerce/order/create`. Returns the normalized
Commerce order entity (`ModifiedResourceResponse`, HTTP **201**).

Injected services: `entity_type.manager`, `datetime.time`, `module_handler`, logger channel
`commerce_decoupled_checkout`.

## Request payload
```jsonc
{
  "order": {
    "type": "default",          // optional, order bundle; default "default"
    "email": "customer@example.com", // optional; defaults to the user's email
    "store": 1,                  // optional store id; mapped to store_id; defaults to the default store
    "order_items": [             // optional
      {
        "type": "default",       // optional order-item bundle; default "default"
        "title": "",             // optional; defaults to the variation label
        "quantity": 1,           // optional; default 1
        "unit_price": {          // optional (see upstream docs "only if need to override product price")
          "number": 5, "currency_code": "USD"
        },
        "purchased_entity": { "sku": "PRODUCT_SKU" }  // required per item
      }
    ]
    // any additional order field may also be supplied here
  },
  "profile": { "type": "customer", "status": false /* + any profile field */ },
  "user":    { "mail": "user@example.com" /* required */, "name": "Kate", "status": false },
  "payment": { "gateway": "paypal_test", "type": "paypal_ec", "details": {} }  // optional
}
```

## Processing flow (`post()`)
1. `hook_order_checkout_prepare_alter($data)`.
2. **`validateInput()`** — requires `user.mail`; each order item requires
   `purchased_entity.sku` and the variation must load by SKU; if a `payment` block is present it must
   have `gateway` (must exist) and `type`.
3. **`getUser()`** — `user_load_by_mail($data['user']['mail'])`; if none, creates a user. Before
   create it unsets `init`, `roles`, `pass`, `created`, `access`, `login`, defaults `name` to the
   email, validates and saves. An existing account (matched by email) is **reused as-is and not
   updated**.
4. **`getProfile()`** — defaults type to `customer`, forces `uid` to the resolved user; if the
   profile type does not allow multiple, an existing profile of that type/uid is reused; otherwise a
   new profile is created, validated, saved.
5. **`getOrderItems()`** — for each item loads the variation by SKU, defaults `type`/`quantity`/
   `title`, sets `purchased_entity` to the loaded variation, creates the `commerce_order_item`,
   validates, saves. If the payload supplied `unit_price`, it is applied via
   `setUnitPrice(Price::fromArray(...), TRUE)` (marked overridden).
6. `hook_decoupled_order_data_alter($data, $order_data)`.
7. **`getOrder()`** — forces `type` (default `default`), `email` (default user email), `uid`,
   `placed`, and `store_id` (payload `store`, else default store); merges billing profile +
   order items; creates the `commerce_order`, validates, saves; if no order number, generates one
   from the order type's number pattern.
8. `hook_decoupled_draft_order_alter($order, $data)` (place for promotions/coupons).
9. **`processPayment()`** if a `payment` block is present (see below).
10. `hook_decoupled_order_alter($order, $data)`; returns the order (201).

## Embedded payment (`processPayment()`)
Loads the gateway; creates a `commerce_payment_method` (owner = order customer, billing profile =
order billing profile); requires the gateway plugin to implement `OnsitePaymentGatewayInterface`
(else throws). Calls `createPaymentMethod($payment_method, $data['payment']['details'])`, then
creates a `commerce_payment` with **`amount => $order->getTotalPrice()`** and calls `createPayment()`
(create + capture). If the payment state becomes `completed`, it applies the order's `place`
transition and sets `total_paid` to the order total. Errors run
`hook_decoupled_checkout_create_order_error_message_alter()` and throw `BadRequestHttpException`.

## Validation note
`validateEntity()` throws on `$entity->validate()->getEntityViolations()` — i.e. only **entity-level**
constraint violations; field-level violations are not surfaced by this method.

## Errors
`validateInput()` failures → `NotAcceptableHttpException` (406). Entity build/save and payment
failures → `BadRequestHttpException` (400). All are logged to the `commerce_decoupled_checkout`
channel.
