# Commerce Tokens — manual setup guide

**Commerce Tokens** (`commerce_tokens`) provides a set of extra **Commerce
tokens** you can use anywhere Drupal renders tokens — order‑confirmation emails,
receipts, messages, and other text contexts. Order and product values often need
to appear in customer‑facing text, and this module supplies the tokens to drop them
in without custom code.

The module adds tokens for several Commerce concepts:

- **Commerce currency** — values from the commerce currency entity.
- **Current Commerce Store** — the store for the current request.
- **Default Commerce Store** — the site's default store.
- **Current Commerce Order** — the order for the current request.
- **Current Commerce Product** — the product for the current request.
- **Current Commerce Product Variation** — the variation for the current request.

It depends only on **Commerce**. It is a pure token provider: there is no settings
page, no route, and no permission of its own, and it works the moment you enable
it. The one thing worth checking is that any tokens you place in **customer‑facing**
contexts expose only the values you intend — an order token in an email, for
example, should not surface internal‑only fields.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — the tokens are available to
use as soon as it is enabled.

## How to use it

Once enabled, the new tokens appear in the standard **token browser** wherever
Drupal offers one — for example when editing an order‑confirmation email, a
Commerce message, or any field that supports tokens. Browse to the relevant
Commerce token group (currency, store, order, product, or variation) and insert
the token you need. There is nothing to configure first.

## Verify

Insert one of the tokens (for example a current‑order token) into a test email or
message, trigger it with a real order, and confirm the value renders correctly and
shows only the data you expect customers to see.
