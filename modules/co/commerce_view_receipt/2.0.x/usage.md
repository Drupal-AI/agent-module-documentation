Commerce View Receipt lets you view a Drupal Commerce order's receipt (the same template that is emailed to customers) directly in the browser, adding a "Receipt" tab on admin order pages and a customer-facing receipt route, with optional PDF download via Entity Print.

---

The module renders the `commerce_order_receipt` theme (order entity + billing profile view + order total summary from `commerce_order.order_total_summary`) at two routes handled by `ReceiptController`: an admin route `/admin/commerce/orders/{commerce_order}/receipt` (permission `access commerce administration pages` **and** `_entity_access: commerce_order.view`), exposed as a "Receipt" local task tab on the order canonical page; and a customer route `/user/{user}/orders/{commerce_order}/receipt` (custom access requiring `{user}` to equal the order's customer, **and** `_entity_access: commerce_order.view`), exposed as a "View Receipt" action on the user's order view. A Views field plugin, `commerce_view_receipt_user_receipt_link` ("Receipt link"), renders a link to the customer receipt route for `completed` orders, checking `$url->access()` first so it only appears when the viewer may see it. When the optional `entity_print` module is enabled, a derivative local action ("Download PDF") is added to both receipt pages, routing to `entity_print.view` for the order. There is no settings page and the module defines no permissions of its own (the README's mention of a "view receipts" permission does not match the shipped routing, which reuses Commerce order access). Handy for theming/previewing receipt templates and for giving customers a viewable/printable receipt.

---

- View an order's receipt in the browser as an admin from a "Receipt" tab on the order page.
- Preview changes to the `commerce_order_receipt` template without sending a test email.
- Give a customer a web page showing their own order receipt.
- Offer a printable/downloadable PDF receipt via Entity Print.
- Add a "Receipt" link column to a Views listing of orders (completed orders only).
- Show the order total summary (subtotal, adjustments, total) on the receipt page.
- Render the order's billing profile alongside the receipt.
- Let customer service confirm what a customer's emailed receipt looks like.
- Provide a shareable receipt URL scoped to the correct order owner.
- Restrict admin receipt viewing to users with commerce admin + order view access.
- Restrict customer receipt viewing to the order's own customer.
- Link customers to their receipt from their order history view.
- Generate a PDF invoice/receipt for accounting or record-keeping.
- Debug receipt template rendering during theme development.
- Expose receipts consistently for both staff and customers from one controller.
