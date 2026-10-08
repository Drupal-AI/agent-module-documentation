<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Engaging Networks exposes a single Drupal service that wraps the Engaging Networks Services (ENS) REST API so other code can read and write supporter, page, and question data on the Engaging Networks fundraising/advocacy platform.

---

The module ships one service, `engaging_networks.rest_api` (class `Drupal\engaging_networks\RestApi`), whose `getClient()` returns a configured `OpenPublicMedia\EngagingNetworksServices\Rest\Client` from the `openpublicmedia/engaging-networks-php` library. It has no entities, blocks, fields, or public endpoints of its own — it is a building block for custom modules that need to talk to ENS. An admin settings form at `/admin/config/engaging-networks/settings/rest-api` stores the API endpoint base URI and selects a Key module credential (authentication type) that holds the ENS API key; an optional advanced section enables caching of the session token in Drupal state and names the state cache keys. At runtime the client authenticates against the ENS `authenticate` endpoint with the stored key, reuses the returned `ens-auth-token` until it nears expiry, and offers typed helper methods (`getPage`, `getPages`, `processPage`, `getSupporterById`, `getSupporterByEmailAddress`, `addOrUpdateSupporter`, `getSupporterFields`, `getSupporterQuestion(s)`). The Key module is a hard dependency; there are no submodules or Drush commands. The project is marked unsupported / no further development on drupal.org.

---

- Add a Drupal integration with the Engaging Networks (ENS) REST API.
- Fetch a single Engaging Networks page by ID via `getClient()->getPage($id)`.
- List pages of a given type/status via `getPages(PageType, PageStatus)`.
- Submit a page request (e.g. a donation or advocacy action) via `processPage($id, $payload)`.
- Look up a supporter by ID via `getSupporterById()`.
- Look up a supporter by email via `getSupporterByEmailAddress()`.
- Create or update a supporter record via `addOrUpdateSupporter($email, $fields)`.
- Retrieve the list of available supporter fields via `getSupporterFields()`.
- Retrieve supporter questions / a single question via `getSupporterQuestions()` / `getSupporterQuestion($id)`.
- Store the ENS API key in a Key entity instead of hard-coding it in a custom module.
- Point the client at a specific ENS regional/data-center endpoint through configuration.
- Cache the ENS session token in Drupal state so it is reused across requests.
- Name custom state cache keys for the token and its expiry.
- Override endpoint/key/cache settings from `settings.php` (the form disables overridden fields).
- Build custom donation or advocacy forms in Drupal that post to ENS.
- Sync Drupal user or webform submissions into ENS supporter records.
- Enrich Drupal content with live campaign/page data pulled from ENS.
- Restrict configuration to trusted admins via the "administer engaging networks" permission.
- Inject the `engaging_networks.rest_api` service into custom controllers, forms, or queue workers.
- Handle ENS "not found" (204/404) responses through the library's `NotFoundException`.
- Handle other API failures through the library's `RequestException` / `RuntimeException`.
- Migrate existing supporter data into ENS in batches from a custom Drupal process.
- Drive scheduled (cron/queue) supporter upserts to ENS from Drupal.
