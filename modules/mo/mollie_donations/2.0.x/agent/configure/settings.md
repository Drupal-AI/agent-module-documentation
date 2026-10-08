<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Mollie donations

## Settings form
Route `mollie_donations.settings_form` → `/admin/config/services/mollie_donations`
(permission `access mollie_donations admin`, `restrict access: true`).
Holds the Mollie API key and donation options; stored in `mollie_donations.settings` config.

## Flow
1. Donor opens `/mollie_donations` (`DonationForm`, custom access `DonationForm::access`).
2. `MollieService` (service `mollie_donations.mollie`) creates a Mollie payment via the Mollie PHP API and stores the payment id in the private tempstore; page cache is killed on the form.
3. Donor is redirected to Mollie hosted checkout.
4. On return, `/mollie_donations/callback` (`MollieCallbackController::callback`, perm `access content`) **re-fetches** the payment status from Mollie's API to determine success — callback body values are not trusted.

## Notes
- Use a Mollie test key first, then a live key.
- Extra routes are registered dynamically by `Routing\MollieDonationsRouting::routes`.
