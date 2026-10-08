<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `PaymentMethod` plugin type & gateway base classes

## Wiring

- Manager: **`plugin.manager.payment_method`**, class `PaymentMethodManager` (parent
  `default_plugin_manager`). Annotation `@PaymentMethod` (`Annotation\PaymentMethod`).
- Interface `PaymentMethodInterface`; bases `PaymentMethodBase` and
  `ConfigurablePaymentMethodBase` (the latter adds a settings form via `PluginFormInterface`).
- Plugin-type id `arch_payment_methods` (`arch_payment.plugin_type.yml`).

## Annotation

```php
/**
 * @PaymentMethod(
 *   id = "cod",
 *   label = @Translation("Cash on delivery"),
 *   administrative_label = @Translation("Cash on delivery"),
 *   description = @Translation("…"),
 *   module = "arch_payment_cod",
 *   callback_route = "arch_payment_cod.success"
 * )
 */
```

`callback_route` is the route the checkout redirects to after saving the order (with `?order=<id>`).

## `PaymentMethodBase` (key methods)

- `isActive()` / `enable()` / `disable()`, `getWeight()` / `setWeight()` (persisted via the
  `keyvalue` store).
- `isAvailable(OrderInterface $order)` — returns FALSE if not active; otherwise runs
  `hook_payment_method_access($method, $order, $account)` and forbids if any implementation returns a
  forbidden `AccessResult`. `PaymentMethodManager::getAvailablePaymentMethods($order)` uses this to
  build the checkout selector.
- `getCallbackRoute()` — reads `callback_route` from the plugin definition.
- `getPaymentFee(OrderInterface $order)` — the method's fee as an `arch_price` Price (altered by
  `hook_payment_method_fee_alter`). The onepage checkout applies it via `Order::setPaymentFee()`.
- `getLabel()` / `getAdminLabel()` / `getDescription()` / `getImage()`.

`ConfigurablePaymentMethodBase` adds `buildConfigurationForm()` /
`validateConfigurationForm()` / `submitConfigurationForm()` reached from
`PaymentMethodConfigureController::settings` (`/admin/store/settings/payment-methods/{payment_method}`).

## Admin overview

`Form\OverviewForm` (`/admin/store/settings/payment-methods`) lists methods and links to configure /
enable / disable. Enable/disable routes are gated by the (undeclared) `administer payment methods`
permission; the overview + configure routes use `administer payment settings`.

## Gateway controllers

Concrete gateways subclass `Controller\PaymentControllerBase` and implement
`paymentSuccess()` / `paymentCancel()` / `paymentError()` (and Saferpay adds `redirectPage()`).
`PaymentControllerBase::__call()` wraps each call with `beforeAction()` → `logAction()` (which is a
stub — the logger is a `@todo`). See each gateway submodule's docs for its routes.

## Writing a gateway (outline)

1. Create a `@PaymentMethod` plugin in `Plugin/PaymentMethod/…` (extend `PaymentMethodBase` or
   `ConfigurablePaymentMethodBase`), set `callback_route`.
2. Define that callback route → a controller extending `PaymentControllerBase`.
3. In `paymentSuccess()`, verify the payment with the PSP, then redirect to
   `arch_checkout.complete` with the order id.
