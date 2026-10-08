<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `commerce_avatax.permissions.yml`:

| Permission | Restricted | Gates |
|---|---|---|
| `administer commerce_avatax` | `restrict access: true` | The settings form at `/admin/commerce/config/avatax` (account ID, license key, API mode, address validation, etc.). Trusted admin only. |
| `configure avatax exemptions` | no | Edit access to the user base fields `avatax_customer_code`, `avatax_tax_exemption_number`, `avatax_tax_exemption_type`. |

`configure avatax exemptions` is enforced in `commerce_avatax_entity_field_access()`:

```php
// edit operation on the three exemption/customer-code fields:
return AccessResult::forbiddenIf(!$account->hasPermission('configure avatax exemptions'));
```

So without this permission a user cannot edit those fields on a user profile; with it they can
set a customer's tax-exemption number/type and AvaTax customer code. Scope it to staff who
manage B2B/wholesale exemptions. It only controls those field edits — it does not expose
credentials or settings (those are behind the restricted `administer commerce_avatax`).
