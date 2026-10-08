<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Trustpilot API provides a Trustpilot HTTP client as a Drupal service, for developers whose modules need to read reviews, ratings and categories from Trustpilot or push data to its private endpoints.

---

This is a developer tool, not a site-builder feature: it ships **no blocks, fields or display** of any kind, only the service `trustpilot_api.client` that other code consumes. Install it like any module, then visit **Configuration → Web Services → Trustpilot API Settings** (`/admin/config/services/trustpilot-api`, needs *administer site configuration*) and provide an **API Key** — enough for the public endpoints — plus, for private endpoints, an **API Secret**, **OAuth email** and **OAuth password**; you can also set a default **Business Unit ID**, a connect timeout, and a logging toggle. The form recommends keeping the key and secrets **out of exported config** by overriding them in `settings.php` (for example `$config['trustpilot_api.settings']['api_key'] = getenv('TRUSTPILOT_API_KEY');`). Each Trustpilot endpoint is an `@Endpoint` annotation plugin (26 are bundled, covering business-unit reviews/search/profile, categories, consumer and product reviews, plus a few OAuth-only `private/*` ones); from code you `createInstance()` the endpoint you want and call `$client->request($endpoint, $params)`, which returns the decoded JSON as a PHP array. For OAuth endpoints the client runs Trustpilot's password-grant token exchange and caches the access token itself. A **Test** form and per-endpoint test pages let you exercise any endpoint from the UI. Because reviews live with the platform rather than the site, treat display as a caching-and-availability problem — fetch on a schedule, cache the result, and decide what shows when the data is stale.

---

- Provide a Trustpilot API client service to a custom module.
- Read a business unit's reviews from code.
- Fetch a business's overall rating and review count.
- Search Trustpilot for a business unit.
- Pull a business unit's profile info or company logo.
- List Trustpilot categories and the businesses in them.
- Fetch consumer reviews or a consumer profile.
- Read imported product reviews and their summaries.
- Access private reviews via OAuth-authenticated endpoints.
- Upsert products to Trustpilot via a private endpoint.
- Set a default Business Unit ID once and reuse it per request.
- Keep API credentials in settings.php via a config override.
- Register a custom `@Endpoint` plugin for an endpoint not yet bundled.
- Cache fetched review data before displaying it on a page.
- Fetch ratings on a schedule with cron/queue and store the result.
- Test any endpoint from the admin Test form before wiring up code.
- Enable request logging to debug API calls to the `trustpilot_api` channel.
- Tune the HTTP client connect timeout for slow responses.
- Build a review carousel or star-rating block on top of the client.
- Send the API key as an `apiKey` header without writing HTTP code yourself.
