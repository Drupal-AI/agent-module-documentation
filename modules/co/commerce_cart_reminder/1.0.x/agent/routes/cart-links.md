<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, token scheme, controllers, bulk action & mail

## Routes (`commerce_cart_reminder.routing.yml`)

| Route | Path | Access | Handler |
|---|---|---|---|
| `commerce_cart_reminder.collection` | `/admin/config/commerce/cart-reminder` | `administer commerce cart reminders` | system admin menu block |
| `commerce_cart_reminder.settings` | `/admin/config/commerce/cart-reminder/settings` | `administer commerce cart reminders` | `CartReminderSettingsForm` |
| `commerce_cart_reminder.continue_cart` | `/cart/reminder/{order}/continue/{token}` | `_access: 'TRUE'`, `order: \d+` | `CartReminderController::continueCart` |
| `commerce_cart_reminder.refer_cart` | `/cart/{order}/refer/{token}` | `_access: 'TRUE'`, `order: \d+` | `CartReminderController::addItemsToCartFromReferral` |
| `commerce_cart_reminder.cart_referral_modal` | `/admin/commerce/order/{order}/reminder-popup` | `administer commerce cart reminders` | `CartReminderController::showGenerateCartUrl` |

The two public `_access: 'TRUE'` routes are gated by the `{token}` in the path, not by Drupal permissions —
this is the intended "anyone with the emailed/shared link" flow. See the token scheme below.

## Token scheme

Both the generator (`CartReminderService::generateCartLink`) and both validating controller methods compute:

```
$token = hash('sha256', $order->id() . $this->privateKey->get() . $order->getCreatedTime());
```

- `private_key` is Drupal core's site-wide secret (`@private_key`). It is the shared secret that makes the
  token unforgeable from public inputs (order id, creation time). The token is a stable per-order value and
  the link works while the order remains a `draft` cart.
- Validation is a strict `!==` string compare; a mismatch shows a generic "Invalid or expired cart link" error
  and redirects to `<front>`.

## `continueCart($order, $token)`

1. Loads the order; rejects unless it exists and `state == 'draft'`.
2. Recomputes and compares the token.
3. Restores the cart into the **current session/user**:
   - No existing cart → assigns the order to the current user (`setCustomer`), recalculates total, saves, and
     `cartSession->addCartId()`.
   - Existing empty cart → transfers items into it, empties the original order.
   - Existing non-empty cart → merges quantities per purchased entity (`findExistingCartItem`), empties the
     original order.
4. Logs and redirects to `commerce_cart.page`. (Note: despite the project's README, anonymous clicks are not
   prompted for contact details — the cart is restored directly.)

## `addItemsToCartFromReferral($order, $token)`

Referral/reorder flow. Validates the same token, then **copies the order's items into the clicker's own
cart** (creating a new draft cart from the order's type/store if the clicker has none). Never reassigns the
original order; only product variations (public catalog data) are added. An older unused variant
`addItemsToCartFromReferral1()` remains in the file (not routed).

## `showGenerateCartUrl($order)`

Permission-gated AJAX modal (`administer commerce cart reminders`) that renders the generated
`continue_cart` link as copyable markup for an admin. Wired onto the order canonical page by
`hook_entity_view_alter` (a "Create a Cart Referral Link" dialog button).

## Bulk action `Plugin/Action/CartReminder`

- Action id `commerce_cart_reminder`, `type: commerce_order`; appears on the carts view (`hook_form_alter`
  removes it elsewhere).
- `access()` requires `administer commerce cart reminders` and order state `draft`/`cart`.
- `execute()` ignores the per-row selection and, when `enable_bulk_send_reminders` is on, queries draft/cart
  orders (respecting `resend_reminders`) and runs a **batch** that calls
  `sendCartReminderEmailForOrder()` per order. `getOrdersToRemind()` uses `accessCheck(TRUE)`.

## Mail (`hook_mail`, key `reminder`)

Sets `subject`/`body` from params, optional `Cc`/`Bcc` headers, and `Content-Type: text/html; charset=UTF-8`.
Only the `reminder` key is handled.
