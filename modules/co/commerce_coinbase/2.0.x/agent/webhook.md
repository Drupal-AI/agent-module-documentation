<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webhook endpoint, signature verification & order fulfilment

## Route

`commerce_coinbase.routing.yml`:

```
commerce_coinbase.webhook:
  path: '/coinbase/webhook/{commerce_payment_gateway}'
  defaults:
    _controller: '\Drupal\commerce_coinbase\Controller\CommerceCoinbaseController::handleIncomingWebhook'
  requirements:
    _access: 'TRUE'            # anonymous — Coinbase's servers must reach it
  options:
    parameters:
      commerce_payment_gateway:
        type: entity:commerce_payment_gateway
```

The `{commerce_payment_gateway}` slug is upcast to the gateway entity, from which the controller
reads the configured shared `secret`. Access is intentionally open; security comes from the HMAC
signature check, not from access control. Configure this URL as the webhook endpoint in the Coinbase
Commerce account, using the same shared secret entered on the gateway.

## Controller flow

`src/Controller/CommerceCoinbaseController.php::handleIncomingWebhook(PaymentGatewayInterface $commerce_payment_gateway, Request $request)`:

1. Read the **raw body** `$payload = $request->getContent()`; empty body → `Response` (no action).
2. `serializer->decode($payload, 'json')` → `$data`; empty → `Response`.
3. Extract `$type = $data['event']['type']` and `$order_id = $data['event']['data']['metadata']['order_id']`; write an audit row via `api->log('', 'webhook:'.$type, $request, ['order_id' => $order_id])`.
4. **Signature verification (the security gate):**
   - Require the `X-CC-Webhook-Signature` header; missing → `Response` (reject).
   - Read `$secret` from `$commerce_payment_gateway->getPluginConfiguration()['secret']`; missing → `BadRequestHttpException`.
   - Compute `hash_hmac('sha256', $payload, $secret)` over the **raw body** and compare to the header. On mismatch → log + `Response` (reject, no fulfilment).
5. Require a non-empty `order_id`; load the `commerce_order`. Missing order → `Response`.
6. Find the existing payment for the order (`getPayment()` → `loadByProperties(['order_id' => …])`).
   If a payment already exists and is `completed`, return early — **replay/duplicate guard**.
7. If no payment exists, create one (`createPayment()`, amount = `$order->getBalance()`,
   gateway bound, `remote_id` set to `event.data.code`). Set `remote_state = $type`; save.
8. **On `charge:confirmed` only:** sum the confirmed payments'
   `payments[].value.local.amount` (via `Calculator::add`), set payment state `completed`, set its
   amount to the summed paid value in the payment's currency, set completed time, save. Then, if the
   order's state allows the `place` transition, dispatch `CheckoutEvents::COMPLETION` and apply the
   `place` transition on the order and save.
9. Always returns an empty `Response` (HTTP 200) to Coinbase.

## Why forged callbacks fail (positive posture)

- The HMAC is computed over the **raw request body** keyed with the gateway's shared secret and is
  checked **before** any payment/order state change. An attacker without the secret cannot produce a
  matching `X-CC-Webhook-Signature`, so a spoofed `charge:confirmed` is rejected at step 4.
- The order binding (`metadata.order_id`) lives inside the signed payload — it cannot be swapped to
  a different order without invalidating the signature (no cross-order fulfilment).
- Fulfilment happens only on `charge:confirmed`, which Coinbase emits when the charge is fully paid,
  and an already-`completed` payment is skipped, so a replayed event does not double-place the order.
