<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events (extension points)

Constants in `Drupal\commerce_moneris_checkout\Event\MonerisCheckoutEvents`
(`src/Event/MonerisCheckoutEvents.php`). Subscribe with a normal
`EventSubscriberInterface` service.

| Constant | Event name string | Event class | Dispatched from |
|----------|-------------------|-------------|-----------------|
| `MCO_SHOPPING_CART_READY` | `commerce_moneris_checkout.shopping_cart_ready` | `MonerisCheckoutShoppingCartReadyEvent` | `MonerisCheckoutForm::getShoppingCartItems()` before preload |
| `MCO_TRANSACTION_CANCEL` | `commerce_moneris_checkout.transaction_cancel` | `MonerisCheckoutTransactionCancelEvent` | `MonerisCheckout::onCancel()` when response_state is `cancel` |
| `MCO_TRANSACTION_COMPLETE` | `commerce_moneris_checkout.transaction_complete` | `MonerisCheckoutTransactionCompleteEvent` | class defined; **not dispatched** by current code |

## MonerisCheckoutShoppingCartReadyEvent
- `__construct(PaymentInterface $payment, array $items)`.
- `getPayment()`, `getItems()`, `setItems($items)`.
- Dispatched with the assembled cart (`subtotal`, `tax`, `items[]`). After dispatch, the form
  replaces `$items['items']` with `getItems()['items']` **only if it changed** — so a subscriber
  can rewrite the line items sent to Moneris (e.g. add tax/fees) by mutating the `items` sub-array
  via `setItems()`.

## MonerisCheckoutTransactionCancelEvent
- `__construct(OrderInterface $order)`; `getOrder()`.
- Fired on customer cancel; use it for cleanup/analytics. No payment is recorded on cancel.

## MonerisCheckoutTransactionCompleteEvent
- `__construct(PaymentInterface $payment)`; `getPayment()`.
- Class exists but `onReturn()` does **not** dispatch it in this version. To react to a completed
  payment, subscribe to Commerce's own payment-insert / order events instead.
