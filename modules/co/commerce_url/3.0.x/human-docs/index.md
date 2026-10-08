# Commerce Url Hash — manual setup guide

**Commerce Url Hash** (`commerce_url`) hides the numeric **order ID** from Drupal
Commerce checkout URLs. By default the checkout steps expose the raw, sequential
order number:

```
/checkout/123/order_information
/checkout/123/payment
/checkout/123/confirmation
```

With this module enabled, that `123` is replaced by an encrypted token, so casual
visitors can't read your order number off the URL or guess neighbouring ones.

It works by registering an inbound/outbound **path processor** that intercepts any
path beginning with `/checkout/`. On outbound links it encrypts the order‑ID
segment; on inbound requests it decrypts the token back to the real ID before
routing, so multi‑step checkout keeps working transparently. Encryption uses PHP's
`openssl_encrypt`/`openssl_decrypt` (AES‑256‑CBC) via a reusable service,
`commerce_url.encrypt_decrypt`, which developers can also call from custom code to
encrypt or decrypt any string. It depends only on **Commerce**.

**Important security caveat:** the cipher key and IV are **hard‑coded constants in
the module's source**, so the token is **obfuscation, not access control**. It
hides the sequential order number from casual users, but anyone who reads the
source can reverse it. Do **not** rely on it to protect orders — keep Drupal
Commerce's own order‑access permissions in place. Also note this module is currently
**not covered by Drupal's security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — no settings form, route, or
permission. It activates automatically once enabled.

## How to use it

There is nothing to configure. Enable the module and visit any checkout URL — the
order ID segment will already appear as an encrypted token instead of the plain
number. To revert to plain numeric checkout URLs, simply disable the module.

Developers who want to reuse the encryption in custom code (for example to wrap an
order ID in an email or export) can call the `commerce_url.encrypt_decrypt` service.
See the sibling agent docs at
[`agent/api/encrypt-decrypt-service.md`](../agent/api/encrypt-decrypt-service.md)
for the method signature.

## Verify

Start a checkout and confirm the URL shows `/checkout/{token}/{step}` and that the
step still resolves to the correct order. Remember the token is obfuscation only —
confirm your Commerce order‑access permissions are configured for real protection.
