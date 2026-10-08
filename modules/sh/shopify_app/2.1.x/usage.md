<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A framework for building an embedded Shopify app in Drupal.

---

Shopify App provides the scaffolding to implement a Shopify app in Drupal — handling the Shopify OAuth install flow, session storage, and webhook processing (via the official Shopify PHP SDK), so developers can build an embedded Shopify app backed by Drupal.

The webhook endpoint is public by design but the module verifies the Shopify `X-Shopify-Hmac-Sha256` signature via the SDK's `Registry::process()` before handling. The Shopify API credentials are admin-configured; store them securely (env-backed). Supports Drupal 11.

---

- Scaffold a Shopify app.
- Handle the OAuth install flow.
- Store Shopify sessions.
- Process Shopify webhooks.
- Verify webhook HMAC via the SDK.
- Use the official Shopify PHP SDK.
- Store credentials securely.
- Support Drupal 11.
- Aid Shopify developers.
- Handle the Shopify app.
- Integrate Shopify.
- Build embedded apps
- Support Drupal.
- Support Drupal.
- Support Drupal.
