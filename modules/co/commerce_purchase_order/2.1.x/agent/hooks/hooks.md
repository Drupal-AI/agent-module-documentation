# Hooks implemented

All in `commerce_purchase_order.module`.

| Hook | Purpose |
|---|---|
| `hook_entity_field_access` | Gates the `field_purchase_orders_authorized` user field: `allowed` for holders of `authorize user purchase orders`, `forbidden` otherwise; `neutral` for all other fields. |
| `hook_preprocess_commerce_order_receipt` | Sets `payment_instructions` on the order-receipt template. Loads the order's payments for its gateway and, if the gateway plugin is a `HasPaymentInstructionsInterface` (the PO gateway is), calls `buildPaymentInstructions($payment)` — i.e. renders the admin-configured `instructions` text. |
| `hook_theme_suggestions_commerce_order_receipt_alter` | Adds template suggestions `commerce_order_receipt__purchase_order_gateway` (and `…__<order-bundle>__purchase_order_gateway`). |
| `hook_theme` | Registers `commerce_order_receipt__purchase_order_gateway` → template `commerce-order-receipt--purchase-order-gateway.html.twig` (base hook `commerce_order_receipt`). |
| `hook_file_download` | Access control for the private PO files under `private://purchase-orders`. Returns headers only when the file has `commerce_purchase_order` usage and the current user can `view` the referencing payment method **or** owns the in-checkout cart order that references it; otherwise `-1` (permanent files) or `NULL`. |
| `hook_help` | About text on `help.page.commerce_purchase_order`. |

Notes for integrators:
- The receipt instructions come from the gateway `instructions` config (admin-entered
  `processed_text`), not from customer input.
- PO files are stored in the **private** filesystem and served only through the `hook_file_download`
  check above; the `file_upload` option is unavailable unless a private file system is configured.
