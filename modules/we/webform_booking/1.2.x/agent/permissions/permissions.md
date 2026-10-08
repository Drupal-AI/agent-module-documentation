<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `webform_booking.permissions.yml` (all three are `restrict access: true`):

| Permission | Gates |
|---|---|
| `manage webform booking` | The settings form `/admin/config/services/webform-booking` (PayPal creds, currency, country). |
| `view webform booking input` | Viewing the raw Webform Booking input value on submissions. |
| `cancel all webform bookings` | Cancelling any booking **without** the per-submission secure token (staff override of the tokenised cancel link). |

Notes:
- The public-facing capabilities (loading availability, creating/capturing PayPal orders, cancelling
  one's own booking) are **not** permission-gated to a role — they use `access content` plus custom
  access checks that verify the specific webform/element/order and (for cancellation) a per-submission
  token. That is by design for anonymous booking.
- Keep all three restricted permissions on trusted staff roles.
