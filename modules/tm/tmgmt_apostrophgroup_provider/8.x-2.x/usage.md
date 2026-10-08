<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Apostroph Group Translator is a TMGMT translator plugin that packages a translation job's content as XLIFF inside a ZIP, sends it to the Apostroph Group myApostroph REST service, and later imports the finished translation back into Drupal.

---

The problem it solves is connecting Drupal's Translation Management Tool (TMGMT) to Apostroph's professional translation ERP. On request (`ApostrophTranslator::requestTranslation`), each job item is exported to XLIFF via the module's `AXliff` exporter, zipped, registered as a managed file, and POSTed to the provider through a Swagger-generated REST client (`src/Restclient/Api/TranslationApi.php`) using HTTP Basic authentication (`Authorization: Basic base64(user:pass)`). The returned translation id is stored as the job reference. Deliveries are pulled back either on cron (`tmgmt_apostrophgroup_provider_cron`, per-translator toggle) or via a manual "semi import" form submit; a 200 response body is base64-decoded, gunzipped, and imported through the XLIFF importer with job-id validation. Job deletion/abort calls the provider's cancel endpoint.

Operational/security notes: outbound calls use Guzzle with **TLS verification left at Guzzle's secure default** (no `verify => false` anywhere) and the API is documented as HTTPS + Basic auth. There is **no inbound webhook/callback route** — the module is purely outbound plus cron polling, so there is nothing anonymous to trigger. Two things to configure carefully: (1) the connector credentials (`apostroph-settings.username` / `password`) are stored in the `tmgmt_translator` config entity as **plaintext** (standard for TMGMT providers, but treat exported config as sensitive); (2) the default file `scheme` is `public`, so exported source ZIP/XLIFF files — and the download link surfaced in a status message — land under the public files directory and are reachable by anyone who knows/guesses the URL; switch the translator's scheme to `private` for confidential content (an `is_confidential` flag exists). Typical setup: add an Apostroph translator under TMGMT, enter the service URL/username/password and customer id, optionally enable cron delivery, then submit jobs.
---
- Add an Apostroph Group translator provider under TMGMT.
- Enter the myApostroph REST service URL and Basic-auth credentials.
- Set the Apostroph customer id used to route each order.
- Submit a TMGMT job to Apostroph as a zipped XLIFF package.
- Export all job items into a single XLIFF file per job.
- Export each job item into its own XLIFF file in the ZIP.
- Store the remote translation id as the TMGMT job reference.
- Enable per-translator cron to auto-import finished deliveries.
- Manually pull a delivery for one job via the semi-import form.
- Import a translated XLIFF uploaded by hand through the import form.
- Validate that an imported file's job id matches the local job.
- Cancel a remote Apostroph job when deleting a TMGMT job.
- Abort an in-flight translation job on the provider.
- Switch the file scheme to `private` for confidential source content.
- Flag a job as confidential via the is_confidential setting.
- Retry the send up to three times on transient API errors.
- Log request payloads and responses to the Drupal log for debugging.
- Map Drupal source/target languages to Apostroph remote languages.
- Download the exported ZIP from the status-message link.
- Clean up temporary export directories after a failed send.
