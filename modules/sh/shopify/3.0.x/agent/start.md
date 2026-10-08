<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shopify eCommerce — agent index

Displays a **Shopify store within Drupal** (sync products/collections from Shopify; checkout typically on
Shopify). Config at `shopify.admin`; provides permissions. Version **3.0.x** (dev). Core `^9||^10||^11`.

**Security:** store the Shopify API token as a secret; if receiving Shopify webhooks, **verify the HMAC
signature** (reject forged calls). E-commerce/integration — product content synced from Shopify.
