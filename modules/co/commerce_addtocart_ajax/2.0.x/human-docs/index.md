# Commerce Add to Cart Ajax — manual setup guide

**Commerce Add to Cart Ajax** (`commerce_addtocart_ajax`) makes the Drupal
Commerce add‑to‑cart button submit over AJAX, so adding a product happens in place
without reloading the whole page. When a shopper clicks *Add to cart* they see an
animated loading indicator, the status message appears in your theme's messages
area, and the cart block refreshes to show the new item — a smoother, more modern
shopping experience than the default full‑page submit.

It depends on Drupal Commerce (the `commerce` and `commerce_cart` modules).
Deliberately, it keeps things simple: it began
as a rewrite of the older *Ajax add to cart* module, dropping the modal feature and
focusing on doing one thing cleanly. The add‑to‑cart operation itself still runs
through Commerce's normal handling and access checks — this module only changes how
the form is submitted, so it has no bearing on pricing or permissions.

There is one small thing you *may* need to set: the CSS selector where status
messages should be injected, because that varies by theme. Out of the box it
targets `[data-drupal-messages],[data-drupal-messages-fallback]` — the standard
markers core's status-messages markup uses — so for most modern themes the module
is effectively "works on enable." If your theme puts messages in a different
container, point the module at it on the settings form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the status‑message selector to
   match your theme.

## Where it lives in the admin menu

Its settings form is at **Commerce → Configuration → Add to cart Ajax**
(`/admin/commerce/config/commerce-addtocart-ajax`). The AJAX behaviour applies to
the standard Commerce add‑to‑cart form on your storefront once the module is
enabled.
