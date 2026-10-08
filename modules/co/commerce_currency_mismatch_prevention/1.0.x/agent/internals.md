<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Internals — decorator flow, services, DTOs

## Service wiring (`*.services.yml`)

- `commerce_currency_mismatch_prevention.settings` → `SettingsService(@config.factory)`.
- `commerce_currency_mismatch_prevention.validation` → `CurrencyValidationService(@…settings)`.
- `commerce_currency_mismatch_prevention.message` →
  `CurrencyMessageService(@…settings, @messenger)`.
- `logger.channel.commerce_currency_mismatch_prevention` → dedicated logger channel.
- `commerce_currency_mismatch_prevention.cart_manager_decorator` →
  `CartManagerDecorator(inner, validation, message, logger, settings)`, `decorates:
  commerce_cart.cart_manager`, `public: false`.

Because it decorates the core service, anything resolving `commerce_cart.cart_manager` (the standard
add-to-cart form, `CartProvider`-driven flows, other code injecting that service) gets the guarded
version transparently. Item additions performed outside the cart manager — e.g. building order items
directly on the order entity and saving — are handled by Commerce itself, not by this decorator.

## `CartManagerDecorator` — guarded methods

### `addEntity($cart, $entity, $quantity='1', $combine=TRUE, $save_cart=TRUE)`
1. `validation = validationService->validateEntity($cart, $entity)`.
2. If `!$validation->isValid()` → `handleEntityValidationFailure(...)`.
3. Else delegate to inner `addEntity()`, wrapped in `try/catch (CurrencyMismatchException $e)` →
   `handleEntityException(...)`.

`handleEntityValidationFailure`: reads `getCartBehavior()`.
- `remove_existing` → `showCartEmptiedMessage($validation)`, `emptyCart($cart, FALSE)`, then inner
  `addEntity(...)` (returns the new order item).
- otherwise (`keep_current`) → `showProductRejectedMessage($validation)`, return **`NULL`**.

`handleEntityException`: reads `getCartBehavior()`.
- `disabled` → re-throw `$e`.
- `remove_existing` → message, `emptyCart(FALSE)`, retry inner `addEntity` (no `$validation` passed,
  so the generic message is used).
- `keep_current` → message + `cleanupPartiallyCreatedOrderItem($cart, $entity)`, return `NULL`.

### `addOrderItem($cart, $order_item, $combine=TRUE, $save_cart=TRUE)`
Mirror of `addEntity` using `validateOrderItem()`:
- validation failure + `remove_existing` → empty cart, inner `addOrderItem`.
- validation failure + `keep_current` → message, return the **un-added `$order_item`** (not `NULL`).
- exception + `disabled` → re-throw; `remove_existing` → empty + retry; `keep_current` → message +
  `cleanupSavedOrderItem`, return `$order_item`.

### Cleanup helpers
- `cleanupPartiallyCreatedOrderItem($cart, $entity)`: loops `$cart->getItems()`, matches items whose
  purchased entity id+type equal the added entity **and** `isNew()`, then `removeItem()` + `delete()`;
  errors are logged, not thrown.
- `cleanupSavedOrderItem($cart, $order_item)`: if the item is not new, `removeItem` (when present) +
  `delete()`; errors logged.

### Delegated (unchanged) methods
`emptyCart`, `createOrderItem`, `updateOrderItem`, `removeOrderItem` pass straight to the inner
cart manager — currency is only checked on the two add paths.

## `CurrencyValidationService`

- `validateEntity($cart, $entity)` / `validateOrderItem($cart, $orderItem)`: return a valid result
  immediately if `settings->isEnabled()` is FALSE, or if the new item has **no price** (currency
  cannot be determined). Otherwise `detectConflict()` decides.
- `detectConflict($cart, $newCurrency)`: empty cart → no conflict; skips cart items with no unit
  price; returns a conflict (with the existing currency) on the first differing currency.
- `getCurrencyFromEntity()` / `getCurrencyFromOrderItem()`: null-safe currency-code extraction.

## DTOs (immutable, constructor-promoted)

- `CurrencyValidationResult(bool $valid, ?string $newCurrency, ?string $existingCurrency)` —
  `isValid()`, `hasConflict()` (= `!valid`), `getNewCurrency()`, `getExistingCurrency()`.
- `CurrencyConflictResult(bool $hasConflict, ?string $existingCurrency)` — `hasConflict()`,
  `getExistingCurrency()`.

## `SettingsService`

- `getCartBehavior()`: `cart_management.remove_different_currency` **?? `'disabled'`** (fallback when
  unset).
- `isEnabled()`: behaviour !== `disabled`.
- `isUserNotificationEnabled()`: `notifications.show_user_message` (bool).
- `getNotificationMessageType()`: `notifications.message_type` ?? `status`.

## `CurrencyMessageService`

`showCartEmptiedMessage()` / `showProductRejectedMessage()` build a currency-specific message when
both currencies are known, else a generic one, then `showMessage()`. `showMessage()` returns early
unless `isUserNotificationEnabled()`, then routes to `addError`/`addStatus`/`addWarning` by
`message_type`. All strings use `t()` with `@`-placeholders.

## Tests

- `tests/src/Unit/CartManagerDecoratorTest.php` — mocks each service; covers all three behaviours on
  both validation-failure and exception paths, plus delegation of the pass-through methods.
- `tests/src/Kernel/CartManagerDecoratorKernelTest.php` — full Commerce stack; asserts USD/EUR
  scenarios for `disabled` (throws), `remove_existing` (swaps cart), `keep_current` (rejects), same
  currency allowed, and empty cart allows any currency.

## Gotchas

- Currency checks are applied on the two add paths, `addEntity()` and `addOrderItem()`; the other
  `CartManagerInterface` methods delegate unchanged to the inner cart manager.
- `getCartBehavior()` returns `disabled` when the config value is unset (the shipped
  `config/install` default is `remove_existing`).
- `keep_current` returns `NULL` from `addEntity` but the original order item from `addOrderItem` —
  callers should not assume a non-null return means the item was added.
