# Permissions

Defined in `commerce_purchase_order.permissions.yml`.

| Permission | Title | Grants |
|---|---|---|
| `authorize user purchase orders` | Authorize user for Purchase Orders | View/edit the `field_purchase_orders_authorized` boolean on user accounts. Enforced by `commerce_purchase_order_entity_field_access()` (`hook_entity_field_access`): the field is `allowed` only for holders of this permission, `forbidden` otherwise. |

Notes:
- This is the effective gate on which customers may be *approved* for PO terms — treat it as a
  credit-granting permission and give it only to trusted staff.
- The module defines no other permissions. Operating placed PO payments (Receive / Void / Refund on
  the order Payments tab, and the Purchase Orders View) uses Commerce's core
  `administer commerce_payment` permission, not a permission from this module.
