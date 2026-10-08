<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OECD GlobalRecalls API publishes product-recall notices held as Drupal nodes to the OECD GlobalRecalls portal, and lets editors search and delete recalls on that portal by ID.

Configure the API key, host (production vs testing) and field mapping at `/admin/config/services/psa-oecd-publishing` (`OecdPublishingSettingsForm`, permission `administer psa_oecd_publishing`). The `oecd_api.recall` service (`OecdApi`) talks to the portal over HTTPS: `ping()` validates the key, `post()` uploads a ZIP archive of a recall to the `ws/import.xqy` endpoint (API key as an `apikey` query parameter), and `get()` fetches a recall's JSON. A mapper turns a recall node into the OECD `OecdApiRecall` structure; publishing is queued through the `OecdPublisherQueueWorker`. Editor-facing routes — a "publish needed" list, a search-by-ID form, and a confirm-delete form — are all gated by the `use psa_oecd_publishing` permission. Drush commands are provided for headless/cron publishing.

Security/operational notes: the actual transport URL is built as `https://{host}/…` (production or testing host from config), so the API key and payloads travel over TLS; the `OECD_API_URL_RECALL_URI` `http://…` constant is only an identifier embedded in a recall's path, not a fetch target. All web routes require a permission (`administer` or `use`); the delete route additionally uses a confirm form. No anonymous, unauthenticated, or `_access: TRUE` endpoints. The API key is stored in module config — ensure config is protected/keyed per your policy.
---
Publish product-recall nodes to the OECD GlobalRecalls portal and search/delete recalls by ID.
---
- Store the OECD API key and host at `/admin/config/services/psa-oecd-publishing`.
- Switch between the OECD production and testing hosts in config.
- Ping the OECD endpoint to validate the API key and connection.
- Map recall node fields to OECD GlobalRecalls fields.
- Publish a recall node as a ZIP archive to the OECD import API.
- Queue recall publishing via the `OecdPublisherQueueWorker`.
- List recalls that still need publishing (`publish-needed` route).
- Search a recall on the portal by recall ID.
- Delete a recall on the portal (confirm form) by lang/jurisdiction/ID.
- Fetch a recall's JSON representation via `OecdApi::get()`.
- Grant `use psa_oecd_publishing` to editors who publish/search/delete.
- Grant `administer psa_oecd_publishing` to admins managing settings.
- Run publishing headlessly with the provided Drush commands.
- Schedule recall publishing from cron via the queue.
- Confirm the API connection before a publishing run.
- Review the field-description references for country-id and recall fields.
- Handle 404s from the portal (treated as a missing recall).
- Restrict the module's config so the stored API key stays protected.
