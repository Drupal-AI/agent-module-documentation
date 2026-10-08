Syncart submodule adding point-of-sale support: a dedicated pos order type/checkout flow plus a terminal cookie.

---

`syncart_pos` installs a `pos` `commerce_order` type, a `pos` checkout flow, a `pos` commerce number pattern, matching order form/view displays, and a `shipments` field on the pos order. `Controller\PosController::setCookie()` (route `/syncart_pos/set_coockie`) sets a long-lived `cache_context=pos` cookie and redirects to the front page, switching a terminal/browser into POS mode (used with `cache_alter`). Depends on `syncart` and `cache_alter`.

---

- Sell over the counter using a dedicated `pos` Commerce order type separate from the web storefront.
- Route POS orders through a bespoke `pos` checkout flow.
- Assign POS orders their own number sequence via the `pos` commerce number pattern.
- Switch a terminal into POS mode by visiting `/syncart_pos/set_coockie` (sets a `cache_context=pos` cookie).
- Vary cached cart/page output by the POS cookie in combination with `cache_alter`.
- Present POS-specific order form and view displays.
- Attach shipment data to POS orders through the bundled `shipments` field.
