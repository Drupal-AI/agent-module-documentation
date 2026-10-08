<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bambora Payment System — agent index

**Bambora (Worldline) Commerce gateway** (Interac + card). Version **1.0.x-dev**. Core `^9.3||^10||^11`.

Anonymous return endpoints, but completion gated by a **server-side `continuePayment()` API call** to Bambora + server-side amount — forged callbacks can't mark an order paid (positive). Credentials env-backed. Depends on Commerce `commerce_payment`, `commerce_order`.