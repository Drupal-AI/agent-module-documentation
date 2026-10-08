<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Access Conditions Commerce provides drop-in replacements for standard Commerce checkout panes whose visibility is controlled by Access Conditions access models.

Use it when different customers should see different checkout steps/panes (e.g. hide payment for zero-value orders segments, show a coupon field only to some roles) driven by reusable, exportable condition rules.

- Adds "…with access conditions" variants of core Commerce checkout panes.
- Each pane gains an "access models" setting selecting which models make it visible.
- Panes default to the `_disabled` step until configured onto a checkout flow.
- Depends on `access_conditions`, `commerce`, and `condition_plugins_commerce`.

---

Install and configure:

- Require via composer: `drupal/access_conditions_commerce` (pulls commerce, access_conditions, condition_plugins_commerce).
- Enable the submodule(s) you need: checkout, payment, promotion.
- Edit your checkout flow and place the "…with access conditions" panes onto steps.
- On each pane, set the access model(s) under "Visible to certain access models".
- Create the models first in Access Conditions.

---

- Replace `Login`, `ContactInformation`, `BillingInformation`, `OrderSummary`, `Review` panes with access-conditions variants.
- Payment submodule adds `PaymentInformation` and `PaymentProcess` variants.
- Promotion submodule adds a `CouponRedemption` variant.
- `AccessConditionsCommerceCheckoutPaneTrait::isVisible()` evaluates configured models via the access checker.
- Leaving the access-models setting empty falls back to the parent pane's default visibility.
- If any selected model grants access, the pane is visible; otherwise hidden.
- `PaymentProcess` also keeps core logic: hidden when the order is paid or free.
- Models are configured once and reused across panes and flows.
- Visibility is display-only; it does not bypass Commerce's own access/order logic.
- Configuration is exportable with the checkout flow config.
- Use commerce-specific condition plugins (order total, product, etc.) inside models.
- Test as anonymous guest and authenticated customer.
- Combine with promotions to gate coupon entry.
- Keep model logic simple to preserve checkout cacheability.
- Verify payment panes still appear for paying customers before go-live.
