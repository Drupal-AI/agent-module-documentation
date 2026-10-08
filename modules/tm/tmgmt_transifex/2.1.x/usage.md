<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Transifex Connector integrates TMGMT with the Transifex localization platform: it pushes source resources to Transifex and pulls translations back, and it exposes a webhook so Transifex can notify Drupal when translations are updated. It is a TMGMT translator plugin, configured under the translation providers (translator) collection.

---

The TransifexTranslator plugin syncs resources and translations with Transifex's REST API, and a route `/tmgmt_transifex_callback` (TransifexController::callback) receives Transifex webhooks. The callback verifies the request against the translator's stored webhook secret before applying any update: requests are ignored when the secret is unset, when required `X-TX-*`/`Date` headers are missing, when the signature does not match, or when the payload does not carry the expected `event`/`resource`/`language` fields. Only a verified webhook triggers `updateJobWithTranslations`, and whether it fires also depends on the event type and the *only reviewed* setting. The translator settings hold the Transifex API token, the project URL, the webhook secret and the only-reviewed flag; the API host defaults to `https://rest.api.transifex.com` and can be overridden per environment with `$settings['tmgmt_transifex.endpoint']`.

---

- Sync TMGMT resources with Transifex.
- Push source content to Transifex (one resource per job item).
- Pull completed translations back into TMGMT jobs.
- Receive translation-updated webhooks from Transifex.
- Verify webhooks with the stored webhook secret before applying them.
- Ignore webhooks with missing headers, an invalid signature, or an unexpected payload.
- Gate webhook updates on the event type and the only-reviewed setting.
- Store the API token, project URL and webhook secret in translator settings.
- Configure via the Translation providers UI.
- Support continuous localization workflows.
- Map Drupal languages to Transifex languages.
- Update jobs automatically on verified webhooks.
- Drive translation through the standard TMGMT flow.
- Integrate Transifex as the TMS.
- Override the API endpoint per environment via settings.
- Fit large multilingual sites.
- Automate translation refreshes.
