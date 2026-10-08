<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Give lets a site accept donations via Stripe, cheque or bank transfer, with donation forms and records.

---

Give lets a Drupal site accept donations — supporting Stripe (card), cheque and bank-transfer payment
methods, with donation forms and stored donation records, aimed at nonprofits/fundraising. It depends on
core Field, ships a `give_civicrm` submodule (CiviCRM integration), is configured at `give.settings`, and
provides its own permissions, in the Give package.

Use it to collect donations. Security notes for the payment side: store the **Stripe secret/API keys as
secrets** (Key entity / environment variable), operate donation pages over HTTPS, and — importantly — if
Stripe webhooks are used to confirm payments, **verify the Stripe webhook signature** so forged
"payment succeeded" events are rejected (confirm the module verifies the `Stripe-Signature`); donor records
contain personal data (name/email/amount) so gate access to them with the module's permissions and handle
per privacy obligations. Configure the payment methods and donation forms.

---

- Accept donations (Stripe/cheque/bank).
- Provide donation forms.
- Store donation records.
- Depend on core Field.
- Ship a CiviCRM submodule.
- Provide its own permissions.
- Store Stripe keys as secrets.
- Operate donation pages over HTTPS.
- Verify the Stripe webhook signature.
- Reject forged payment events.
- Protect donor personal data.
- Gate access to donation records.
- Handle donor data per privacy rules.
- Configure payment methods.
- Collect fundraising.
- Configure at give.settings.
- Handle donations.
- Configure donation forms.
- Process card donations.
- Accept fundraising.
