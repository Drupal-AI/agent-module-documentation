# Commerce View Receipt — agent index

View a Commerce order's receipt (the emailed `commerce_order_receipt` template) in the browser,
with an admin "Receipt" tab, a customer receipt route, a Views link field, and optional PDF via
Entity Print. No settings page, no own permissions, no config schema, no Drush. Depends on
`commerce_order` (>=3.0.0).

- **The two routes, their access model, the Views field, and the Entity Print PDF action** →
  [configure/receipt.md](configure/receipt.md)

Key facts:
- `ReceiptController::viewReceipt()` renders `#theme => 'commerce_order_receipt'` with the order,
  billing profile view, and `commerce_order.order_total_summary` totals.
- Admin route `commerce_view_receipt.admin` and customer route `commerce_view_receipt.user` both
  enforce `_entity_access: commerce_order.view`; the customer route additionally requires
  `{user} == order customer` (`ReceiptController::userAccess()`).
- Views field `commerce_view_receipt_user_receipt_link` links to the customer route for
  `completed` orders (access-checked before rendering).
