<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bitaps — payment flow & callback

Route: `bitaps.pages` → `/bitaps/{page_type}` (`Controller\Pages::pages`, `_permission: access
content`). Two page types: `pay` and `status`.

## 1. Create payment (Basket → `payments_bitaps`)

When a Basket order selects the Bitaps method, `BasketBitaps::createPayment()` calls
`Bitaps::load(['nid'=>entity id,'create_new'=>TRUE,'amount'=>$order->pay_price])`, inserting a
`payments_bitaps` row with `status='new'` and returning its `payID`.

## 2. Payment page (`page_type=pay`)

`Pages::pages('pay')` loads the payment by `?pay_id=` and, only if it exists **and**
`status == 'new'`, renders `Form\PaymentForm` (else `NotFoundHttpException`).

`PaymentForm::basketPaymentFormAlter()` builds the address-creation request:

```php
$params = [
  'forwarding_address' => $config['forwarding_address'],
  'callback_link' => Url::fromRoute('bitaps.pages', ['page_type'=>'status'], [
    'absolute' => TRUE,
    'query' => [
      'oid'    => $payment->id,
      'amount' => $form['#params']['amount'],
      'hash'   => $this->bitaps->getHash($payment->id, $form['#params']['amount'], $config),
    ],
  ])->toString(),
  'confirmations' => $config['confirmations'],
];
```

(`hook_bitaps_payment_params_alter()` can alter `$form['#params']` first.) `getAddress()` POSTs
`json_encode($params)` to `PaymentForm::API_URL . 'create/payment/address'`
(`https://api.bitaps.com/btc/v1/create/payment/address`) via `\Drupal::httpClient()->post()`
(default Guzzle TLS verification; no `verify=>false`). The returned `address` is cached under
`$payment->data['md5Params'][md5(serialize($params))]` (`Bitaps::update()`) so re-renders reuse it,
and is shown on the page (`templates/bitaps-pay.html.twig`, library `bitaps/css`). API `error`
strings are surfaced via the messenger.

## 3. Bitaps callback (`page_type=status`)

Bitaps POSTs a notification to the `callback_link` above. `Pages::pages('status')`:

1. Reads the body: `$_POST` or `json_decode(file_get_contents('php://input'))`.
2. `$event = trim($_POST['event'])`.
3. If `?hash`, `?oid`, `?amount` and a non-empty `$event` are present, loads the payment by `oid`
   (`Bitaps::load(['id'=>$_GET['oid']])`).
4. Recomputes `$hash = Bitaps::getHash($payment->id, $_GET['amount'], $config)` and proceeds only
   if `$hash == $_GET['hash']`.
5. On match: sets `$payment->paytime = time()`, `$payment->status = $event`, re-serializes
   `data['pre_pay']`, and `Bitaps::update($payment)`.
6. If `$event === 'confirmed'` and the payment has an `nid` and Basket is present, calls
   `$this->basket->paymentFinish($payment->nid)` (completes the order) and fires
   `hook_bitaps_api_alter($payment, $_POST)`.
7. If `basket_noty` is enabled, triggers the `change_bitaps_status` notification for the order.
8. Finally `print $_POST['invoice'] ?? 'ERROR'; exit;` as the acknowledgement Bitaps expects.

`getHash()` is `hash('sha256', implode('~',[pid, secret_key, amount, secret_key, pid]))` — the
site's `secret_key` is the shared secret with Bitaps, so a caller must know it (or possess the
signed callback URL) to pass step 4.

## Status / Noty exposure

`BitapsHooks::basketNotyTwigTokensAlter()` exposes the current payment `status` as the
`bitaps_status` twig token for a Basket Noty notification; `basketNotyActionsAlter()` registers the
`change_bitaps_status` action.

## Notes for integrators

- Only `event === 'confirmed'` fulfils the order; other events just record the status string.
- The credited amount and confirmation count are those Bitaps enforces at address creation
  (`confirmations` setting); the site itself does not re-query the chain.
- `data` column holds PHP-`serialize()`d module-owned state (address cache, `pre_pay`).
