# Routes, access, Views field, PDF

No admin form; enable the module and the routes/links appear. Access reuses Commerce order access
(the module defines no permissions of its own).

## Routes (`commerce_view_receipt.routing.yml`)
Both call `ReceiptController::viewReceipt(OrderInterface $commerce_order)`, which returns
`['#theme' => 'commerce_order_receipt', '#order_entity' => $order, '#billing_information' => <billing
profile view or NULL>, '#totals' => order_total_summary->buildTotals($order)]`.

- **`commerce_view_receipt.admin`** — `/admin/commerce/orders/{commerce_order}/receipt`.
  Requirements: `_permission: 'access commerce administration pages'` **and**
  `_entity_access: 'commerce_order.view'`, `commerce_order: \d+`. Shown as the "Receipt" local task
  tab on the order canonical page (`links.task.yml`, base route `entity.commerce_order.canonical`).
- **`commerce_view_receipt.user`** — `/user/{user}/orders/{commerce_order}/receipt`.
  Requirements: `_custom_access: ReceiptController::userAccess` **and**
  `_entity_access: 'commerce_order.view'`, both `\d+`. Shown as a "View Receipt" action on
  `entity.commerce_order.user_view` (`links.action.yml`).

### Access model (both routes require order-view access)
`userAccess(UserInterface $user, OrderInterface $commerce_order)` returns
`AccessResult::allowedIf($user->id() === $commerce_order->getCustomer()->id())` — the `{user}` path
arg must be the order's customer. Combined with the always-present `_entity_access:
commerce_order.view` requirement, a user cannot read another customer's receipt (both the
ownership match and Commerce's order view-access handler must pass). No IDOR.

## Views field
`src/Plugin/views/field/ReceiptLink.php`, `@ViewsField("commerce_view_receipt_user_receipt_link")`,
label "Receipt link". `render()` only emits a link for orders whose state is `completed`, targets
`commerce_view_receipt.user` with the order's customer id, and returns empty unless
`$url->access()` passes — so the link is hidden when the viewer lacks access.

## PDF (optional, needs `entity_print`)
`Plugin/Derivative/ViewPdfDeriver` adds a `commerce_view_receipt.view_pdf` local action only when
`entity_print` is enabled; `Plugin/Menu/LocalAction/ViewPdfAction` routes it to `entity_print.view`
with `entity_type: commerce_order`, `export_type: pdf`, `entity_id: <order id>`. It appears on both
receipt routes ("Download PDF").
