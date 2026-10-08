<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Payment Elavon — agent index

Drupal Commerce **payment gateway for Elavon** (Converge / Virtual Merchant — card payments). Depends on
`commerce`. Version **2.0.x** (dev). Core `^10.3||^11`.

**Security:** store Elavon merchant/API credentials as **secrets**; HTTPS; validate the payment result
server-side (confirm/capture against Elavon's authenticated API, not a client result); confirm test/live
mode.
