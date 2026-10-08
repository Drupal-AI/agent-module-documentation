<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Winbank (Redirect) — agent index

A **Winbank (Piraeus Bank) redirect payment gateway for Drupal Commerce** (Greece). Depends on `commerce`,
`commerce_payment`. Version **2.0.x** (dev). Core `^8||^9||^10||^11`.

E-commerce/payment — the public callback **verifies the response signature** (recomputes an HMAC-SHA256
`HashKey`, rejects on mismatch — no forged-callback fulfillment). Credentials as secrets, HTTPS. Minor: uses
`!==` not `hash_equals`. No access role.
