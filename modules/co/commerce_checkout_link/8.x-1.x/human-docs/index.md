# Commerce Checkout Link — manual setup guide

**Commerce Checkout Link** (`commerce_checkout_link`) lets you generate a
**shareable link that sends a customer straight to a specific order's checkout** —
no login required. It is built for cases where someone other than the shopper
started the order: a staff member who built the order in the admin UI, an
abandoned cart you want the customer to come back and finish, or a guest checkout
handled by email. Send the person the link, they click it, and they land on the
checkout for that exact order, ready to enter addresses and pay.

The module deliberately **exposes no user interface of its own**. Instead it
provides a helper that developers call to build the URL:

```php
\Drupal\commerce_checkout_link\CheckoutLinkManager::generateUrl($order);
```

By default a generated link **expires after 24 hours**. It depends on Commerce
**Order** (`commerce_order`) and **Cart** (`commerce_cart`) and works on Drupal
9.1, 10, and 11.

The link is signed securely. It carries an **HMAC** keyed with your site's secret
hash salt, incorporating the order id and a timestamp, and the controller
validates it with a constant‑time comparison — so an attacker **cannot forge** a
valid link for an arbitrary order without your site's hash salt, and links can be
invalidated as the order changes. Because a valid link grants access to that
order's checkout (viewing the cart, entering addresses, completing payment),
**treat the links as sensitive**: send them over HTTPS, to the intended recipient
only. The module has no access‑control role beyond the signed link itself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside its Commerce Order and Cart dependencies.

There is **no configuration page** for this module — it has no settings form and
no admin UI. It is used entirely from code via the `CheckoutLinkManager` helper,
described above.

## Where it lives in the admin menu

Commerce Checkout Link adds **no admin page and no menu item**. Everything it does
happens through the `CheckoutLinkManager::generateUrl($order)` helper, which
returns a URL you can email, print, or embed however suits your workflow. The link
resolves to the standard Commerce checkout for the referenced order.
