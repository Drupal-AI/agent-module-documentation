<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Currency Mismatch Prevention (`commerce_currency_mismatch_prevention`) — agent index

Stops a Drupal Commerce cart from ending up with items priced in **different currencies** — the
state that triggers Commerce's `CurrencyMismatchException` ("The provided prices have mismatched
currencies") and breaks order totals/checkout. Version **1.0.1**, core `^11` (composer requires
`drupal/commerce:^3.0`, `drupal/core:^11`). GPL-2.0-or-later. Depends on `commerce`,
`commerce_cart`, `commerce_order`.

**No custom permissions** (settings route reuses core Commerce `access commerce administration
pages`), **no Drush**, **no hooks/.module/.install**, no theme/JS/templates. One admin settings
form; all behaviour is delivered by **decorating the cart manager**.

## How it actually works (service decoration)

The module **decorates the core `commerce_cart.cart_manager` service** with
`src/CartManagerDecorator.php` (`decorates: commerce_cart.cart_manager`, `public: false`). Every
add-to-cart in Commerce that goes through the cart manager is intercepted:

1. **`addEntity()` / `addOrderItem()`** — before delegating to the inner cart manager, the decorator
   pre-validates the currency via `CurrencyValidationService`. The new currency is read
   **server-side** from the purchasable entity's price (`$entity->getPrice()->getCurrencyCode()`)
   or the order item's unit price (`$orderItem->getUnitPrice()->getCurrencyCode()`) — never from
   request input. `detectConflict()` scans existing cart items' unit prices; the first item whose
   currency differs is a conflict.
2. **On conflict** (`isValid() === FALSE`) the decorator applies the configured behaviour (below).
3. **Fallback** — the real add is still wrapped in a `try/catch` for `CurrencyMismatchException`;
   if Commerce throws it anyway, the same behaviour logic runs (and `disabled` re-throws).

Other `CartManagerInterface` methods (`emptyCart`, `createOrderItem`, `updateOrderItem`,
`removeOrderItem`) are delegated unchanged to the inner service.

## Behaviours (config `cart_management.remove_different_currency`)

- **`remove_existing`** (shipped default in `config/install`): empty the cart (without saving), then
  add the new product. Shows the "cart emptied" message.
- **`keep_current`**: reject the new product. `addEntity` returns `NULL`; `addOrderItem` returns the
  (un-added) order item. Shows the "product rejected" message.
- **`disabled`**: no interception — the currency mismatch is allowed to surface as the native
  `CurrencyMismatchException`. Note: `SettingsService::getCartBehavior()` also falls back to
  `disabled` if the config value is missing/null.

`SettingsService::isEnabled()` is `TRUE` for any behaviour other than `disabled`; when disabled the
validation service short-circuits to valid and does nothing.

## Configuration

- Route `commerce_currency_mismatch_prevention.settings` → `/admin/commerce/config/currency-mismatch`
  (`SettingsForm`, a `ConfigFormBase`), requirement `_permission: 'access commerce administration
  pages'`. Menu link under *Commerce → Configuration → Store → Currency mismatch prevention*
  (`commerce.store_configuration`).
- Config object `commerce_currency_mismatch_prevention.settings` (schema in `config/schema/`):
  `cart_management.remove_different_currency`, `notifications.show_user_message` (bool),
  `notifications.message_type` (`status` | `warning` | `error`; default `status`).
- Messages are emitted by `CurrencyMessageService` only when `show_user_message` is on; text is
  built with `t()` placeholders (`@old_currency`/`@new_currency` etc. — ISO codes, auto-escaped).

## Key files

- `src/CartManagerDecorator.php` — the decorator; conflict/exception handling + cleanup helpers.
- `src/Service/CurrencyValidationService.php` — `validateEntity()`, `validateOrderItem()`,
  `detectConflict()`, currency extraction.
- `src/Service/SettingsService.php` — reads config (`getCartBehavior`, `isEnabled`,
  notification getters).
- `src/Service/CurrencyMessageService.php` — messenger output.
- `src/Dto/CurrencyValidationResult.php`, `src/Dto/CurrencyConflictResult.php` — immutable result DTOs.
- `src/Form/SettingsForm.php` — the admin form.

See [`internals.md`](internals.md) for the full method-by-method flow, the DTO contract, and gotchas.
