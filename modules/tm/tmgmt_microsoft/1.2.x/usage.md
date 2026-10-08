<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Microsoft Translator is a TMGMT (Translation Management Tool) translator plugin that submits translation jobs to the Microsoft Azure Cognitive Services Translator Text API, returning machine translations for Drupal content.

---

The module adds a TMGMT translator plugin (`@TranslatorPlugin(id = "microsoft")`) implementing the
continuous-translator interface, configured as a TMGMT translator entity under *Translation ›
Providers* (`entity.tmgmt_translator.collection`). Its settings form asks for a single **Azure API
Key** (`api_key`, required) and offers TMGMT's standard "auto accept" toggle; a Connect button
validates the key by requesting an auth token. At request time the plugin exchanges the subscription
key for a short-lived JWT via the Azure token endpoint (`Ocp-Apim-Subscription-Key`), then POSTs each
translatable text segment to the Translator v3 `/translate` endpoint (`textType=html`, source/target
languages mapped from Drupal langcodes, e.g. `zh-hans`→`zh-CHS`) using the Guzzle HTTP client. Text is
sent as HTML with non-translatable spans (`<span class="notranslate">…</span>`) protecting untranslatable
segments; a per-segment max of 50,000 characters is enforced. Supported target languages are fetched
live from the `/languages` endpoint. The Azure endpoints (`token url`, `translate url`) are hardcoded
plugin defaults. A test submodule (`tmgmt_microsoft_test`) exists only for the module's automated tests.

---

- Machine-translate Drupal content through Azure Translator inside TMGMT workflows.
- Add Microsoft as a translation provider alongside other TMGMT translators.
- Configure the provider with an Azure Cognitive Services API key.
- Validate the API key with the provider's Connect button before use.
- Translate nodes, taxonomy, or any TMGMT-supported entity to another language.
- Run continuous translation jobs that auto-submit new/changed content.
- Auto-accept returned translations via the TMGMT "auto accept" option.
- Preserve markup by sending content as HTML to the translator.
- Protect specific text from translation with `notranslate` spans.
- Discover which target languages Azure supports for a given source language.
- Map Drupal langcodes to Azure equivalents (e.g. Simplified/Traditional Chinese).
- Enforce Azure's per-request character limit (50k) at the job-item level.
- Compare Microsoft output with other providers by adding multiple TMGMT translators.
- Localize a multilingual site's content at scale via a paid Azure subscription.
- Bulk-translate a backlog of content through TMGMT job queues.
- Provide draft machine translations for human post-editing in TMGMT.
- Switch translation providers per job by selecting the Microsoft translator.
- Integrate Azure translation without writing custom API code.
- Route translation requests through the site's configured Guzzle HTTP client.
- Report unavailable provider status when the key is missing or invalid.
