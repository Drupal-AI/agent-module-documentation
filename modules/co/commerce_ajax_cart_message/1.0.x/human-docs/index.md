# Commerce Ajax Cart Message — manual setup guide

**Commerce Ajax Cart Message** (`commerce_ajax_cart_message`) does exactly one
thing: it suppresses Drupal Commerce's default "*item added to your cart*" status
message **when the add‑to‑cart happened via an AJAX request**. On storefronts where
the cart already updates live — an off‑canvas cart, a dynamic cart count, an
AJAX add‑to‑cart button — that status message is redundant and often looks awkward,
because the interface has already shown the change. This module quietly removes it
in that case while leaving the message intact for ordinary, non‑AJAX adds.

It depends only on Commerce Cart (`commerce_cart`). There is genuinely **no
interface and no settings** — the module's own documentation says so. Enable it and
it works; there is nothing to configure. It's purely a presentation/UX tidy‑up,
with no effect on pricing, permissions, or cart contents.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — this module has no settings whatsoever.

## Where it lives in the admin menu

Nowhere — it adds no admin page and has no settings. It pairs naturally with AJAX
cart widgets (an off‑canvas cart, a live cart count, or an AJAX add‑to‑cart
button); once enabled, the redundant status message simply stops appearing on AJAX
adds.
