<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google cloud batch translation integrates TMGMT with the Google Cloud Translation API, translating TMGMT job content in batches. It is a TMGMT translator plugin configured under the translator collection.

---

The GoogleBatchTranslator plugin sends source text to Google's Translation endpoint, authenticating with an API key stored in the translator settings (passed as the "key" query parameter). The endpoint URL is configurable, and the plugin validates the API key during configuration. Requests use the core http client with default TLS verification.

Use it for automated machine translation of content managed through TMGMT, where large jobs benefit from batch processing. The Google API key is entered in the translator settings form; there are no inbound callback routes — results are fetched synchronously through the provider flow.

---

- Machine-translate TMGMT jobs via Google.
- Batch-translate source content.
- Authenticate with a Google API key.
- Configure a custom Google endpoint URL.
- Validate the API key during setup.
- Store credentials in the translator entity.
- Integrate Google Translation into TMGMT.
- Automate translation without human LSPs.
- Use the standard Translation providers UI.
- Pass the API key as a query parameter.
- Use Guzzle with default TLS verification.
- Handle large translation jobs efficiently.
- Map source/target languages to Google codes.
- Fit continuous localization workflows.
- Avoid custom Google API code.
- Fetch results through the TMGMT flow.
- Support many language pairs.
- Provide fast, low-cost machine translation.
