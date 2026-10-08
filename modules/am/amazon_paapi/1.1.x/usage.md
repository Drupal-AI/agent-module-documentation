Amazon PA-API is a lean developer helper that provides a credential-configured Amazon Product Advertising API 5.0 SDK client to Drupal.

---

The module wires the `thewirecutter/paapi5-php-sdk` library into Drupal and exposes one service, `amazon_paapi.amazon_paapi`, whose `getApi()` returns a ready-to-use SDK `DefaultApi` client already configured with the site's AWS access key, secret key, host, region and partner (associate) tag. It ships no product-display features of its own: developers build `GetItems`, `SearchItems`, `GetVariations` and `GetBrowseNodes` requests directly with the SDK's request classes and handle their own rendering and error handling. Credentials are entered on an admin settings form (or, alternatively, read from environment variables, which take precedence over stored config). An admin "Test ASIN" page runs a live `GetItems` request so integrators can confirm their credentials work and inspect a real response object. Both admin routes require the restricted `administer amazon paapi` permission. This is the factory/wrapper alternative to the heavier `amazon` contrib module, which bundles media, search and display features.

---

- Add the PA-API 5.0 PHP SDK to a Drupal project as a Composer-managed library with minimal glue.
- Get a credential-configured SDK `DefaultApi` client from a single service call, `\Drupal::service('amazon_paapi.amazon_paapi')->getApi()`.
- Store the AWS Access Key ID, Access Secret, Host, Region and Partner Tag in Drupal config via one admin settings form.
- Supply PA-API credentials through server environment variables instead of stored config for secret-management/12-factor setups.
- Override any single credential per environment (dev/stage/prod) with its matching `AMAZON_PAAPI_*` environment variable.
- Look up a single Amazon product by ASIN with a `GetItemsRequest`.
- Look up multiple ASINs in one batched `GetItems` call.
- Search Amazon's catalog by keywords, brand or category with a `SearchItemsRequest`.
- Fetch product variations (size/color children) with a `GetVariationsRequest`.
- Browse Amazon's category tree with a `GetBrowseNodesRequest`.
- Retrieve product titles, by-line/brand info and classifications for display.
- Retrieve primary and variant product images in small/medium/large sizes.
- Retrieve current offers: price, availability message, promotions, saving basis and Prime eligibility.
- Retrieve customer-review star rating and review count for a product.
- Generate affiliate detail-page URLs (containing your associate tag) for product links.
- Verify freshly entered PA-API credentials live from the admin "Test ASIN" page before writing code.
- Inspect the full SDK response object for a given ASIN (via `var_export`) while developing an integration.
- Provide a reusable service trait (`AmazonPaapiTrait`) so custom controllers, forms and services can lazily fetch the API client.
- Parse and log PA-API exceptions in a consistent format with the module's `logException()` helper.
- Build custom blocks, fields, Views field plugins or migrate sources on top of the SDK client for showing Amazon products.
- Restrict who can manage Amazon credentials and run test queries via the dedicated `administer amazon paapi` permission.
- Choose the correct Amazon marketplace/locale by setting the appropriate host and region values.
- Keep an affiliate site's product data current by querying PA-API on demand rather than caching stale catalog exports.
