Convivial Enricher performs progressive profiling: a visitor arriving on a configured public endpoint path with a token has their external-service contact data fetched and written into browser cookies for downstream profile tools to read.

---

The module defines an `enricher` configuration entity (managed at `/admin/config/convivial/enricher`, permission `administer enricher`). Each enricher owns an `endpoint_path` and an ordered list of datasource plugins. Saving an enricher rebuilds routes so its endpoint path becomes a live, publicly reachable route handled by `EnricherController`. When a request hits that path, an inbound path processor lets each datasource rewrite the incoming URL into a base64 `data:` string carrying a `token` and a `return_to`; the controller decodes it, calls each datasource's `fetchAndProcessData($token)`, collects the returned `Symfony\Component\HttpFoundation\Cookie` objects, attaches them to a temporary (HTTP 307) redirect to `return_to`, and returns it. Datasources are `EnricherDatasource` plugins (plugin manager `plugin.manager.enricher.datasource`, base class `EnricherDatasourceBase`, discovered under `Plugin/EnricherDatasource`). Core ships a `dummy` datasource for testing; the packaged submodules add `active_campaign` (ActiveCampaign REST via Guzzle, with allow-lists, opt-in privacy flag, and tuneable caching), `mailchimp` (via the contrib Mailchimp client), and `recombee_user_merge` (merges the Recombee cookie user with the enricher user via the Recombee SDK). Datasources filter which contact properties/tags/fields become cookies using `fnmatch()` allow-lists, and every emitted cookie is named `convivial_enricher_<name>`. Requires Convivial Core. Maintained by Morpht.

---

- Enable progressive profiling so anonymous visitors are gradually identified from external CRM/ESP data.
- Personalise landing pages by enriching the visitor from data behind an email-campaign click-through link.
- Read a unique subscriber identifier from an email link and pull the matching contact record into cookies.
- Create an enricher config entity with its own public endpoint path under `/admin/config/convivial/enricher`.
- Attach one or more datasource plugins to a single enricher and order them by weight.
- Use the bundled `dummy` datasource to test the endpoint/cookie flow without a real backend.
- Integrate ActiveCampaign: look up a contact by email hash and expose its properties, tags and custom fields.
- Restrict which ActiveCampaign contact properties, tags and fields may be stored using shell-wildcard allow-lists.
- Honour an ActiveCampaign contact opt-in property as a privacy flag before writing any cookie (GDPR-style consent gate).
- Tune ActiveCampaign API caching per call type (account tags, contact tags, contact) to stay within rate limits.
- Integrate Mailchimp: fetch a list member by unique id and expose allow-listed member properties and namespaced tags.
- Split Mailchimp `namespace/tag` values into per-namespace cookies for downstream segmentation.
- Integrate Recombee: merge the anonymous Recombee cookie user with the identified enricher user for recommendations.
- Set a Recombee client-id prefix and cookie name so the merged user id is written back as a long-lived cookie.
- Feed the resulting `convivial_enricher_*` cookies to profile/personalisation tools such as Basil.
- Write a custom `EnricherDatasource` plugin to enrich from any in-house or third-party backend.
- Provide allow-listed contact segmentation data to front-end A/B testing or content-targeting logic.
- Redirect the visitor transparently to their originally requested page after enrichment completes.
- Cache external API responses to reduce third-party API calls and improve response times.
- Grant the powerful `administer enricher` permission only to trusted roles that manage integrations.
- Diagnose enrichment problems from the site's recent log messages (datasource exceptions are logged, not surfaced).
