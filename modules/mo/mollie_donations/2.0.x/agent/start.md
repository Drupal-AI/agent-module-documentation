<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mollie donations (mollie_donations) — agent index

**Public donation form that creates Mollie payments and confirms them by re-fetching status from Mollie.**

- **Version:** 2.0.x
- **Core:** ^10 || ^11
- **Config route:** `mollie_donations.settings_form` → `/admin/config/services/mollie_donations` (perm `access mollie_donations admin`).
- **Form route:** `/mollie_donations` (custom access via `DonationForm::access`).
- **Callback route:** `/mollie_donations/callback` (perm `access content`).
- **Service:** `mollie_donations.mollie` (`MollieService`) — creates payments, tempstore-tracks the payment id.
- Requires the Mollie PHP API (composer).

**Security:** The return callback is gated only by `access content` (effectively anonymous) but is **sound** — `MollieCallbackController::callback` re-fetches the authoritative payment status from the Mollie API rather than trusting the request. Admin/API key route is permission-gated. See [configure/settings.md](configure/settings.md).
