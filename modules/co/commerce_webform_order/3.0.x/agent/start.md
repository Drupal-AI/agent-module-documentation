# Commerce Webform Order — agent index

Integrates Webform with Drupal Commerce. A Webform **handler** (`commerce_webform_order`) turns
a submission into a Commerce order (cart) for any `PurchasableEntityInterface`; optional Webform
elements embed payment selection and sync order/payment state back. Deps: commerce (+ cart,
checkout, order, price, store), webform, commerce_purchasable_entity. No global config page
(`configure` null), no module permissions, no Drush. Provides config schema. Configure per
webform at *Structure → Webforms → {form} → Settings → Handlers*.

- **The handler: every setting (Store / Order item / Checkout tabs, sync, state gating), the
  `:input[name=…]`/token value mapping, cart building, redirect, and the price-mapping caution**
  → [configure/handler.md](configure/handler.md)
- **Webform elements (Payment Method, Order State, Payment Status), the replacement Payment
  process checkout pane, and the on-form gateway selector** →
  [plugins/webform-elements.md](plugins/webform-elements.md)
- **Services, the access checker, tokens, event subscribers, the postsave alter hook, and the
  `commerce_webform_order_submission` base field** → [api/services.md](api/services.md)

Key facts:
- Handler class `src/Plugin/WebformHandler/CommerceWebformOrderHandler.php` (id
  `commerce_webform_order`); config schema key `webform.handler.commerce_webform_order`.
- `postSave()` creates/updates an order item, links it to the submission via base field
  `commerce_webform_order_submission`, adds it to the cart (`cartProvider`), sets
  payment/state/data, and (if `redirect`) sends a `TrustedRedirectResponse`/Ajax redirect to
  `commerce_checkout.form` then `exit`.
- Runs only when submission state ∈ `webform_states` AND order state ∈ `order_states`
  (`shouldBeExecuted`).
- `replaceConfiguration()` replaces any setting equal to `:input[name="key"]` with the submitted
  value, then runs token replacement — so prices/quantities/owner can come from the form.
- No permissions/Drush; all setup is webform-handler config (webform-admin rights).

Access notes: the `store.bypass_access` / `billing_profile_bypass_access` toggles are admin opt-in
(default FALSE) and only skip entity-load access when a webform admin enables them; token-based
submission access (`commerce_webform_order_webform_access`) uses core webform `loadFromToken`, and
the access checker only returns forbidden/neutral. See [configure/handler.md](configure/handler.md)
for the price-mapping note.
