<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Invoice permissions

Permissions come from two places: the module's `commerce_invoice.permissions.yml` and the
entity permission provider (`InvoicePermissionProvider extends EntityPermissionProvider`) that
generates permissions for the `commerce_invoice` entity.

## Declared in `commerce_invoice.permissions.yml`

| Permission | Gates |
|---|---|
| `administer commerce_invoice_type` | Manage invoice **types** and their fields (`/admin/commerce/config/invoice-types`, and the invoice item types page). Restricted. |

## Generated for the `commerce_invoice` entity

The Invoice entity uses `admin_permission = administer commerce_invoice` and
`permission_granularity = bundle`, so the entity API provides the usual set, plus two the
provider customizes because invoices have no owner field of the standard kind:

| Permission | Gates |
|---|---|
| `administer commerce_invoice` | Full control over invoice entities. |
| `view commerce_invoice` | "View any invoice" (label set by the provider). |
| `view own commerce_invoice` | View invoices belonging to the current user (customer-facing "my invoices"). |
| per-bundle `view/update/create/delete <type> commerce_invoice` | Bundle-scoped access to invoices of a given invoice type. |

## Assign via drush

```bash
drush role:perm:add authenticated 'view own commerce_invoice'
drush role:perm:add administrator 'administer commerce_invoice'
drush role:perm:add administrator 'administer commerce_invoice_type'
```

`view own commerce_invoice` is the key customer-facing permission — grant it so logged-in buyers
can see their invoices under their account; keep `administer …` permissions to staff roles.
