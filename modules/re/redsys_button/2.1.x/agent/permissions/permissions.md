<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `redsys_button.permissions.yml` — all `restrict access: true`:

| Permission | Gates |
|---|---|
| `administer redsys settings` | The config form `/admin/config/system/redsys-settings`. |
| `view redsys payments` | Payment audit list `/admin/content/redsys-payments` and each `redsys_payment` detail page. |
| `view redsys payment requests` | Viewing the payment-request list/detail (combined with the admin permission on the collection route). |
| `administer redsys payment requests` | Create/duplicate/cancel payment requests at `/admin/content/redsys-payment-requests`. |

Public routes carry `_access: TRUE` by design (Redsys and returning customers are unauthenticated) and are
protected by signature verification (`/redsys/notify`) or an unguessable per-operation `return_token` /
per-request token (`/redsys/return/...`, `/redsys/cancel/...`, `/redsys/payment-request/...`).
