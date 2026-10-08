<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Defers the CiviCRM Form Processor submission until the Mollie payment webhook fires, so CiviCRM is only called after payment is reported.

---

A submodule of **cmrf_form_processor** that integrates it with the Mollie payment module. When a Webform has both a CiviCRM Form Processor handler and an active Mollie payment handler, this submodule suppresses the Form Processor's normal post-save call and instead runs it from Mollie's payment-notification event: on the webhook it loads the submission and the stored Mollie payment record, then invokes the Form Processor handler with the payment id and the payment status read back from the persisted Mollie transaction. The result is that the CiviCRM action only happens once payment has been processed, and the payment status travels with it. Requires the `mollie_webform` module alongside the parent. Enable it only when you combine CiviCRM Form Processor submissions with Mollie payments on the same Webform.

---

- Defer the Form Processor call until payment.
- Run the CiviCRM action from the Mollie webhook.
- Suppress the normal post-save submission when a Mollie handler is active.
- Pass the Mollie payment id and status to CiviCRM.
- Read the payment status from the stored Mollie transaction.
- Combine CiviCRM submissions with Mollie payments on one Webform.
- Depend on mollie_webform and cmrf_form_processor.
- Enable only for paid Webforms.
- Keep disabled if you do not use Mollie.
- Configure the Mollie handler in the Webform.
- Test the payment-to-CiviCRM flow before production.
- Review after Mollie or CiviCRM upgrades.
