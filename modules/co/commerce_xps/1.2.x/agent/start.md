<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce XPS — agent index

**XPS Ship real-time shipping-rate** integration for Drupal Commerce. Version **1.2.x**. Core `^9 || ^10`.
Depends on `commerce_shipping`. Provides an XPS shipping-method plugin configured under
`/admin/commerce/shipping-methods`.

Fetches live carrier rates from the XPS API at checkout using order weight/destination. Admin-configured API
credentials (store as secrets, HTTPS). No inbound callback/webhook surface. Outbound-only integration.
