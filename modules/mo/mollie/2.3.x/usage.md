<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mollie for Drupal integrates the Mollie payment service provider — widely used in the Netherlands and Belgium for iDEAL, cards, PayPal and local payment methods — with Drupal, both as a Drupal Commerce gateway and as a way to take payment from a webform.

---

The project is a base module plus three context submodules. The base module holds the API connector (the `mollie.mollie` service wrapping `mollie/mollie-api-php ^2.52`), an API-backed `mollie_payment` entity whose data lives on Mollie rather than the local database, a payments overview at `/admin/mollie/payments`, and the redirect and webhook routes Mollie calls back. Payments are created through the entity storage, which creates them on Mollie and hands back a checkout URL; their status is read back through the API. Other modules integrate by creating a payment tagged with their own `context`/`context_id` and subscribing to the dispatched events — `mollie.transaction_event.status_change`, `mollie.redirect_event`, and the experimental refund/chargeback events. The submodules do exactly this: **mollie_commerce** is a Drupal Commerce off-site gateway; **mollie_webform** takes payment as part of a webform submission, which suits donations, event fees and registrations where a full shop is unnecessary; and **mollie_customers** manages Mollie Customers API records for recurring or stored-payment scenarios. Credentials (a live key, an optional test key, and an optional organisation access token) are supplied in `settings.php` as `$settings['mollie.settings']`, while the admin form at `/admin/config/services/mollie` only toggles test mode and, for local testing, an alternate webhook base URL. Both admin permissions (`access mollie payments overview`, `administer mollie`) are marked restrict-access, since the overview lists financial records. Note the info file declares `php: 8.3`, stricter than composer's `>=8.1`.

---

- Take iDEAL payments on a Drupal site.
- Add Mollie as a Drupal Commerce payment gateway.
- Collect a donation through a webform.
- Charge a registration or event fee at submission time.
- Accept cards, PayPal and local payment methods.
- Manage Mollie customers for recurring payments.
- View a payments overview inside Drupal.
- Take a payment without adopting the full Commerce stack.
- Support Dutch and Belgian payment habits.
- Reconcile payments against submissions or orders.
- Restrict the payments overview to finance staff.
- Handle Mollie payment status callbacks.
- Redirect a customer back to the right page after paying.
- React to refunds and chargebacks in a custom module.
- Create a payment programmatically from your own module and get a checkout URL.
- Tag payments with a context and context id for later reconciliation.
- Support an event booking or ticketing flow.
- Take a deposit on a form.
- Integrate Mollie into Drupal Commerce checkout.
- Store a Mollie customer for later charges.
- Show available payment methods for a given amount and currency.
- Toggle between test and live mode from the settings page.
- Report on payment status from the overview.
