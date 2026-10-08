<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extension hooks

Documented in `commerce_saferpay.api.php`. Both are invoked from the gateway plugin
(`src/Plugin/Commerce/PaymentGateway/Saferpay.php`).

## `hook_commerce_saferpay_payment_page_data_alter(array &$data, OrderInterface $order)`

Alter the payload sent to `/Payment/v1/PaymentPage/Initialize` before the request is made
(invoked via `moduleHandler()->alter('commerce_saferpay_payment_page_data', …)` in
`paymentPageInitialize()`). Use it to add Saferpay fields such as a `ConfigSet`, extra `Payer`
data, or method-specific options.

```php
function mymodule_commerce_saferpay_payment_page_data_alter(&$data, \Drupal\commerce_order\Entity\OrderInterface $order) {
  $data['ConfigSet'] = 'CustomConfigSet';
}
```

## `hook_commerce_saferpay_assert_result($assert_result, OrderInterface $order, PaymentInterface $payment)`

Invoked (`invokeAll('commerce_saferpay_assert_result', …)`) inside `processPayment()` when a
transaction reaches `CAPTURED`. `$assert_result` is the decoded PaymentPage/Assert response
(`stdClass`). Typical use: read a returned card alias when `request_alias` is enabled.

```php
function mymodule_commerce_saferpay_assert_result($assert_result, $order, $payment) {
  if (!empty($assert_result->RegistrationResult->Alias->Id)) {
    // Store the alias id for later use.
  }
}
```

Note: the module requests an alias (config `request_alias`) but does not itself create a reusable
Commerce payment method — a contrib/custom module must consume the alias via this hook.
