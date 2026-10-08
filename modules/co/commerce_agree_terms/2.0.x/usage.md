Commerce Agree to Terms adds a single Commerce checkout pane that shows an "I agree to the Terms and Conditions" checkbox, linked to a node of your choice, and blocks checkout completion until the customer ticks it.

---

The module provides one checkout pane plugin, `agree_terms` (`src/Plugin/Commerce/CheckoutPane/AgreeTerms.php`), that you place on any Commerce checkout flow (default step `review`). There is no global settings page (`configure` is null) and no permissions or Drush commands — all configuration lives in the pane's own configuration form, edited under *Commerce → Configuration → Checkout flows → (flow) → Edit*. The pane stores a small config array (schema `commerce_checkout.commerce_checkout_pane.agree_terms`): a required target node id (`nid`, chosen via entity autocomplete), `link_text`, `prefix_text` (with a `%terms` token that is replaced by the link), an optional `description`, `invalid_text` (the validation error shown when unchecked), and `new_window` (open the terms link in a new tab). At checkout the pane renders a required-style checkbox whose label is the prefix text with the `%terms` placeholder replaced by a link to `entity.node.canonical` for the configured node; `validatePaneForm()` sets a form error using `invalid_text` if the box is not checked, preventing the customer from proceeding. The configuration summary renders the stored `description` as raw markup and echoes the other text values, all of which are set only by a checkout-flow administrator. The module is intentionally tiny (one plugin plus a schema file) and depends only on `commerce_checkout`.

---

- Require customers to accept terms and conditions before completing a Commerce order.
- Add a legally-worded consent checkbox to the checkout review step.
- Link the checkbox label to an existing Terms & Conditions node on the site.
- Point the checkbox at a Privacy Policy node instead of (or in addition to) terms.
- Customize the checkbox prefix text (e.g. "I have read and agree with the %terms").
- Customize the link text shown inside the checkbox label.
- Show a helpful description under the consent checkbox.
- Set a custom validation error message shown when the customer forgets to tick the box.
- Open the terms page in a new browser tab so customers do not lose their cart.
- Open the terms page in the same window when a new tab is undesirable.
- Place the consent pane on a specific checkout step by editing the checkout flow.
- Run multiple checkout flows, each with its own terms node and wording.
- Block order completion until explicit consent is captured (compliance requirement).
- Reuse an existing node's revisions/translations as the canonical terms document.
- Provide GDPR / distance-selling style consent capture at the point of purchase.
- Combine with other checkout panes (contact info, coupon, payment) on the review step.
- Give store admins full control of the wording without a developer or code change.
- Swap the terms node without republishing content — just re-point the pane's `nid`.
