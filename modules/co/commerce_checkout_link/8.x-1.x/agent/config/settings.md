<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config setting, link helper, redirect event & timeout hook

## Generating a link (developer surface)

There is **no UI or route to generate a link** — call the static helper from your own code:

```php
use Drupal\commerce_checkout_link\CheckoutLinkManager;

// Returns a \Drupal\Core\Url to the checkout-link route for this order.
$url = CheckoutLinkManager::generateUrl($order);
$link = $url->setAbsolute()->toString(); // email/print this
```

`generateUrl(OrderInterface $order, $use_changed_time = TRUE)` stamps `time()` and builds the route
`commerce_checkout_link.checkout_link` with params `commerce_order` (id), `timestamp`, `hash`.
Because generation is code-only, **whatever code path calls it is responsible for authorizing who
may create a link** — the module adds no permission of its own.

## The hash

`CheckoutLinkManager::generateHash($timestamp, OrderInterface $order, $use_changed_time = TRUE)`:

```php
$changed = $use_changed_time ? $order->getChangedTime() : '';
return Crypt::hmacBase64($timestamp . $order->id() . $changed, Settings::getHashSalt());
```

- **Keyed with the site hash salt** (`settings.php`), so the signature cannot be produced or
  predicted without that secret. Verified in the controller with `hash_equals()` (constant-time).
- The order id is *inside* the signature, so a link is bound to exactly one order.
- With `use_changed_time` on, editing the order changes `getChangedTime()` and invalidates the link.

## `commerce_checkout_link.settings`

| key | type | default | effect |
|-----|------|---------|--------|
| `use_changed_timestamp` | integer | `1` | When truthy, the order's `changed` timestamp is folded into the hash → links invalidate whenever the order is modified. When `0`, links stay valid across order edits (still bounded by the timeout). |

Default set in `config/install/commerce_checkout_link.settings.yml`; schema in
`config/schema/commerce_checkout_link.schema.yml`. There is no settings form — change it with
`drush cset commerce_checkout_link.settings use_changed_timestamp 0` or a config import.

Controller nuance: when `use_changed_timestamp` is `0` the controller first validates the hash the
lenient way, and if that fails it *also* retries a strict changed-time comparison — so a link minted
while the setting was on still validates after the setting is turned off (as long as the order is
unchanged). See `tests/src/Kernel/RedirectTest.php` for the three validation paths.

## Link lifetime — `hook_commerce_checkout_link_timeout_alter`

The controller sets `$timeout = 24 * 3600` (24 h) then invokes the alter hook, so a link older than
the timeout throws `AccessDeniedHttpException`. Extend or shorten it:

```php
function mymodule_commerce_checkout_link_timeout_alter(&$timeout) {
  // Keep links valid for 7 days.
  $timeout = $timeout * 7;
}
```

## Redirect event — `commerce_checkout_link.redirect`

After a valid link assigns the order to the visitor, the controller dispatches
`CommerceCheckoutLinkEvents::CHECKOUT_LINK_REDIRECT` with a `CheckoutLinkEvent` before redirecting.
Subscribe to inspect/act on the order or to change the destination:

```php
public static function getSubscribedEvents() {
  return [CommerceCheckoutLinkEvents::CHECKOUT_LINK_REDIRECT => 'onRedirect'];
}

public function onRedirect(\Drupal\commerce_checkout_link\Event\CheckoutLinkEvent $event) {
  $order = $event->getOrder();
  $event->setUrl(\Drupal\Core\Url::fromRoute('…')); // override the redirect target
}
```

The default target is `commerce_checkout.form` for the order (absolute URL). Only trusted subscriber
code should set the URL, since the returned `Url` becomes the redirect response.
