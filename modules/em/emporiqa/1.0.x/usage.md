<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Integrates Drupal Commerce with the Emporiqa SaaS chat assistant — syncing catalog and content, embedding the chat widget, and exposing in-chat cart, checkout, and order-tracking endpoints.

---

Emporiqa is the Drupal side of the Emporiqa AI shopping-assistant service. It syncs Commerce products, variations, and opted-in content nodes to the Emporiqa platform over signed webhooks — automatically on entity save/delete (queued and drained by cron), and on demand through an admin Batch UI or Drush full-sync commands. It embeds the chat widget on non-admin pages, exposes small JSON cart endpoints (`/emporiqa/api/cart*`) so the widget can view, add, update, remove, and clear items in the visitor's session cart via Commerce's cart provider, and issues an HMAC-signed user-identity token so the widget can identify a logged-in shopper. It also sends an `order.completed` webhook on configured Commerce order transitions and answers order-tracking lookups from the platform through a signature-verified endpoint. Payloads carry all enabled translations and per-store channels, with resolved promotion-aware prices and stock read from Commerce Stock, a configured field, or publish status. Configuration lives at `/admin/config/services/emporiqa` (Store ID, connection secret, sync toggles, product field mapping); it depends on `commerce_product` and core `node`, and supports Drupal 10.3+, 11, and 12.

---

- Connect a Drupal Commerce store to the Emporiqa chat assistant.
- Embed the Emporiqa chat widget on all non-admin front-end pages.
- Sync Commerce products and variations to Emporiqa on create/update/delete.
- Sync opted-in content types (via the "Emporiqa" display mode) as pages.
- Run a full one-shot sync from the admin Sync tab using the Batch API.
- Run a full sync from the CLI with `drush emporiqa:sync-products`, `:sync-pages`, or `:sync-all`.
- Test the connection with a dry-run payload from the UI or `drush emporiqa:test-connection`.
- Send all enabled translations of each product/page in one consolidated payload.
- Assign products to per-store sales channels for widget filtering.
- Include resolved, promotion-aware prices (sale price plus original list price).
- Read stock from Commerce Stock, a configured numeric field, or publish status.
- Emit lightweight `product.availability` events when only stock changes.
- Reflect Commerce Stock transactions (sales, returns, adjustments) in availability.
- View the current session cart as JSON via `GET /emporiqa/api/cart`.
- Add, update, remove, and clear cart items from chat via the JSON cart endpoints.
- Return a language-aware checkout URL for the current cart.
- Issue an HMAC-signed user-identity token to the widget for logged-in shoppers.
- Track chat-attributed conversions via an `order.completed` webhook on order placement.
- Answer order-status lookups from the assistant through a signed order-tracking endpoint.
- Map product fields to categories (with taxonomy hierarchy paths), brands, images, and attributes.
- Auto-detect category, brand, image, stock, and attribute fields on install.
- Restrict which product types and content bundles are synced.
- Set minimum/maximum order quantities per variation via configured fields.
- Customize sync behavior, payloads, channels, prices, and cart operations through alter hooks.
- Provide custom order-tracking data from an ERP via `hook_emporiqa_order_tracking_alter()`.
- Monitor and drain the webhook queue (`emporiqa_webhook`) via cron or `drush queue:run`.
