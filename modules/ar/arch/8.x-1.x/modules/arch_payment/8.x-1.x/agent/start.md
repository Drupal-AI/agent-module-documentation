<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Payment (arch_payment) — agent index

Payment framework for the Arch suite. Depends on `arch`, `arch_order`, `arch_price`. Project `arch`
(`8.x-1.0-alpha26`). Gateway submodules: `arch_payment_cod`, `arch_payment_transfer`,
`arch_payment_saferpay`.

- **The `PaymentMethod` plugin type + gateway base classes** → [plugins/payment-method.md](plugins/payment-method.md)

## Provides

- Plugin type **`arch_payment_methods`** — manager `plugin.manager.payment_method`
  (`PaymentMethodManager`), annotation `@PaymentMethod` (`Annotation\PaymentMethod`), interface
  `PaymentMethodInterface`, base `PaymentMethodBase` / `ConfigurablePaymentMethodBase`. Declared in
  `arch_payment.plugin_type.yml` (decorated by `plugin`'s `ArrayPluginDefinitionDecorator`).
- Base controller `Controller\PaymentControllerBase` (gateways subclass for
  success/cancel/error/redirect); `__call` logs `payment*` actions (logger `@todo`).
- Field formatter `Plugin\Field\FieldFormatter\PaymentMethodFormatter`.
- Routes (`arch_payment.routing.yml`, all `_admin_route`):
  - `arch_payment.payment_method.overview` `/admin/store/settings/payment-methods` — `Form\OverviewForm`
    (perm `administer payment settings`).
  - `arch_payment.configure_plugin` `…/{payment_method}` — `PaymentMethodConfigureController::settings`
    (perm `administer payment settings`).
  - `arch_payment.disable_method` / `arch_payment.enable_method` `…/{payment_method}/{disable,enable}`
    — perm **`administer payment methods`** (note: this permission string is **not declared** in
    `arch_payment.permissions.yml`, which only defines `administer payment settings`).
- Permission **`administer payment settings`** (`restrict access: true`).
- Hooks (`arch_payment.api.php`): `hook_payment_method_access($method, $order, $account)` (filters
  availability), `hook_payment_method_fee_alter($order, $price, $context)`.

## Concrete gateways

Each declares a `callback_route` in its `@PaymentMethod` annotation, and the onepage checkout
redirects to it after saving the order (`?order=<id>`):
[arch_payment_cod](../../arch_payment_cod/8.x-1.x/agent/start.md) (`cod`),
[arch_payment_transfer](../../arch_payment_transfer/8.x-1.x/agent/start.md) (`transfer`),
[arch_payment_saferpay](../../arch_payment_saferpay/8.x-1.x/agent/start.md) (`saferpay`).
