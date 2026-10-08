<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce ePayco adds Drupal Commerce payment gateways for the ePayco provider.

---

Commerce ePayco (`commerce_epayco`) is the Drupal Commerce integration submodule of the ePayco project. It provides
two off-site payment gateway plugins: "ePayco (Standard checkout)", which redirects the customer to ePayco's secure
checkout page, and "ePayco (One page checkout)", which opens ePayco's checkout as an on-page modal/iframe. Each
gateway is configured against an ePayco factory (the account settings created by the base module), and the account
values can be overridden per Commerce store so different sellers can use their own ePayco accounts. The submodule
also builds the signed outbound checkout request from the order (amount, currency, tax, billing), fires the ePayco
transaction event on return, provides a hook to alter the outbound data, and reconciles still-pending payments
against ePayco's API on cron and via a Drush command. Requires `commerce_payment`, `commerce_order` and the base
`epayco` module.

---

- Accept ePayco payments in a Drupal Commerce store.
- Offer redirect (off-site) ePayco checkout via the Standard checkout gateway.
- Offer on-page (iframe/modal) ePayco checkout via the One page checkout gateway.
- Auto-open the on-page payment modal at the payment step.
- Point each gateway at a shared ePayco factory (account settings).
- Override ePayco credentials per Commerce store.
- Let individual sellers use their own ePayco account per store.
- Build the checkout request from the order total, currency and tax.
- Sign the outbound standard-checkout request.
- Pass billing details from the order's billing profile to ePayco.
- Record a Commerce payment when the customer returns from ePayco.
- Alter outbound ePayco checkout data with `hook_commerce_epayco_payment_data_alter()`.
- Reconcile still-pending ePayco payments on cron.
- Reconcile pending payments on demand with `drush commerce_epayco:check_pending_payments`.
- Filter reconciliation to specific remote transaction ids or a range.
- Fire the `epayco.transaction.response` event for other modules to react to.
- Restrict per-store overrides with the `commerce_epayco override gateway parameters` permission.
- Support split payments when those parameters are supplied.
- Run test-mode transactions before going live.
- Load Commerce payments by ePayco remote transaction id.
