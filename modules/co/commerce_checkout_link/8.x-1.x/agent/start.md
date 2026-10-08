<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Checkout Link (commerce_checkout_link) — agent index

Generates a **shareable, HMAC-signed link that sends a customer straight to a specific order's
checkout** — resume an abandoned cart, finish a staff-created order, or a guest checkout, **without
requiring a login**. The module ships **no UI, no route to generate links, and no permissions**: a
developer calls the `CheckoutLinkManager::generateUrl($order)` helper and delivers the URL however
they like (email, print, custom controller). Depends on `commerce_order`, `commerce_cart`. Version
**8.x-1.5** (version dir `8.x-1.x`). Core `^9.1 || ^10 || ^11`. License GPL-2.0-or-later.

## What it provides (from source)

- **Helper** `CheckoutLinkManager` (`src/CheckoutLinkManager.php`) — `generateUrl($order,
  $use_changed_time = TRUE)` returns a `Url` to the checkout-link route; `generateHash($timestamp,
  $order, $use_changed_time)` builds the signature.
- **Route** `commerce_checkout_link.checkout_link` (`.routing.yml`):
  `/commerce-checkout-link/{commerce_order}/{timestamp}/{hash}`, `_permission: 'access content'`,
  handled by `Controller/CommerceCheckoutLinkController::checkout()`. The link's own HMAC — not the
  route permission — is the real gate.
- **Config** `commerce_checkout_link.settings` with one key `use_changed_timestamp` (default `1`):
  when set the order's `changed` time is folded into the hash, so editing the order invalidates
  outstanding links. Schema in `config/schema/`. No settings form ships.
- **Event** `CommerceCheckoutLinkEvents::CHECKOUT_LINK_REDIRECT` (`commerce_checkout_link.redirect`)
  dispatching `Event/CheckoutLinkEvent` (carries the order + mutable redirect `Url`) — lets other
  modules act on the order or change where the visitor is sent after claiming it.
- **Alter hook** `hook_commerce_checkout_link_timeout_alter(&$timeout)` (`.api.php`) — change the
  link lifetime (default `24 * 3600` seconds = 24 h).
- One hook: `hook_help()`. No install/update hooks, no permissions, no plugins, no services file.

## How opening a link behaves (controller)

`checkout()` rejects the request (`AccessDeniedHttpException`) if the link is older than the
timeout, if the hash is empty, or if `hash_equals()` fails against the recomputed HMAC (with a
fallback recompute using strict changed-time when `use_changed_timestamp` is off). On success it
clears the visitor's **other** carts (and anonymous session cart ids), **assigns the order to the
current visitor** via `commerce_order.order_assignment` (it does **not** log the visitor in as the
order's original customer), then `RedirectResponse`s to `commerce_checkout.form` for that order
(URL overridable by the event).

## Solution docs

- **Config setting, the `generateUrl`/`generateHash` helper, the redirect event, the timeout alter
  hook, and the exact hash construction** → [config/settings.md](config/settings.md)
