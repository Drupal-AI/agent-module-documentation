<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Easy (Nets Easy) — agent index

A Drupal Commerce **payment gateway for Nets Easy (Nexi)** hosted checkout. Depends on `commerce_payment`.
Version **1.x** (dev). Core `^9||^10||^11`.

E-commerce/payment — trust boundary is **payment confirmation**: ensure it confirms **server-side** with the
Nets API (not a client return) before fulfilling; **API keys** as secrets, HTTPS. No access role.
