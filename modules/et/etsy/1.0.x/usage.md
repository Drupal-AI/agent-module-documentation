<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Etsy API is a base module that wraps the Etsy v3 REST API as a Drupal service (`etsy.api`) for integrating a single Etsy shop, authenticated over OAuth2.

---

By itself this module does nothing user-facing: it exposes the Etsy API to Drupal so other modules and custom code can read shop, listing, section, receipt, transaction and taxonomy data from one configured Etsy shop. Requests are made with Guzzle against `https://openapi.etsy.com/v3/application/`, sending the OAuth2 access token as a Bearer header and the client id as the `x-api-key` header. The OAuth2 authorization code (with PKCE) flow, the Client ID (keystring) / Client Secret (shared secret) entry, and token storage are handled by the required `drupal/oauth2_client` module through an `Oauth2Client` plugin this module supplies (`etsy`); this module's own configuration holds only the shop id and a cache lifetime. Results can be cached for a configurable window to stay within Etsy's rate limits, and a `hook_cron` ping keeps the OAuth2 token alive. The companion Etsy Shop submodule is the reference implementation that turns this data into Drupal nodes. No checkout/ecommerce is included, to comply with the Etsy API terms of service.

---

- Expose the Etsy v3 API to Drupal as an injectable service (`etsy.api`).
- Integrate a single Etsy shop with a Drupal site.
- Authenticate to Etsy over OAuth2 (authorization code + PKCE) via oauth2_client.
- Fetch shop information for the configured shop (`shopInfo()`).
- Fetch a single shop property (e.g. currency, announcement) by key.
- List a shop's listings with limit/offset/includes/state (`getListingsByShop()`).
- Load one listing by id (`getListingById()`), optionally with images/videos.
- Read a listing's properties (`getListingProperties()`).
- Read a listing's transactions (`getListingTransactions()`).
- Read shop sections (`getShopSections()`).
- Read shop receipts, all or by receipt id (`getShopReceipts()`).
- Read buyer/seller taxonomy trees and property scales (`getTaxonomy()`).
- Ping the Etsy API to verify connectivity (`ping()`).
- Get the authenticated user's basic info (`getMe()`).
- Cache API responses for 1/2/6/12/24 hours to respect rate limits.
- Configure the shop id and cache lifetime at `/admin/config/services/etsy`.
- Exercise every API method interactively from the admin test form.
- Build custom Etsy integrations by depending on this module.
- Provide the base other Etsy modules (Etsy Fields, Etsy Shop) require.
- Keep the Etsy OAuth2 token alive automatically via cron ping.
- Display the Etsy-required trademark notice with a ready-made block.
- Restrict configuration to trusted admins via `administer etsy settings`.
- Surface Etsy connectivity status on the site status report.
