<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Shopify eCommerce displays your Shopify store within your Drupal site, syncing products/collections from Shopify.

---

Shopify eCommerce integrates a Shopify store into Drupal — syncing products/collections from Shopify and
displaying them within the Drupal site, so a store hosted on Shopify can be surfaced through Drupal (with
checkout typically happening on Shopify). It is configured at `shopify.admin` and provides its own
permissions.

Use it to present a Shopify catalog in Drupal. The security-relevant points: it connects to Shopify with API
credentials (an API key/token) — store them as secrets; and if it receives Shopify webhooks (for product/
order sync), those webhooks should be authenticated (Shopify signs webhooks with an HMAC — verify the
signature so forged webhook calls are rejected). Confirm the webhook verification and store credentials
securely. It is an e-commerce/integration feature; product content is synced from Shopify. Configure the
Shopify connection.

---

- Display a Shopify store in Drupal.
- Sync products/collections from Shopify.
- Surface a Shopify catalog.
- Configure at shopify.admin.
- Provide its own permissions.
- Store the Shopify API token as a secret.
- Verify Shopify webhook HMAC signatures.
- Reject forged webhook calls.
- Handle checkout on Shopify.
- Confirm webhook verification.
- Sync product content.
- Connect to Shopify securely.
- Handle credentials securely.
- Present products.
- Integrate Shopify.
- Configure the connection.
- Sync collections.
- Display store products.
- Authenticate webhooks.
- Surface Shopify content.
