<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Poster integration

Connects Drupal Commerce to Poster (joinposter.com). Admins import Poster categories and products (creating Commerce product types, variations, taxonomy terms and images), and when an order is placed the module sends an 'incoming order' to Poster's API. All API calls go to the fixed `https://joinposter.com/api/` endpoint using an access token from configuration.

---

# Installing & configuring

- Enable the module (requires Commerce, Commerce Product, Commerce Order).
- Configure at `/admin/commerce/config/poster_integration` (permission `setup poster integration`): access token, spot id, and whether to send orders.
- Use the Load categories / Load products forms to import from Poster.
- Enable 'Collect billing information' on the gateway so order push has address data.

---

- `PosterConnection::makeRequest()` calls Poster over HTTPS via Drupal's `httpClient` (Guzzle) with default TLS verification (not disabled).
- The API endpoint is a hard-coded constant.
- The token is stored in `poster_integration.settings` config (not a Key entity).
- `OrderCompleteSubscriber` listens on `commerce_order.place.post_transition` and pushes the order when `send_orders` is on.
- Order push sends billing name/address and product SKUs + quantities to Poster.
- `PosterController::getProducts()` (permission `setup poster integration`) lists Poster products vs local variations.
- Import forms create Commerce product/variation types, taxonomy vocabulary `categories`, and fields via install config.
- `LoadHelper::saveFileToField()` downloads product images with `file_get_contents($url)` where `$url` comes from the Poster API response during an admin-triggered import (trusted source, validated with `UrlHelper::isValid`).
- All routes require the `setup poster integration` permission.
- A `PhoneValidator` service validates phone numbers for order data.
- Errors from the Poster API are logged/messaged to the admin.
- A workflow file defines an order workflow for the integration.
- No anonymous or low-privilege endpoints are exposed.
- Suited to restaurants/retailers syncing a Poster POS catalog with a Commerce store.
- Hardening: move the access token to a Key entity and pass it as a header rather than in the URL.
