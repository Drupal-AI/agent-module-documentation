Commerce Webform Order bridges Webform and Drupal Commerce: a Webform **handler** turns a webform submission into a Commerce order (cart) selling any `PurchasableEntityInterface`, and optional Webform **elements** embed a payment-method selector and sync order/payment state back to the submission.

---

The core piece is the `commerce_webform_order` Webform handler (add it at a webform's *Handlers*
tab). Its settings are grouped into Store, Order item, and Checkout tabs plus sync/state
options: pick the store, the purchasable entity (product variation, etc.) or override title,
price, currency, quantity and order-item bundle/fields, and control cart behaviour (new cart,
empty cart, combine, owner, billing profile, payment gateway/method, order state, order data,
redirect to checkout). Almost any setting can be **mapped to a submitted webform value** using a
`:input[name="element_key"]` selector (resolved in `replaceConfiguration`) or a token, so prices
and quantities can come from the form. On submission `postSave()` builds/updates an order item
(linked to the submission via the added `commerce_webform_order_submission` base field), places
it in the customer's cart via Commerce's cart provider, optionally sets payment/state/data, and
can redirect to `commerce_checkout.form`. A handler only runs when the submission's webform state
and the order's state match the configured `webform_states`/`order_states` (`shouldBeExecuted`).
It also provides three Webform elements (Payment Method, Order State, Payment Status), a
replacement **Payment process** checkout pane for on-form gateway selection, tokens
(`commerce_order`, `commerce_order_item` off a submission), event subscribers that push order
state and payment status back to submissions, and an alter hook. Access to update a submission
tied to an order can be locked once the order leaves draft (`prevent_update`), and `sync` ties
submission and order-item lifecycles together. There is no global settings page (`configure`
null) and no module permissions — everything is configured per webform handler by users with
webform-admin rights.

---

- Sell a product variation (or any purchasable entity) directly from a webform submission.
- Build a donation form that creates a Commerce order with an amount entered by the donor.
- Create a membership/subscription signup form that produces an order at checkout.
- Add a submitted webform to the user's cart and redirect them to Commerce checkout.
- Map the order item price to a webform number element (e.g. "choose your amount").
- Map quantity, title, or currency to webform elements or tokens.
- Override the price/currency of a purchasable entity for special campaigns.
- Start a brand-new cart per submission, or combine into the existing cart.
- Empty the current cart before adding the webform's order item.
- Set the order owner by email or user reference (including from a submitted field).
- Attach a billing profile to the order (optionally bypassing access checks — admin opt-in).
- Choose the payment gateway/method up front, or let the buyer pick via the Payment Method element.
- Embed an on-form payment-gateway selector using the Payment Method webform element.
- Replace Commerce's Payment process checkout pane with the module's variant for webform-driven flows.
- Sync the Commerce order state onto the submission using the Order State element.
- Sync payment status (paid/unpaid + amount) onto the submission using the Payment Status element.
- Push order-state and paid events back to submissions automatically via event subscribers.
- Lock further submission edits once the order is no longer a draft (`prevent_update`).
- Tie submission and order-item deletion together (`sync`) for consistent cleanup.
- Set a custom order state or arbitrary order `data` (YAML) from the handler.
- Restrict which webform states (e.g. completed) and order states trigger order creation.
- Use `commerce_order` / `commerce_order_item` tokens that resolve from a webform submission.
- Alter the order, order item, and submission just before save via `hook_commerce_webform_order_handler_postsave_alter`.
- Provide a "pay what you want" or configurable-price product experience through Webform.
- Run multiple order handlers on one webform for multi-item orders.
- Hide the "added to cart" message for a smoother webform-to-checkout flow.
- Redirect to a custom cancel URL for off-site payment gateways.
- Grant update access to an anonymous submitter via a secure submission token while the order is still draft.
