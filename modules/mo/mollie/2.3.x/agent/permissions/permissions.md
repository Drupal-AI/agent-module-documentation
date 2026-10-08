# Permissions

Defined in `mollie.permissions.yml` plus a dynamic callback
`Drupal\mollie\TransactionPermissions::paymentPermissions`.

| Permission | Restrict access | Grants |
|---|---|---|
| `access mollie payments overview` | yes | View `/admin/mollie` and the payments collection `/admin/mollie/payments`. |
| `administer mollie` | yes | Access the settings form `mollie.configuration`. |
| `create mollie_payment entities` | — | Create a `mollie_payment` (add form `/mollie/payment/add`, programmatic create). |
| `view mollie_payment entities` | — | View a single `mollie_payment` (`/mollie/payment/{id}`). |

The dynamic `create` / `view mollie_payment entities` permissions are generated per operation by
`TransactionPermissions` (operations `create`, `view`).

## Entity access

`mollie_payment` uses `Drupal\mollie\PaymentAccessControlHandler` (extends
`TransactionAccessControlHandler`). Access is granted when the account holds
`"<operation> mollie_payment entities"` (e.g. `view mollie_payment entities`); otherwise it falls
back to the core `EntityAccessControlHandler` default. It does not widen access beyond that check.

## Public routes (no permission)

The redirect and both webhook routes use `_access: 'TRUE'` because Mollie and returning customers
must reach them anonymously. They are keyed by `{context}` / `{context_id}` and act only on the
payment status re-read from the Mollie API for the payment `id` in the request; they do not expose
payment data in the response (webhooks return an empty body with a status code; the redirect issues
a `RedirectResponse`).
