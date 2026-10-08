<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Yandex Translator integrates TMGMT with the Yandex Translate API for automated machine translation of TMGMT job content. It is a TMGMT translator plugin configured under the translator collection.

---

The YandexTranslator plugin calls the Yandex Translate JSON API (getLangs, translate) over the core http_client, passing an API key from the translator settings as the "key" query parameter. The endpoint base can be overridden by a "url" setting; responses are JSON-decoded and mapped back onto job items. Requests use Guzzle with default TLS verification.

Use it for fast, automated translation where a human LSP is not required. The Yandex API key is stored in the translator settings form; there are no inbound callback routes — translations are fetched synchronously through the standard TMGMT provider flow.

---

- Machine-translate TMGMT jobs via Yandex.
- Fetch supported languages (getLangs).
- Translate job items through the API.
- Authenticate with a Yandex API key.
- Pass the key as a query parameter.
- Override the API base URL if needed.
- Store credentials in the translator entity.
- Configure via the Translation providers UI.
- Decode JSON translation responses.
- Map translations back onto job items.
- Use Guzzle with default TLS verification.
- Automate translation without human LSPs.
- Support many language pairs.
- Drive translation through the TMGMT flow.
- Fit continuous localization pipelines.
- Avoid custom Yandex API code.
- Handle request errors gracefully.
- Provide low-cost machine translation.
