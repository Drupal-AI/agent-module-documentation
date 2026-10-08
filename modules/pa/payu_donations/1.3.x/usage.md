<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PayU Donations adds a donation block backed by PayU, confirming payments via a signature-verified notify.

---

PayU Donations provides a configurable block that lets visitors donate using the PayU payment system — sending them to PayU to pay and recording donations in Drupal. It's aimed at nonprofits/charities collecting online donations.

Security: payment confirmation goes through the PayU **notify** endpoint, which **verifies the OpenPayU signature** (`hasValidSignature()` with the configured signature key) before marking a donation complete — so forged payment notifications are rejected (a defensive positive); the browser redirect handler only manages UX via session data. PayU keys (second_key_md5, signature key) should be env-backed. Permissions: `administer payu_donations configuration`, `administer payu donations payment`. Supports Drupal 9.5+, 10, and 11.

---

- Provide a PayU donation block.
- Let visitors donate via PayU.
- Send donors to PayU to pay.
- Record donations in Drupal.
- Confirm payment via the notify endpoint.
- Verify the OpenPayU signature.
- Reject forged notifications.
- Handle redirect UX via session.
- Store PayU keys env-backed.
- Gate config with `administer payu_donations configuration`.
- Gate payments with `administer payu donations payment`.
- Support Drupal 9.5+, 10, and 11.
- Serve nonprofits/charities.
- Collect online donations.
- Verify payments securely.
- Configure the donation block.
- Support Polish payments
- Manage donation records
