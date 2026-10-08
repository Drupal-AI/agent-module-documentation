<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mollie donations provides a public donation form (`/mollie_donations`) that creates a Mollie payment and redirects the donor to Mollie's hosted checkout.

---


The admin settings form (`/admin/config/services/mollie_donations`, permission `access mollie_donations admin`) holds the Mollie API key and donation options (amounts, description, redirect). `MollieService` creates the payment via the Mollie PHP API, stores the payment id in the private tempstore/session, and kills the page cache on the form. After payment the donor returns and Mollie calls back at `/mollie_donations/callback`; the `MollieCallbackController` re-fetches the payment status from Mollie's API (it does not trust callback body values) to decide the result. Dynamic routes are added by `Routing\MollieDonationsRouting`.

Setup: obtain a Mollie API key, enter it on the settings form, configure amounts/description, and place a link to the donation form.
---
- Accept online donations through Mollie.
- Configure the Mollie API key on the settings form.
- Set fixed or open donation amounts.
- Customize the donation form title and description.
- Redirect donors to Mollie hosted checkout (iDEAL, cards, etc.).
- Return donors to a thank-you/redirect page after payment.
- Verify payment status by re-fetching from the Mollie API.
- Restrict admin access with `access mollie_donations admin`.
- Expose the donation form at `/mollie_donations`.
- Link to the donation form from a menu or block.
- Use the private tempstore to track a pending donation.
- Bypass page cache on the donation form for correctness.
- Log donation/payment events via the logger channel.
- Handle the Mollie return/callback route.
- Test payments with a Mollie test API key.
- Switch to a live Mollie API key for production.
- Localize the donation form labels.
- Add a title callback for the donation page.
